#!/usr/bin/env python3
# -*- coding=utf-8 -*-

from pathlib import Path

import click

@click.command
@click.argument('files', nargs=-1)
def fix_case(files):
    for fname in files:
        fname = Path(fname)

        if not fname.exists():
            print(f"{fname} doesn't exist")
            continue

        lower = fname.with_name(fname.name.lower())

        if lower.name == fname.name:
            continue

        if lower.exists():
            print(f'{lower} already exists')
            continue

        print(f'{fname} -> {lower}')
        fname.rename(lower)

if __name__ == '__main__':
    fix_case()
