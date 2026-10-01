#!/usr/bin/env python3
# -*- coding=utf-8 -*-

import struct
import re

from pathlib import Path
from dataclasses import dataclass
from collections import OrderedDict

from loguru import logger
from pprint import pprint

eboot_base = 0x08803FA0
reloc_base = 0x8804000

@dataclass
class BlockPointer:
    hi: int
    lo: int
    offset: int = 0

    def __post_init__(self):
        if self.hi >= 0x08000000:
            self.hi -= eboot_base
            self.lo -= eboot_base

    def __repr__(self):
        return f'BlockPointer(0x{self.hi + eboot_base:X}, 0x{self.lo + eboot_base:X})'

prx_psp = [
    ('topfve_prx_battle_jap.txt', 0x401ef8, 12, 'jap-full'),
    ('topfve_prx_title_descs_jap.txt', 0x153d74, 98, 'jap-full'),
    ('topfve_prx_item_descs_jap.txt', 0x16ddd0, 400, 'jap-full'),
    ('topfve_prx_titles_jap.txt', 0x154df8, 98, 'jap'),
    ('topfve_prx_items_jap.txt', 0x172AF0, 400, 'jap'),
    ('topfve_prx_misc_jap.txt', 0x3d4c1c, 184, 'jap'),
    ('topfve_prx_misc2_jap.txt', 0x3d5380, 172, 'jap-full'),
    ('topfve_prx_cook_help.txt', 0x155640, 26, 'jap-full'),
    ('topfve_prx_cook_name.txt', 0x1562bc, 26, 'jap'),
    ('topfve_prx_cook_msg.txt', 0x155bf8, 34, 'jap-full'),
    ('topfve_prx_grade_shop.txt', 0x423b18, 46, 'jap-full'),
    ('topfve_prx_mon_mes.txt', 0x4049c8, 24, 'jap-full'),
    ('topfve_prx_mon_name.txt', 0x404b38, 256, 'jap'),
    ('topfve_prx_shop_name.txt', 0x3b9354, 76, 'jap-full'),
    ('topfve_prx_opr08.txt', 0x3b44d8, 12, 'jap'),
    ('topfve_prx_opr14.txt', 0x3b4570, 12, 'jap-full'),
    ('topfve_prx_spc08.txt', 0x3bacf0, 112, 'jap'),
    ('topfve_prx_spc12.txt', 0x3bb130, 54, 'jap-12'),
    ('topfve_prx_spc14.txt', 0x3bb2a0, 54, 'jap-full'),
    ('topfve_prx_spc_help.txt', 0x3b9af0, 112, 'jap-full'),
    ('topfve_prx_misc3.txt', 0x401dc8, 42, 'jap'),
    ('topfve_prx_main_menu.txt', 0x3d5358, 8, 'jap-12'),
]

def find_pointer(rom, addr, mode = 0):
    logger.debug(f'{addr+eboot_base=:X}')
    if mode == 1:
        pointer = struct.pack("<H", (addr - (reloc_base - eboot_base)) & 0xFFFF)
    else:
        pointer = struct.pack("<I", addr - (reloc_base - eboot_base))

    results = [x.start() for x in re.finditer(re.escape(pointer), rom) if x.start() % 4 == 0]

    if mode == 0:
        out = [BlockPointer(x + 2, x) for x in results]
        return out

    out = []

    for pos in results:
        tmp = struct.unpack_from("<I", rom, pos)[0]
        op = tmp >> 26

        # 0x09 = addiu, 0x23 = lw, 0x24 = lbu, 0x25 = lhu
        if op not in [0x09, 0x23, 0x24, 0x25]:
            continue

        rs = (tmp >> 21) & 0x1F
        hi = ((addr + eboot_base - reloc_base) >> 16) & 0xFFFF
        lo = (addr + eboot_base -reloc_base) & 0xFFFF
        logger.debug(f'{pos + eboot_base=:X}')
        logger.debug(f'{op=:X}')
        logger.debug(f'{rs=:X}')
        logger.debug(f'{hi=:X}')
        logger.debug(f'{lo=:X}')

        if lo >= 0x8000:
            hi += 1

        for i in range(0, 36, 4):
            # check for LUI
            tmp = struct.unpack_from("<I", rom, pos - i)[0]
            logger.debug(f'{pos - i + eboot_base=:X}')
            logger.debug(f'{tmp=:X}')
            if tmp >> 26 != 0x0F:
                continue

            imm = tmp & 0xFFFF
            rt = (tmp >> 16) & 0x1F

            logger.debug(f'{hi=:X}')
            logger.debug(f'{imm=:X}')

            if (imm == hi) and (rs == rt):
                out += [BlockPointer(pos - i, pos)]
                break

    return out

def audit_pointers():
    buf = Path('EBOOT.BIN').read_bytes()

    block_pointers = {}

    for fname, offset, count, *rest in prx_psp:
        offset += count * 2
        logger.info(f'checking {fname} @ {eboot_base + offset:X}')

        ptrs = find_pointer(buf, offset, 1)
        ptrs += find_pointer(buf, offset)

        if ptrs:
            # block_pointers[f'{fname} @ 0x{eboot_base + offset:X}'] = ptrs
            block_pointers[fname] = ptrs

    pprint(block_pointers)

if __name__ == '__main__':
    audit_pointers()
