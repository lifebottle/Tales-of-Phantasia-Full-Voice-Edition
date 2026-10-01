#!/usr/bin/env python3
# -*- coding=utf-8 -*-

import re
import struct

from pathlib import Path
from io import BytesIO
from itertools import groupby
from dataclasses import dataclass

from libs.insertor import convert_string
from libs.linewrap import TextWrapper
from libs.util import get_symbols, paths, logger
from translate.storage import xliff

out_dir = paths['out']
target_dir = paths['target'] / 'skits'
num_skits = 258

wrapper = TextWrapper()
syms = get_symbols()

eboot_base = 0x08803FA0
text_base = syms.get('custom_file_offset')
reloc_base = 0x8804000
skit_event_ptr_tbl = 0x08bede74
skit_prompt_ptr = None

@dataclass
class SpaceBlock:
    filename: str
    start: int
    end: int
    pointer_base: int

    def __post_init__(self):
        if self.start >= self.pointer_base:
            self.start -= self.pointer_base
            self.end -= self.pointer_base

    @property
    def free_space(self):
        return self.end - self.start

    def __repr__(self):
        return f'SpaceBlock(filename="{self.filename}", start=0x{self.start:X}, end=0x{self.end:X},size={self.free_space})'

    def reserve_bytes(self, num_bytes, align_word=True):
        if num_bytes >= self.free_space:
            return None

        block_addr = self.start
        self.start += num_bytes

        if align_word:
            if padding := (self.start + self.pointer_base) % 4:
                self.start += 4 - padding

        return block_addr

@dataclass
class QueueItem:
    filename: str
    offset: int
    data: bytes
    comment: str = ''

    def __repr__(self):
        return f'QueueItem(filename="{self.filename}", offset=0x{self.offset:x}, size={len(self.data)}, comment="{self.comment}")'

class SpaceAllocator:
    blocks = None
    queue = None
    current_block = None

    def __init__(self, blocks):
        self.blocks = [SpaceBlock(*x) for x in blocks]
        self.queue = []
        self._get_space = (x for x in self.blocks)
        self.current_block = self.get_free_block()

    def get_free_block(self):
        block = next(self._get_space)
        return block

    @property
    def current_file(self):
        return self.current_block.filename

    @property
    def current_offset(self):
        return self.current_block.start

    @property
    def pointer_base(self):
        return self.current_block.pointer_base

    def add(self, buf, comment=''):
        pos = self.current_block.reserve_bytes(len(buf))

        if pos is None:
            try:
                self.current_block = self.get_free_block()
                logger.debug(f'ran out of space, switching to {self.current_file} @ {self.current_offset:X}')
                pos = self.current_block.reserve_bytes(len(buf))
            except StopIteration:
                logger.error('data overflowed')
                return None

        self.queue += [QueueItem(self.current_file, pos, buf, comment)]
        return pos

    def flush_data(self):
        for fname, chunks in groupby(self.queue, lambda x: x.filename):
            with open(Path(out_dir, fname), 'r+b') as out:
                for chunk in sorted(chunks, key=lambda x: x.offset):
                    logger.debug(f'inserting block in {chunk.filename} @ {chunk.offset:X}')
                    out.seek(chunk.offset)
                    out.write(chunk.data)

# re-use upper half of old map buffer
max_size = 0x60000 - 0x35000

dat_pos = Path(out_dir, 'julian.dat').stat().st_size

if padding := dat_pos % 4:
    dat_pos += 4 - padding

# reserve space for skit event pointers
dat_pos += 4 * num_skits

free_space = [
    # old logos (43156 bytes)
    ('EBOOT.BIN', 0x089634b8, 0x0896dd4c, eboot_base),
    # old item descriptions (12300 bytes) - updated
    ('EBOOT.BIN', 0x08974000, 0x08976a90, eboot_base),
    # cover images leftover space (27568 bytes)
    ('EBOOT.BIN', 0x089b6000, 0x089bcbb0, eboot_base),
    # original skits (77480 bytes)
    ('EBOOT.BIN', 0x08bdafc8, 0x08bede74, eboot_base),
    # topfve_prx_title_descs_jap.txt (3831 bytes)
    ('EBOOT.BIN', 0x8957dd8, 0x8958ccf, eboot_base),
    # topfve_prx_items_jap.txt (2088 bytes)
    ('EBOOT.BIN', 0x8976db0, 0x89775d8, eboot_base),
    # topfve_prx_misc_jap.txt (1113 bytes)
    ('EBOOT.BIN', 0x8bd8d30, 0x8bd9185, eboot_base),
    # topfve_prx_misc2_jap.txt (3845 bytes)
    ('EBOOT.BIN', 0x8bd9478, 0x8bda37d, eboot_base),
    # topfve_prx_grade_shop.txt (1154 bytes)
    ('EBOOT.BIN', 0x8c27b14, 0x8c27f96, eboot_base),
    # topfve_prx_mon_name.txt (2300 bytes)
    ('EBOOT.BIN', 0x8c08cd8, 0x8c095d4, eboot_base),
    # topfve_prx_shop_name.txt (1364 bytes)
    ('EBOOT.BIN', 0x8bbd38c, 0x8bbd8e0, eboot_base),
    # topx_prx_credits.txt + old credits meta (4952 bytes)
    ('EBOOT.BIN', 0x08bd698c, 0x08bd8b2c, eboot_base),
    # put remainder in our custom file
    # ('julian.dat', dat_pos, max_size, text_base),
]

allocator = SpaceAllocator(free_space)

skit_text_ptr_tables = syms.get('skit_text_block_ptrs')

if skit_text_ptr_tables is None:
    raise SystemExit('Fatal error: symbols missing')

def read_xlf(fname):
    buf = Path(fname).read_bytes()
    xliff_file = xliff.xlifffile(buf)
    return [x.target for x in xliff_file.units]

def process_block(fname, want_wrap=False):
    logger.info(f"Inserting {fname}...")

    strings = [x + '{END}' for x in read_xlf(fname)]
    pointers = []
    block = BytesIO()
    block.write(b"\x00" * len(strings) * 2)

    seen = {}

    for num, s in enumerate(strings):
        s = re.sub(r'<wait_[\dA-F]{2}>', '', s)

        if want_wrap:
            s = wrapper.wrap_subs(s)

        s = convert_string(s, True)

        if found := seen.get(s):
            pointers += [found]
            continue

        pointers += [block.tell()]
        seen[s] = block.tell()
        block.write(s)

    pointers = [struct.pack('<H', x) for x in pointers]

    block.seek(0)
    block.write(b''.join(pointers))

    buf = block.getvalue()
    block.close()

    return buf

def insert_skits():
    global skit_prompt_ptr

    skit_block_ptrs = []

    # insert skit text
    files = list(sorted(target_dir.glob('*.xlf')))
    assert len(files) == num_skits

    for block in files:
        want_wrap = 'skits' in block.parts
        buf = process_block(block, want_wrap)
        cur_pos = allocator.add(buf, comment=block)

        if cur_pos is None:
            raise SystemExit('Ran out of space')

        base_addr = allocator.pointer_base
        logger.debug(f'Inserting {block} @ {cur_pos:X} ({cur_pos + base_addr:X})')
        skit_block_ptrs += [cur_pos + base_addr]

    # insert skit events
    events_dir = Path(out_dir, 'skits')
    files = sorted(events_dir.glob('*.bin'))
    event_ptrs = []

    for fname in files:
        logger.info(f'Inserting {fname}')
        buf = fname.read_bytes()
        cur_pos = allocator.add(buf, comment=fname)
        base_addr = allocator.pointer_base

        logger.debug(f'Inserting {fname} @ {cur_pos:X} ({cur_pos + base_addr:X})')
        event_ptrs += [cur_pos + base_addr]

    # write pointers
    with open(out_dir / 'julian.dat', 'r+b') as out:
        out.seek(0, 2)

        if padding := out.tell() % 4:
            out.write(b'\x00' * (4 - padding))

        block_ptr_tbl = out.tell()
        logger.debug(f'pointer tables @ {block_ptr_tbl:X} in julian.dat (RAM: {block_ptr_tbl + text_base:X})')

        # write text block pointers
        skit_block_ptrs = [struct.pack('<I', x) for x in skit_block_ptrs]
        out.write(b''.join(skit_block_ptrs))

        # write block pointer
        out.seek(skit_text_ptr_tables - text_base)
        out.write(struct.pack('<I', block_ptr_tbl + text_base))

    # write event pointers
    with open(out_dir / 'EBOOT.BIN', 'r+b') as out:
        out.seek(skit_event_ptr_tbl - eboot_base)
        event_ptrs = [struct.pack('<I', x - reloc_base) for x in event_ptrs]
        out.write(b''.join(event_ptrs))

    # write queued data
    allocator.flush_data()

if __name__ == '__main__':
    insert_skits()
