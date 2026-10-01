#!/usr/bin/env python

import struct

from pathlib import Path
from loguru import logger

import click

def get_chunks(buf):
    count = struct.unpack_from('<I', buf)[0]
    # ids = struct.unpack_from(f'<{count}I', buf, 4)
    sizes = struct.unpack_from(f'<{count}I', buf, 4 + (4 * count))
    # unk = struct.unpack_from(f'<{count}I', buf, 4 + (8 * count))
    chunks = []
    pos = 4 + (12 * count)

    for size in sizes:
        chunks += [(pos, size)]
        pos += size

    return chunks

@click.command
@click.argument('fname')
def extract_file(fname):
    in_file = Path(fname)
    buf = in_file.read_bytes()

    segments = get_chunks(buf)

    for i, (segment, size) in enumerate(segments):
        start_addr = segment
        end = start_addr + size

        logger.debug(f' {start_addr=:08X}')
        mode, comp_size, decomp_size = struct.unpack("<B 2I", buf[start_addr:start_addr + 9])

        out_name = in_file.with_stem(f'{in_file.stem}_{i:03d}').with_suffix('.wav')
        out_name.write_bytes(buf[start_addr:end])

if __name__ == '__main__':
    extract_file()
