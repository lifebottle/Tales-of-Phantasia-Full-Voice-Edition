#!/usr/bin/env python3
# -*- coding=utf-8 -*-

from pathlib import Path

import click
import re

def fix_audio(match):
    num = int(match.group(1), 16) - 0x37
    return f'audio_{num:04X}'

@click.command
@click.argument('fname')
@click.argument('out_name')
def main(fname, out_name):
    fname = Path(fname)
    buf = fname.read_text()
    buf = re.sub(r'audio_([\dA-F]{4})', fix_audio, buf)
    buf = buf.replace('topx_prx', 'topfve_prx')
    buf = buf.replace('topx_menu', 'topfve_prx')
    Path(out_name).write_text(buf)

if __name__ == '__main__':
    main()
