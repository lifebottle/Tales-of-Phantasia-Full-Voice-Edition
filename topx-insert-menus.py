#!/usr/bin/env python3
# -*- coding=utf-8 -*-

import struct
import re

from pathlib import Path
from dataclasses import dataclass
from io import BytesIO

from libs.TextReader import TextReader
from libs.insertor import convert_string
from libs.linewrap import TextWrapper
from libs.util import get_symbols, paths, logger

out_dir = paths['out']
target_dir = paths['target'] / 'menu'
eboot_path = out_dir / 'EBOOT.BIN'
data_path = out_dir / 'julian.dat'

syms = get_symbols()

eboot_base = 0x08803FA0
text_base = syms.get('custom_file_offset')
reloc_base = 0x8804000

# re-use upper half of old map buffer
max_size = 0x60000 - 0x35000

wrapper = TextWrapper()

sprintf_strings = [
    # arte mastered message
    ('topfve_prx_battle_jap', 4),
    ('topfve_prx_battle_jap', 5),
    ('topfve_prx_battle_jap', 6),
    ('topfve_prx_battle_jap', 7),
    ('topfve_prx_battle_jap', 8),
    ('topfve_prx_battle_jap', 9),
    ('topfve_prx_battle_jap', 10),
    # discard message
    ('topfve_prx_misc2_jap', 30),
]

npc_name_fix_ptr = syms.get('@@npc_name_fix_ptr')
discard_msg_ptr = syms.get('discard_msg_ptr')

@dataclass
class BlockPointer:
    hi: int
    lo: int
    offset: int = 0
    no_reloc: bool = False

    def __post_init__(self):
        if self.hi >= 0x08000000:
            self.hi -= eboot_base
            self.lo -= eboot_base

    def __repr__(self):
        return f'BlockPointer(hi=0x{self.hi:X}, lo=0x{self.lo:X})'

@dataclass
class Block:
    fname: str
    ptr_table: int
    short: bool = False

@dataclass
class Pointer:
    address: int
    destination: int

    def __repr__(self):
        return f'Pointer(address=0x{self.address + eboot_base:X}, destination=0x{self.destination:X})'

    @property
    def value(self):
        return self.as_short()

    def as_short(self):
        return struct.pack("<H", self.destination & 0xFFFF)

text_refs = {
    'topfve_prx_battle_jap.txt': [
        BlockPointer(0x88A8F48, 0x88A8F4C),
    ],
    'topfve_prx_title_descs_jap.txt': [
        BlockPointer(0x883BE28, 0x883BE2C),
    ],
    'topfve_prx_item_descs_jap.txt': [
        BlockPointer(0x883FABC, 0x883FAC0),
        BlockPointer(0x88A8EF8, 0x88A8EFC),
    ],
    'topfve_prx_titles_jap.txt': [
        BlockPointer(0x883BB3C, 0x883BB50),
        BlockPointer(0x883BD24, 0x883BD28),
        BlockPointer(0x883BE04, 0x883BE08),
        BlockPointer(0x883D6D4, 0x883D6E8),
        BlockPointer(0x885B254, 0x885B258),
    ],
    'topfve_prx_items_jap.txt': [
        BlockPointer(0x882D684, 0x882D688),
        BlockPointer(0x8833150, 0x8833154),
        BlockPointer(0x88333A8, 0x88333AC),
        BlockPointer(0x8834BB4, 0x8834BB8),
        BlockPointer(0x8834D7C, 0x8834D80),
        BlockPointer(0x883CCDC, 0x883CCE0),
        BlockPointer(0x883D380, 0x883D384),
        BlockPointer(0x883DA58, 0x883DA5C),
        BlockPointer(0x883F9F4, 0x883F9F8),
        BlockPointer(0x8840208, 0x884020C),
        BlockPointer(0x8849168, 0x884917C),
        BlockPointer(0x8854CA4, 0x8854CA8),
        BlockPointer(0x885A20C, 0x885A220),
        BlockPointer(0x885A5A4, 0x885A5BC),
        BlockPointer(0x885C35C, 0x885C360),
        BlockPointer(0x88A8ED0, 0x88A8ED4),
        BlockPointer(0x890BBBC, 0x890BBC0),
        BlockPointer(0x89447F4, 0x89447F8),
    ],
    'topfve_prx_misc2_jap.txt': [
        BlockPointer(0x882771C, 0x8827720),
        BlockPointer(0x88285F0, 0x88285F4),
        BlockPointer(0x882866C, 0x8828680),
        BlockPointer(0x8828F4C, 0x8828F50),
        BlockPointer(0x8828F80, 0x8828F84),
        BlockPointer(0x8828FF4, 0x8828FF8),
        BlockPointer(0x8829020, 0x8829024),
        BlockPointer(0x882904C, 0x8829050),
        BlockPointer(0x8829550, 0x8829554),
        BlockPointer(0x882965C, 0x8829660),
        BlockPointer(0x8829764, 0x8829768),
        BlockPointer(0x88297D8, 0x88297DC),
        BlockPointer(0x8829834, 0x8829838),
        BlockPointer(0x88298A8, 0x88298AC),
        BlockPointer(0x8829904, 0x8829908),
        BlockPointer(0x8829978, 0x882997C),
        BlockPointer(0x88299D4, 0x88299D8),
        BlockPointer(0x8829A48, 0x8829A4C),
        BlockPointer(0x8829AA4, 0x8829AA8),
        BlockPointer(0x8829B00, 0x8829B04),
        BlockPointer(0x882CE0C, 0x882CE10),
        BlockPointer(0x8830AE8, 0x8830AEC),
        BlockPointer(0x8831DC4, 0x8831DC8),
        BlockPointer(0x8831E08, 0x8831E0C),
        BlockPointer(0x8831F68, 0x8831F6C),
        BlockPointer(0x8832950, 0x8832954),
        BlockPointer(0x88337B0, 0x88337B4),
        BlockPointer(0x8833910, 0x8833914),
        BlockPointer(0x8833CC8, 0x8833CCC),
        BlockPointer(0x88344DC, 0x88344E0),
        BlockPointer(0x8834500, 0x8834504),
        BlockPointer(0x8834670, 0x8834674),
        BlockPointer(0x8834738, 0x883473C),
        BlockPointer(0x8835B08, 0x8835B0C),
        BlockPointer(0x8835B34, 0x8835B38),
        BlockPointer(0x8835B60, 0x8835B64),
        BlockPointer(0x88383BC, 0x88383C0),
        BlockPointer(0x88386E0, 0x88386E4),
        BlockPointer(0x88395A4, 0x88395A8),
        BlockPointer(0x8839954, 0x883995C),
        BlockPointer(0x883B084, 0x883B088),
        BlockPointer(0x883B0A0, 0x883B0A4),
        BlockPointer(0x883B970, 0x883B974),
        BlockPointer(0x883C028, 0x883C02C),
        BlockPointer(0x883CA80, 0x883CA84),
        BlockPointer(0x883CFEC, 0x883CFF0),
        BlockPointer(0x883D5AC, 0x883D5B0),
        BlockPointer(0x883E12C, 0x883E130),
        BlockPointer(0x883EEF4, 0x883EEF8),
        BlockPointer(0x883F468, 0x883F46C),
        BlockPointer(0x883F4BC, 0x883F4C0),
        BlockPointer(0x883F4F8, 0x883F4FC),
        BlockPointer(0x883FA38, 0x883FA4C),
        BlockPointer(0x883FEC4, 0x883FEC8),
        BlockPointer(0x883FF78, 0x883FF7C),
        BlockPointer(0x883FFA4, 0x883FFA8),
        BlockPointer(0x8840000, 0x8840004),
        BlockPointer(0x8840058, 0x884005C),
        BlockPointer(0x884024C, 0x8840250),
        BlockPointer(0x884027C, 0x8840280),
        BlockPointer(0x88402A8, 0x88402AC),
        BlockPointer(0x88403A4, 0x88403A8),
        BlockPointer(0x88403D0, 0x88403D4),
        BlockPointer(0x88403FC, 0x8840400),
        BlockPointer(0x884055C, 0x8840560),
        BlockPointer(0x8854A74, 0x8854A78),
        BlockPointer(0x8854EE0, 0x8854EE4),
        BlockPointer(0x8854F68, 0x8854F6C),
        BlockPointer(0x8854FDC, 0x8854FE0),
        BlockPointer(0x885B2C8, 0x885B2CC),
        BlockPointer(discard_msg_ptr, discard_msg_ptr + 4, no_reloc=True),   # discard_msg_stub
        BlockPointer(0x0883ff60, 0x0883ff64, offset=2),
    ],
    'topfve_prx_misc_jap.txt': [
        BlockPointer(0x8827C44, 0x8827C48),
        BlockPointer(0x8827C8C, 0x8827C90),
        BlockPointer(0x8828078, 0x8828080),
        BlockPointer(0x8828B48, 0x8828B4C),
        BlockPointer(0x8828DA8, 0x8828DB0),
        BlockPointer(0x8828E40, 0x8828E48),
        BlockPointer(0x8829200, 0x8829204),
        BlockPointer(0x8829244, 0x8829248),
        BlockPointer(0x88292A8, 0x88292AC),
        BlockPointer(0x8829688, 0x882968C),
        BlockPointer(0x88296B4, 0x88296B8),
        BlockPointer(0x882D378, 0x882D37C),
        BlockPointer(0x882D6AC, 0x882D6B0),
        BlockPointer(0x882FD84, 0x882FD88),
        BlockPointer(0x882FE38, 0x882FE3C),
        BlockPointer(0x882FE84, 0x882FE88),
        BlockPointer(0x88300D0, 0x88300D4),
        BlockPointer(0x8830108, 0x883010C),
        BlockPointer(0x8830154, 0x8830158),
        BlockPointer(0x88301A0, 0x88301A4),
        BlockPointer(0x8831C68, 0x8831C6C),
        BlockPointer(0x8831CD0, 0x8831CD4),
        BlockPointer(0x8831D6C, 0x8831D70),
        BlockPointer(0x8831EA8, 0x8831EAC),
        BlockPointer(0x8832090, 0x8832094),
        BlockPointer(0x883212C, 0x8832130),
        BlockPointer(0x88321E4, 0x88321E8),
        BlockPointer(0x8833340, 0x8833344),
        BlockPointer(0x8833420, 0x8833424),
        BlockPointer(0x8833518, 0x883351C),
        BlockPointer(0x88335B0, 0x88335B4),
        BlockPointer(0x8833658, 0x883365C),
        BlockPointer(0x8833684, 0x8833688),
        BlockPointer(0x88336B0, 0x88336B4),
        BlockPointer(0x8833700, 0x8833704),
        BlockPointer(0x883372C, 0x8833730),
        BlockPointer(0x8833758, 0x883375C),
        BlockPointer(0x88346AC, 0x88346B0),
        BlockPointer(0x88346E8, 0x88346F0),
        BlockPointer(0x8834910, 0x8834914),
        BlockPointer(0x8838208, 0x883820C),
        BlockPointer(0x8838248, 0x883824C),
        BlockPointer(0x883828C, 0x8838290),
        BlockPointer(0x8838424, 0x883842C),
        BlockPointer(0x8838A3C, 0x8838A40),
        BlockPointer(0x8838B3C, 0x8838B40),
        BlockPointer(0x883B1F0, 0x883B1F8),
        BlockPointer(0x883B550, 0x883B554),
        BlockPointer(0x883B5CC, 0x883B5D0),
        BlockPointer(0x883BB80, 0x883BB84),
        BlockPointer(0x883BBEC, 0x883BBF0),
        BlockPointer(0x883CC40, 0x883CC44),
        BlockPointer(0x883CF68, 0x883CF6C),
        BlockPointer(0x883D2B4, 0x883D2B8),
        BlockPointer(0x883D3D8, 0x883D3DC),
        BlockPointer(0x883D414, 0x883D418),
        BlockPointer(0x883D69C, 0x883D6A0),
        BlockPointer(0x883D718, 0x883D71C),
        BlockPointer(0x883D77C, 0x883D780),
        BlockPointer(0x883D7B0, 0x883D7B4),
        BlockPointer(0x883D7EC, 0x883D7F0),
        BlockPointer(0x883D820, 0x883D824),
        BlockPointer(0x883D854, 0x883D858),
        BlockPointer(0x883D888, 0x883D88C),
        BlockPointer(0x883D8C8, 0x883D8CC),
        BlockPointer(0x883D8FC, 0x883D900),
        BlockPointer(0x883D938, 0x883D93C),
        BlockPointer(0x883D96C, 0x883D970),
        BlockPointer(0x883D9A0, 0x883D9A4),
        BlockPointer(0x883D9D4, 0x883D9D8),
        BlockPointer(0x883DA10, 0x883DA14),
        BlockPointer(0x883DAA4, 0x883DAA8),
        BlockPointer(0x883DC84, 0x883DC88),
        BlockPointer(0x883DE68, 0x883DE6C),
        BlockPointer(0x883E440, 0x883E444),
        BlockPointer(0x883E584, 0x883E588),
        BlockPointer(0x883E690, 0x883E694),
        BlockPointer(0x883E6C4, 0x883E6C8),
        BlockPointer(0x883E6FC, 0x883E700),
        BlockPointer(0x883FC14, 0x883FC18),
        BlockPointer(0x883FE68, 0x883FE6C),
        BlockPointer(0x88405B4, 0x88405B8),
        BlockPointer(0x8841AA0, 0x8841AA4),
        BlockPointer(0x8841B94, 0x8841B98),
        BlockPointer(0x8842930, 0x8842934),
        BlockPointer(0x88429AC, 0x88429B0),
        BlockPointer(0x8842A20, 0x8842A24),
        BlockPointer(0x8842AB4, 0x8842AB8),
        BlockPointer(0x8842B1C, 0x8842B20),
        BlockPointer(0x8853B18, 0x8853B1C),
        BlockPointer(0x8855144, 0x8855148),
        BlockPointer(0x885518C, 0x8855190),
        BlockPointer(0x8856AB8, 0x8856ABC),
        BlockPointer(0x8856AF0, 0x8856AF4),
        BlockPointer(0x8856B6C, 0x8856B70),
        BlockPointer(0x8856BC4, 0x8856BC8),
        BlockPointer(0x8856BFC, 0x8856C00),
        BlockPointer(0x8856C2C, 0x8856C30),
        BlockPointer(0x8856DE0, 0x8856DE4),
        BlockPointer(0x8857B54, 0x8857B58),
        BlockPointer(0x8857C10, 0x8857C14),
        BlockPointer(0x8857C48, 0x8857C4C),
        BlockPointer(0x8857CD8, 0x8857CDC),
        BlockPointer(0x8857D24, 0x8857D28),
        BlockPointer(0x8857DC4, 0x8857DC8),
        BlockPointer(0x8857F0C, 0x8857F10),
        BlockPointer(0x8857F90, 0x8857F94),
        BlockPointer(0x8857FE8, 0x8857FEC),
        BlockPointer(0x88580A4, 0x88580A8),
        BlockPointer(0x885B1C4, 0x885B1C8),
        BlockPointer(0x88654D0, 0x88654D8),
        BlockPointer(0x890B860, 0x890B864),
        BlockPointer(0x890B878, 0x890B87C),
        BlockPointer(0x890BA00, 0x890BA04),
        # used in npc_name_fix
        BlockPointer(npc_name_fix_ptr, npc_name_fix_ptr + 4, no_reloc=True),
    ],
    'topfve_prx_cook_help.txt': [
        BlockPointer(0x883FE04, 0x883FE08),
    ],
    'topfve_prx_cook_name.txt': [
        BlockPointer(0x883D10C, 0x883D110),
        BlockPointer(0x883D148, 0x883D14C),
        BlockPointer(0x883D184, 0x883D188),
        BlockPointer(0x883FDCC, 0x883FDD0),
    ],
    'topfve_prx_cook_msg.txt': [
        BlockPointer(0x883CA48, 0x883CA4C),
        BlockPointer(0x883CAB0, 0x883CAB8),
    ],
    'topfve_prx_grade_shop.txt': [
        BlockPointer(0x8835DC8, 0x8835DCC),
        BlockPointer(0x8835E08, 0x8835E0C),
        BlockPointer(0x8835E38, 0x8835E3C),
        BlockPointer(0x8835E68, 0x8835E6C),
    ],
    'topfve_prx_mon_mes.txt': [
        BlockPointer(0x890B490, 0x890B494),
        BlockPointer(0x890B788, 0x890B78C),
        BlockPointer(0x890B804, 0x890B808),
        BlockPointer(0x890BA74, 0x890BA78),
        BlockPointer(0x890BAD8, 0x890BADC),
        BlockPointer(0x890BC1C, 0x890BC20),
        BlockPointer(0x890BCA0, 0x890BCA4),
        BlockPointer(0x890BD10, 0x890BD14),
        BlockPointer(0x890BE2C, 0x890BE30),
        BlockPointer(0x890BFE0, 0x890BFE4),
        BlockPointer(0x890C15C, 0x890C160),
        BlockPointer(0x890C1C4, 0x890C1C8),
        BlockPointer(0x890C228, 0x890C22C),
    ],
    'topfve_prx_mon_name.txt': [
        BlockPointer(0x890B54C, 0x890B550),
    ],
    'topfve_prx_shop_name.txt': [
        BlockPointer(0x88549AC, 0x88549B4),
    ],
    'topfve_prx_opr08.txt': [
        BlockPointer(0x8846CBC, 0x8846CC0),
    ],
    'topfve_prx_opr14.txt': [
        BlockPointer(0x8846CFC, 0x8846D00),
    ],
    'topfve_prx_spc08.txt': [
        BlockPointer(0x8BBF566, 0x8BBF564),
        BlockPointer(0x8BBF576, 0x8BBF574),
        BlockPointer(0x8BBF586, 0x8BBF584),
        BlockPointer(0x8BBF5E6, 0x8BBF5E4),
        BlockPointer(0x8BBF5F6, 0x8BBF5F4),
        BlockPointer(0x8BBF606, 0x8BBF604),
        BlockPointer(0x8BBF636, 0x8BBF634),
        BlockPointer(0x8BBF646, 0x8BBF644),
        BlockPointer(0x8BBF656, 0x8BBF654),
    ],
    'topfve_prx_spc12.txt': [
        BlockPointer(0x8BBF5B6, 0x8BBF5B4),
        BlockPointer(0x8BBF5C6, 0x8BBF5C4),
        BlockPointer(0x8BBF5D6, 0x8BBF5D4),
    ],
    'topfve_prx_spc14.txt': [
        BlockPointer(0x8BBF536, 0x8BBF534),
        BlockPointer(0x8BBF546, 0x8BBF544),
        BlockPointer(0x8BBF556, 0x8BBF554),
    ],
    'topfve_prx_spc_help.txt': [
        BlockPointer(0x8858BB0, 0x8858BB4),
    ],
    'topfve_prx_misc3.txt': [
        BlockPointer(0x88A8F20, 0x88A8F24),
    ],
    'topfve_prx_main_menu.txt': [
        BlockPointer(0x8830034, 0x883004C),
    ],
    'save_cancel': [
        BlockPointer(0x0882f04c, 0x0882f058),
    ],
    'load_cancel': [
        BlockPointer(0x0882f2bc, 0x0882f2c8),
    ],
    'erase_cancel': [
        BlockPointer(0x0882f35c, 0x0882f368),
    ],
    # not needed in FVE
    # 'save_title': [
    #     BlockPointer(0x0892e458, 0x0892e46c),
    # ],
    # 'new_save_title': [
    #     BlockPointer(0x0892e544, 0x0892e554),
    # ],
    'playtime_str': [
        BlockPointer(0x0882eef4, 0x0882ef0c),
    ],
    'no_ms_inserted': [
        BlockPointer(0x0888dcd4, 0x0888dce0),
    ],
    'ms_space_error': [
        BlockPointer(0x0888de50, 0x0888de5c),
    ],
    'continue_anyway': [
        BlockPointer(0x0888de74, 0x0888de80),
    ],
}

files = [
    Block('topfve_prx_battle_jap.txt', 0x401ef8),
    Block('topfve_prx_title_descs_jap.txt', 0x153d74),
    Block('topfve_prx_item_descs_jap.txt', 0x16ddd0),
    Block('topfve_prx_titles_jap.txt', 0x154df8, True),
    Block('topfve_prx_items_jap.txt', 0x172AF0, True),
    Block('topfve_prx_misc_jap.txt', 0x3d4c1c, True),
    Block('topfve_prx_misc2_jap.txt', 0x3d5380),
    Block('topfve_prx_cook_help.txt', 0x155640),
    Block('topfve_prx_cook_name.txt', 0x1562bc, True),
    Block('topfve_prx_cook_msg.txt', 0x155bf8),
    Block('topfve_prx_grade_shop.txt', 0x423b18),
    Block('topfve_prx_mon_mes.txt', 0x4049c8),
    Block('topfve_prx_mon_name.txt', 0x404b38, True),
    Block('topfve_prx_shop_name.txt', 0x3b9354),
    Block('topfve_prx_opr08.txt', 0x3b44d8, True),
    Block('topfve_prx_opr14.txt', 0x3b4570),
    Block('topfve_prx_spc08.txt', 0x3bacf0, True),
    Block('topfve_prx_spc12.txt', 0x3bb130, True),
    Block('topfve_prx_spc14.txt', 0x3bb2a0, True),
    Block('topfve_prx_spc_help.txt', 0x3b9af0),
    Block('topfve_prx_misc3.txt', 0x401dc8, True),
    Block('topfve_prx_main_menu.txt', 0x3d5358, True),
]

def process_block(fname, short=False):
    logger.info(f"Inserting {fname}...")
    fname = target_dir / fname
    strings = TextReader(fname, encoding="utf-8", mode="bare").strings

    pointers = []
    block = BytesIO()

    want_wrap = fname.match('*desc*') or fname.match('*_help*') or fname.match('*_opr14*')

    for num, s in enumerate(strings):
        logger.debug(f'Inserting:\n{s}')

        if want_wrap:
            s = wrapper.wrap(s, 9999)
            s = re.sub(r'\b(A|An)\b ', '\\1_', s)
            s = re.sub(r'#(\d) ', '#\\1_', s)

        if (fname.stem, num) in sprintf_strings:
            sprintf_string = True
            # convert to raw ascii
            s = s.replace('%s', '{25}{73}')
        else:
            sprintf_string = False

        s = convert_string(s, short or sprintf_string)

        if sprintf_string:
            if len(s) % 2:
                s += b'\x00'

        pointers += [block.tell()]
        block.write(s)

    pointers = [struct.pack('<H', x) for x in pointers]

    buf = block.getvalue()
    block.close()

    return pointers, buf

def insert_save_strings(queue):
    fname = target_dir / 'top_prx_save.txt'
    pos = 0x142790  # use the slack in sceNid section
    strings = TextReader(fname, mode='bare').strings
    # ids = ['save_cancel', 'load_cancel', 'erase_cancel', 'save_title', 'new_save_title']
    ids = ['save_cancel', 'load_cancel', 'erase_cancel', 'playtime_str', 'no_ms_inserted', 'ms_space_error', 'continue_anyway']
    assert len(strings) == len(ids)

    for s_id, s in zip(ids, strings):
        ptrs = text_refs.get(s_id)

        if not ptrs:
            logger.warning(f'unknown string: {s_id}')
            continue

        if padding := pos % 4:
            pos += 4 - padding

        s = s.replace('{END}', '')
        # NOTE: might be a problem for other languages
        s = s.encode('shift-jis') + b'\x00'

        if s_id in ['no_ms_inserted', 'ms_space_error']:
            # trademark symbol
            s = s.replace(b'{81}{7F}', b'\x81\x7f')
            # force cr/lf
            s = s.replace(b'\x0a', b'\x0a\x0d')

        ptr_offset = pos + eboot_base - reloc_base
        hi = ptr_offset >> 16
        lo = ptr_offset & 0xffff

        if lo >= 0x8000:
            hi += 1

        for ptr in ptrs:
            queue += [Pointer(ptr.hi, hi)]
            queue += [Pointer(ptr.lo, lo)]

        queue += [(pos, [s])]
        pos += len(s)

def insert_menus(eboot_fname, text_fname):
    with open(text_fname, 'ab') as out:
        queue = []

        for block in files:
            block_fname = Path(block.fname)
            short = block.short
            first_ptrs = text_refs.get(block_fname.name)

            if not first_ptrs:
                logger.error(f'unknown block {block_fname}')
                continue

            block_start = out.tell()
            logger.info(f'Inserting {block_fname} @ {block_start:X} ({block_start + text_base:X})')
            logger.info(f'\tfirst string: {block_start:X} ({block_start + text_base:X})')

            text_ptrs, buf = process_block(block_fname, short)

            out.write(buf)
            queue += [(block.ptr_table, text_ptrs)]

            # make sure blocks are word-aligned
            if padding := out.tell() % 4:
                out.write(b'\x00' * (4 - padding))

            block_start += text_base

            for ptr in first_ptrs:
                raw_address = ptr.hi - ptr.lo == 2

                ptr_offset = block_start + ptr.offset

                if not ptr.no_reloc:
                    ptr_offset -= reloc_base

                hi = ptr_offset >> 16
                lo = ptr_offset & 0xffff

                if not raw_address and lo >= 0x8000:
                    hi += 1

                queue += [Pointer(ptr.hi, hi)]
                queue += [Pointer(ptr.lo, lo)]

        if out.tell() > max_size:
            logger.error(f'file overflows by {out.tell() - max_size} bytes')

    insert_save_strings(queue)

    with open(eboot_fname, 'r+b') as out:
        for ptr in queue:
            if isinstance(ptr, Pointer):
                out.seek(ptr.address)
                out.write(ptr.value)
            elif isinstance(ptr, tuple):
                offs, data = ptr
                out.seek(offs)
                out.write(b''.join(data))

if __name__ == '__main__':
    insert_menus(eboot_path, data_path)
