#!/usr/bin/env python3
# -*- coding=utf-8 -*-

pos = 0x15647C
end = 0x15AFA8

with open('EBOOT.BIN', 'r+b') as in_f:
    in_f.seek(pos)

    while pos < end:
        pos = in_f.tell()
        s = in_f.read(1024)
        s_end = s.index(b'\x00')
        s = s[:s_end].decode()

        if s.startswith(('DATA', 'NMAP', 'BTL')):
            s = s.lower()
            in_f.seek(pos)
            in_f.write(s.encode())

        pos += s_end + 1

        if padding := pos % 4:
            pos += 4 - padding

        in_f.seek(pos)
