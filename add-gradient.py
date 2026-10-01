#!/usr/bin/env python3
# -*- coding=utf-8 -*-

import click

from PIL import Image

# gradient_diagonal = [
#     [15, 15, 15, 15, 15, 15, 14, 13],
#     [15, 15, 15, 15, 15, 14, 13, 12],
#     [15, 15, 15, 15, 14, 13, 12, 11],
#     [15, 15, 15, 14, 13, 12, 11, 10],
#     [15, 15, 14, 13, 12, 11, 10, 9],
#     [15, 14, 13, 12, 11, 10, 9,  8],
#     [14, 13, 12, 11, 10, 9,  8,  7],
#     [13, 12, 11, 10, 9,  8,  7,  6],
# ]

gradient = [ 15, 15, 15, 14, 14, 13, 13, 12]

def add_gradient(img):
    tmp = img.load()

    for y in range(128, 128 + 32):
        for x in range(img.size[0]):
            if tmp[x, y] == 2:
                # tmp[x, y] = gradient_diagonal[y % 8][x % 8]
                tmp[x, y] = gradient[y % 8]

    return img

@click.command
@click.argument('fname')
@click.argument('out_name')
def main(fname, out_name):
    pal = Image.open('sys_00-jap.png').palette
    img = Image.open(fname)
    img = add_gradient(img)
    img.putpalette(pal)
    img.save(out_name)


if __name__ == '__main__':
    main()
