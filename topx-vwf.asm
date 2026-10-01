; NOTE: you need to change this if you added new glyphs
vwf_glyphs_end equ 0x70

map_buf_len equ 0x35000
discard_ptr equ 0x8C48698
spacer equ 0x6d

.definelabel malloc,0x0880A8B8
.definelabel memcpy,0x0880b288
.definelabel map_buf_old,0x0908D2FC
.definelabel map_index,0x0908d2f4
.definelabel add_knj_prim,0x088e0d5c
.definelabel btl_str2,0x08831044
.definelabel sprintf,0x0880d71c
.definelabel strcpy,0x0880db9c

; add_knj_prim - prolog
   ; 088e0d6c ff ff      andi    s1,a0,0xffff
   ;          91 30
   ; 088e0d70 01 07      slti    at,s1,0x701
   ;          21 2a
   .org 0x088e0d6c
        j add_knj_prim_prolog_stub
        nop

; add_knj_prim - char width
   ; 088e109c 08 09      lui     v1,0x908
   ;          03 3c
   ; 088e10a0 44 7b      lh      a0,offset csr_w(v1)               = ??
   ;          64 84
   ; 088e10a4 08 09      lui     v1,0x908
   ;          03 3c
   ; 088e10a8 0e 00      addiu   a0,a0,0xe
   ;          84 24
   .org 0x088e10a4
        j add_knj_prim_width_stub-0x2200
        nop

; add_knj_prim - epilog
   ; 088e10c0 08 00      jr      ra
   ;          e0 03
   ; 088e10c4 10 00      _addiu  sp,sp,0x10
   ;          bd 27
   ; .org 0x088e10c4
   ;      addiu sp, sp, 0x14 ; was 0x10

; set_top_win_adr prolog
   ; 088e1858 ff ff      andi    v1,v0,0xffff
   ;          43 30
   ; 088e185c 0f 00      li      v0,0xf
   ;          02 24
   .org 0x088e1858
        j set_top_win_adr_stub
        andi v1, v0, 0xffff

; set_top_win_adr char width
   ; 088e1898 0e 00      addiu   s5,s5,0xe
   ;          b5 26
   org 0x088e1898
        addu s5, s5, t0

; set_top_win_adr window width
   ; 088e18d0 e0 01      li      v0,0x1e0
   ;          02 24
   ; 088e18d4 23 18      subu    v1,v0,s5
   ;          55 00
   ; org 0x088e18d0
   ;      j set_top_win_adr_width
   ;      nop

   ; FUN_088f2a68 - base address for map buf
   ; 088f2acc 09 09      lui     v0,0x909
   ;          02 3c
   ; 088f2ad0 21 18      addu    v1,v1,a0
   ;          64 00
   ; 088f2ad4 fc d2      addiu   v0,v0,-0x2d04
   ;          42 24
   ; 088f2ad8 00 1c      sll     v1,v1,0x10
   ;          03 00
   ; 088f2adc 9e 81      jal     FUN_08920678                      undefined FUN_08920678()
   ;          24 0e
   ; 088f2ae0 21 88      _addu   s1,v0,v1
   ;          43 00
   .org 0x088f2acc
        jal map_load_ptr-0x2200
        addu v1, v1, a0
        nop

    .org 0x088f2ae0
        move s1, v0     ; replace addition

   ; FUN_088f2844
   ; 088f2908 40 10      sll     v0,v1,0x1
   ;          03 00
   ; 088f290c 21 10      addu    v0,v0,v1
   ;          43 00
   ; 088f2910 00 1c      sll     v1,v0,0x10
   ;          02 00
   ; 088f2914 09 09      lui     v0,0x909
   ;          02 3c
   ; 088f2918 fc d2      addiu   v0,v0,-0x2d04
   ;          42 24
   ; 088f291c 21 20      addu    a0,a0,s1
   ;          91 00
   ; 088f2920 21 28      addu    a1=>DAT_0905d2fc,v0,v1            = ??
   ;          43 00
   .org 0x088f2914
        jal map_load_ptr-0x2200
        nop

    .org 0x088f2920
        move a1, v0     ; replace addition

   ; 088f295c 40 10      sll     v0,v1,0x1
   ;          03 00
   ; 088f2960 21 10      addu    v0,v0,v1
   ;          43 00
   ; 088f2964 00 1c      sll     v1,v0,0x10
   ;          02 00
   ; 088f2968 09 09      lui     v0,0x909
   ;          02 3c
   ; 088f296c fc d2      addiu   v0,v0,-0x2d04
   ;          42 24
   ; 088f2970 21 28      addu    a1=>DAT_0905d2fc,v0,v1            = ??
   ;          43 00
   .org 0x088f2968
        jal map_load_ptr-0x2200
        nop

        move a1, v0     ; replace addition

   ; FUN_08925614 - malloc_heap size
   ; 08925638 03 00      lui     a0,0x3
   ;          04 3c
   ; .org 0x08925638
   ;      lui a0, 0x6

   ; main
   ; 088b0834 9e 08      lui     a0,0x89e
   ;          04 3c
   ; 088b0838 8b 08      lui     a1,0x88b
   ;          05 3c
   .org 0x088b0834
        j map_buf_malloc-0x2204
        nop

   ; add_ank_prim - kana font width
   ; 088e13c4 08 09      lui     v1,0x908
   ;          03 3c
   ; 088e13c8 08 00      addiu   a0,a0,0x8
   ;          84 24
   .org 0x088e13c4
       j add_ank_prim_width_stub-0x2200
       nop

   ; kana font y pos
   ; 088e12d0 0a 00      sh      t2,0xa(v1)
   ;          6a a4
   ; 088e12d4 0c 00      sb      t4,0xc(v1)
   ;          6c a0
   .org 0x088e12d0
        j menu_get_char_yoffs
        nop

   ; add_ank_prim prolog
   ; 088e11e4 c5 08      lui     v1,0x8c5
   ;          03 3c
   ; 088e11e8 6c 9d      lhu     a2,-0x6294(v1)=>ank_cnv_tbl       = 00CDh
   ;          66 94
   .org 0x088e11e4
        j add_ank_prim_prolog_stub-0x2200
        nop

   ; add_ank_prim dakuten/handakuten
   ; 088e1304 2d 00      beq     v1,zero,LAB_088e13bc
   ;          60 10
   .org 0x088e1304
        b 0x088e13bc

   ; disable play time animation for now
   ;                  s_%3d_%02d_08a28cc8               XREF[2]: FUN_088b413c:088b419c(
   ;                                                             08a28cd8(*)  
   ; 08a28cc8 25 33      ds      "%3d %02d"
   ;          64 20 
   ;          25 30 
   ; .org 0x08a28cc8
   ;      .asciiz "%3d:%02d"

   ; FUN_088b413c - animated play time
   ; 088b4214 21 30      li      a2,0
   ;          00 00
   ; 088b4218 21 38      li      a3,0
   ;          00 00
   .org 0x088b4214
        jal play_time_stub
        nop

   ; FUN_088a6a34 - battle item glyph width
   ; 088a6a84 08 00      addiu   v0,v0,0x8
   ;          42 24
   ; 088a6a88 1c 00      sh      v0,local_4(sp)
   ;          a2 a7
   .org 0x088a6a84
        jal battle_item_width_stub
        nop

   ; shop spacer (dot)
   ; 088daf5c 50 00      li      v1,0x50
   ;          03 24
   .org 0x088daf5c
        li v1, spacer ; was 0x50

   ; shop list pos x
   ; 088dae2c 20 00      li      a1,0x20
   ;          05 24
   .org 0x088dae2c
        li a1, 0x18 ; was 0x20

   ; shop list cursor pos x
   .org 0x08c29af4
        .db 0x18 ; was 0x20

   ; shop list page number pos x and y
   ; 088dac54 a0 00      li      a1,0xa0
   ;          05 24
   ; 088dac58 24 00      li      a2,0x24
   ;          06 24
   .org 0x088dac54
        li a1, 0xa2 ; was 0xa0
        li a2, 0x26 ; was 0x24

   ; better right align
   ; 088daf8c 60 00      li      a1,0x60
   ;          05 24
   ; .org 0x088daf8c
   ;      li a1, 0x68 ; was 0x60

   ; battle item primitive coords 
   ; pos x
   ; 088a696c 08 00      sh      v0,0x8(s1)
   ;          22 a6
   ; pos y
   ; 088a6970 02 00      lh      v0,0x2(s2)
   ;          42 86
   ; 088a6974 47 46      jal     FUN_0899191c                      undefined FUN_0899191c()
   ;          26 0e
   ; 088a6978 0a 00      _sh     v0,0xa(s1)
   ;          22 a6
   ;
   .org 0x088a696c
        jal battle_item_yoffs_stub
        sh v0, 0x8(s1)

   ; battle item list colon x offset
   ; 0887c2ec 40 00      addiu   v0,v0,0x40
   ;          42 24
   .org 0x0887c2ec
        addiu v0, v0, 0x48 ; was 0x40

   ; battle item list colon
   ; 0887c2fc 2d 00      _li     a3,0x2d
   ;          07 24
   .org 0x0887c2fc
        li a3, spacer ; was 0x2d

   ; battle item list number offset
   ; 0887c30c 08 00      addiu   v1,v1,0x8
   ;          63 24

   ; number of chars in name entry
   ; 088c2d7c 06 00      slti    v0,s1,0x6
   ;          22 2a
   ; .org 0x088c2d7c
   ;      slti v0, s1, 0x7 ; was 0x6

   ; another number of chars in name entry?
   ; 088c287c 06 00      slti    v0,s1,0x6
   ;          22 2a
   ; .org 0x088c287c
   ;      slti v0, s1, 0x7 ; was 0x6

   ; length check for name variable
   ; 088c2dfc 06 00      slti    v0,a1,0x6
   ;          a2 28
   .org 0x088c2dfc
        slti v0, a1, 0x7 ; was 0x6

   ; another length for name variable
   ; 088c2a1c 06 00      slti    v1,a2,0x6
   ;          c3 28
   .org 0x088c2a1c
        slti v1, a2, 0x7 ; was 0x6

   ; change space in ascii2ank conversion table to our spacer
   .org 0x08c4989c
        .db spacer ; was 0x10

   ; char width in menu titles (called from dsp_menu_title)
   ; 088e05dc 0e 00      _addiu  s2,s2,0xe
   ;          52 26
   ; .org 0x088e05dc
   ;      addiu s2, s2, 0x20

    ; .org 0x088e11d8
    ;     addiu v1, v1, 0x6 ; was 0xc

   ; furigana for main artes menu
   ; 088b5f44 04 00      bne     s0,zero,LAB_088b5f58
   ;          00 16
   .org 0x088b5f44
        nop

   ; type of font to use for main artes list (0 = dialogue font, 1 = small kanji, 2 = small font)
   ; passed to get_special_name
   ; 088b5d4c 01 00      li      a1,0x1
   ;          05 24
   ; .org 0x088b5d4c
   ;     li a1, 2 ; was 1

   ; main artes menu list (Cless) - type of font
   ; 088b5a88 01 00      li      a1,0x1
   ;          05 24
   ; .org 0x088b5a88
   ;      li a1, 2 ; was 1

   ; main artes list (Cless) - type of font, left side
   ; 088b581c 01 00      li      a1,0x1
   ;          05 24
   ; .org 0x088b581c
   ;      li a1, 2 ; was 1

   ; battle menu font select
   ; 08875ccc 01 00      li      a1,0x1
   ;          05 24
   ; .org 0x08875ccc
   ;      li a1, 2 ; was 1

   ; patch some entries in spc_name to force artes to be read as kana
   .org 0x08c2e8a4
        ; multi-byte
        .db 0
        ; font type
        .db 0

   .org 0x08c2e8b4
        ; multi-byte
        .db 0
        ; font type
        .db 0

   .org 0x08c2e8c4
        ; multi-byte
        .db 0
        ; font type
        .db 0

   .org 0x08c2e904
        ; multi-byte
        .db 0
        ; font type
        .db 0

   .org 0x08c2e804
        ; multi-byte
        .db 0

    .org 0x08c2e814
        ; multi-byte
        .db 0

    .org 0x08c2e824
        ; multi-byte
        .db 0

    .org 0x08c2e864
        ; multi-byte
        .db 0

   ; NOTE: needs to be edited if message changes
   ; Replace with whom - hardcoded offset to character num
   ; 088bf764 02 00      sh      v0,0x2(a3)=>str14_dat[512]
   ;          e2 a4
   .org 0x088bf764
        sh v0, 0x12(a3) ; was 0x2

   ; NOTE: needs to be edited if message changes
   ; Rune Bottle "Changed into" message, hardcoded offset to item num
   ; 088b7d88 02 00      sh      a1,0x2(v1)=>str14_dat[2814]
   ;          65 a4
   .org 0x088b7d88
        sh a1, 0x1c(v1); was 0x2

   ; NOTE: needs to be edited if message changes
   ; Rune Bottle "Can't hold anymore", hardcoded offset to item num
   ; 088b7dac 24 00      _sh     a1,0x24(v1)=>str14_dat[2868]
   ;          65 a4
   .org 0x088b7dac
        sh a1, 0x28(v1)

   ; font mode for main menu options
   ; 088b3f98 01 00      li      a2,0x1
   ;          06 24
   .org 0x088b3f98
        li a2, 0 ; was 1

    ; 08a28ca8 - table for main menu options (>= 0x80 - sprite, <0x80 - string num)

    ; 08a28caa - Item sprite, change to string num
    .org 0x08a28caa
        .db 7 ; was 0x80

    ; 08a28caf - Status sprite
    .org 0x08a28caf
        .db 8 ; was 0x81

    ; 08a28cb0 - Customize sprite
    .org 0x08a28cb0
        .db 9 ; was 0x82

    ; 08a28cb1 - Save sprite
    .org 0x08a28cb1
        .db 0x0a ; was 0x83

    ; 08a28cb2 - Load sprite
    .org 0x08a28cb2
        .db 0x0b ; was 0x84

   ; main menu options - x position
   ; 088b3f58 1c 00      li      a0,0x1c
   ;          04 24
   .org 0x088b3f58
        li a0, 0x14 ; was 0x1c

   ; reclaim space previously used by item descriptions
   .org 0x089d255c
   .area 0x089D4000-.
        discard_msg_stub:
           ; load msg pointer
           lhu a2, discard_ptr
           ; add to block start
           lui v1,0x8c5
           addiu v1, v1, -0x7848
           addu a2, v1, a2
           jal discardMsg
           nop
           j 0x088c5024
           nop

        map_buf_ptr:
            .dw 0

        map_buf_malloc:
            addiu sp, sp, -0x10
            sw ra, 0xc(sp)
            sw a0, 0x8(sp)
            sw a1, 0x4(sp)

            la a0, map_buf_len

            jal malloc
            nop

            bnez v0, @@malloc_valid
            nop

            la v0, map_buf_old

            @@malloc_valid:
            la t0, map_buf_ptr
            sw v0, 0(t0)

            lw ra, 0xc(sp)
            lw a0, 0x8(sp)
            lw a1, 0x4(sp)
            addiu sp, sp, 0x10

            ; copied from old code
            lui     a0,0x89e
            lui     a1,0x88b

            j 0x088b083c
            nop

        npc_name_fix:
            addiu sp, sp, -0x10
            sw ra, 0xc(sp)

            li t1, 0
            la v0, party_data+0x500 ; current party

            @@back:
            lh v1, 0(v0)

            ; not Rody or Rhea, skip
            sltiu t2, v1, 7
            bne t2, zero, @@skip
            nop

            ; save this for later
            sw v0, 0x8(sp)

            ; patch name in party data
            li v0, 0xa0
            mult v1, v0
            mflo a0
            la v0, 0x9088edc-0xa0
            addu a0, a0, v0

            ; get pointer
            la v0, str08_ptr-2
            sll v1, v1, 1
            addu v0, v0, v1
            lhu v0, 0(v0)

            ; block pointer, patched by menu insertor
            la a1, 0xdeadbeef

            jal strcpy
            addu a1, a1, v0

            lw v0, 0x8(sp)

            @@skip:
            addiu v0, v0, 2

            ; party is only 6 entries
            sltiu t2, t1, 6
            bne t2, zero, @@back
            addiu t1, t1, 1

            lw ra, 0xc(sp)
            jr ra
            addiu sp, sp, 0x10

        item_found:
            .incbin "out/topx_item_found.bin"
            .align 4

        playtime_str:
            .asciiz "Gald: %d  Play Time: %d:%02d"

        save_cancel:
            .asciiz "Cancel save?"

        load_cancel:
            .asciiz "Cancel load?"

        erase_cancel:
            .asciiz "Cancel delete?"

        no_ms_inserted:
            .ascii "No Memory Stick"
            .db 0x81, 0x7F
            .ascii "is inserted."
            .db 0x0a, 0x0d
            .ascii "At least 384KB of free space is required to save"
            .db 0x0a, 0x0d
            .asciiz "Tales of Phantasia Cross Edition game data."

        ms_space_error:
            .ascii "Insufficient free space on Memory Stick"
            .db 0x81, 0x7F
            .ascii "."
            .db 0x0a, 0x0d
            .ascii "At least 384KB of free space is required to save"
            .db 0x0a, 0x0d
            .asciiz "Tales of Phantasia Cross Edition game data."

        continue_anyway:
            .asciiz "Do you want to start the game anyway?"

        .align 4

        utility_lang_stub:
            ; copied from original code
            sw s1, 0x8(sp)

            li s1, 1
            lui v0,0x91e
            sw s1,-0x3dd0(v0)

            jr ra
            move s1, a0

        utility_lang_stub2:
            ; copied from original code
            sw s1, 0x4(sp)

            li s1, -1
            lui v0,0x91e
            sw s1,-0x3dd0(v0)

            jr ra
            move s1, a0

        utility_lang_stub3:
            li a0, 1
            lui v0,0x91e

            jr ra
            sw a0,-0x43e4(v0)

    .endarea

    ; relocate resident map
    .org 0x8c28fcc
        .dw item_found-reloc_base

   ; FUN_088a6770 - shift-jis conversion - prolog
   ; 088a677c 9b 08      lui     a3,0x89b
   ;          07 3c
   ; 088a6780 10 00      li      a2,0x10
   ;          06 24
   ; 088a6784 d0 10      addiu   a3,a3,0x10d0
   ;          e7 24

   ; 088a6788 00 00      lhu     t0,0x0(a1)
   ;          a8 94
   ; .org 0x088a6788
   ;     ; skip past the old conversion code
   ;     b 0x088a67c4
   ;     lbu v1, 0x0(a1)

   ; 088a67c8 02 00      addiu   a1,a1,0x2
   ;          a5 24
   ; .org 0x088a67c8
   ;      ; new encoding is 8-bit
   ;      addiu a1, a1, 0x1 ; was 0x2

   ; call to sjis memcpy (enemy names)
   ; 08857434 dc 99      jal     FUN_088a6770                      undefined FUN_088a6770()
   ;          22 0e
   ; 08857438 5f 00      _sb     s0,0x5f(s3)
   ;          70 a2
   .org 0x08857434
        jal get_monster_name-reloc_base

   ; 088a6794 00 00      lhu     v1,0x0(t2)=>DAT_089b10d0          = 4081h
   ;          43 95                                                = 4A81h
   ; .org 0x088a6794

   ; btl_msg_disp
   ; arte popup routine
   ; 08889a34 02 2b      jal     FUN_0888ac08                      undefined FUN_0888ac08()
   ;          22 0e
   .org 0x08889a34
        jal get_battle_arte_popup_name-reloc_base

   ; tokugi_start - mastered message
   ; 08837674 02 2b      jal     FUN_0888ac08                      undefined FUN_0888ac08()
   ;          22 0e
   ; 08837678 20 00      _addiu  a0,sp,0x20
   ;          a4 27
   .org 0x08837674
       jal masteredMsg-reloc_base
       addiu a0, sp, 0x20
       nop
       nop
       nop
       nop
       nop

   ; dsp_menu_title - pos x
   ; 088c4594 20 2e      seh     a1,v0
   ;          02 7c
   ; disable old centering
   ; .org 0x088c4594
   ;      li a1, 0x18

   ; fix menu title centering
   ; 088c4574 25 81      jal     FUN_088e0494                      undefined FUN_088e0494()
   ;          23 0e
   .org 0x088c4574
        jal getStringWidth-reloc_base

   ; shop name - disable centering
   ; 088dab4c 20 2e      seh     a1,v0
   ;          02 7c
   ; .org 0x088dab4c
   ;      li a1, 0x18

   ; fix shop name centering
   ; 088dab2c 25 81      jal     FUN_088e0494                      undefined FUN_088e0494()
   ;          23 0e
   .org 0x088dab2c
        jal getStringWidth-reloc_base

   ; shop menu help - second column, button prompts, pos x
   ; 088db13c 74 00      li      a2,0x74
   ;          06 24
   .org 0x088db13c
        li a2, 0x7c

   ; shop menu help - second column, labels, pos x
   ; 088db164 84 00      li      a1,0x84
   ;          05 24
   .org 0x088db164
        li a1, 0x8c

   ; arte popup - width for auto-centering
   ; 08982854 80 18      sll     v1,v0,0x2
   ;          02 00

   ; FUN_08887494 - draw text box for arte popup (a1 = width)
   ; 089828d0 0c 00      _addiu  a2,s0,0xc
   ;          06 26

   ; battle artes menu - glyph width
   ; 088a6b20 08 00      addiu   v0,v0,0x8
   ;          42 24
   ; 088a6b24 2c 00      sh      v0,local_4(sp)
   ;          a2 a7
   .org 0x088a6b20
        jal battle_arte_width_stub
        nop

   ; battle artes menu - TP label, position
   ; 089b08bc 10         ??      10h
   ; 089b08bd 01         ??      01h
   .org 0x089b08bc
        ; pos x
        .dh 0x118 ; was 0x110
        ; pos y
        .dh 0xaa ; was 0xac

   ; battle artes menu - TP number, position
   ; 089b08c0 48         ??      48h    H
   ; 089b08c1 01         ??      01h
   .org 0x089b08c0
        ; pos x
        .dh 0x14e ; was 0x148
        ; pos y
        .dh 0xaa ; was 0xac

   ; Optional ingredients string pos x in cooking menu
   ; 088c1b68 c8 00      li      a1,0xc8
   ;          05 24
   .org 0x088c1b68
        li a1, 0xb0 ; was 0xc8

   ; Requisite string pos x in cooking menu
   ; 088c1ba4 b8 00      li      a1,0xb8
   ;          05 24
   .org 0x088c1ba4
        li a1, 0xa0 ; was 0xb8

   ; Battle Formation menu pos x
   ; 0887a988 28 00      li      a0,0x28
   ;          04 24
   .org 0x0887a988
        li a0, 0x08 ; was 0x28

   ; 08c49dc2 - line-height for big font (used in menu descriptions)
   ; .org 0x08c49dc2
   ;     .db 0x0d ; was 0x10

   ; main item description - pos x
   ; 088c48a0 30 00      _li     a1,0x30
   ;          05 24
   ; .org 0x088c48a0
   ;      li a1, 0x40 ; was 0x30

   ; main item description - pos y
   ; 088c4888 c0 00      li      a2,0xc0
   ;          06 24
   ; .org 0x088c4888
   ;      li a2, 0xbc ; was 0xc0

   ; main item description - window height
   ; 08a2980e 44         ??      44h    D
   ; 08a2980f 00         ??      00h
   .org 0x08a2980e
        .dh 0x54 ; was 0x44

   ; main item menu colon
   ; 088b920c 3a 00      _li     a2,0x3a
   ;          06 24
   .org 0x088b920c
        li a2, 0x20 ; was 0x3a, changed to space

   ; main item menu left column pos x
   ; 088b8eb0 36 00      li      a1,0x36
   ;          05 24
   .org 0x088b8eb0
        li a1, 0x26 ; was 0x36

   ; main item menu right column pos x
   ; 088b8ef0 ca 00      _li     a1,0xca
   ;          05 24
   .org 0x088b8ef0
        li a1, 0xc0 ; was 0xca

   ; main item menu cursor pos x
   .org 0x08a28ed4
        .db 0x18 ; was 0x28

   ; main item menu cursor pos x
   .org 0x08a28ed8
        .db 0x9a ; was 0x94

   ; main item menu top arrow pos x
   ; 088b8f58 9a 00      li      a2,0x9a
   ;          06 24
   .org 0x088b8f58
        li a2, 0x9c ; was 0x9a

   ; main item menu bottom arrow pos x
   ; 088b8f8c 9a 00      li      a2,0x9a
   ;          06 24
   .org 0x088b8f8c
        li a2, 0x9c ; was 0x9a

   ; main item menu - offset between name and number
   ; 088b91ec 40 00      addiu   v0,v0,0x40
   ;          42 24
   .org 0x088b91ec
        addiu v0, v0, 0x58 ; was 0x40

   ; main item menu - item type pos x
   ; 088c4824 f3 00      li      v0,0xf3
   ;          02 24
   ; 088c4828 23 10      subu    v0,v0,v1
   ;          43 00
   .org 0x088c4824
        li v0, 0xc0
        nop

   ; battle menu artes description - pos y
   ; 088761b4 c0 00      li      a1,0xc0
   ;          05 24
   ; .org 0x088761b4
   ;      li a1, 0xbc ; was 0xc0

   ; main menu artes description - pos y
   ; 088b5f54 c0 00      _li     s0,0xc0
   ;          10 24
   ; .org 0x088b5f54
   ;      li s0, 0xbc ; was 0xc0

   ; main menu artes description - window height
   ; 08a28dd6 44         ??      44h    D
   ; 08a28dd7 00         ??      00h
   .org 0x08a28dd6
        .dh 0x54 ; was 0x44

   ; main menu artes description - TP, number offset
   ; 088b6134 18 00      li      a3,0x18
   ;          07 24
   ; 088b6138 68 1b      jal     FUN_088c6da0                      undefined FUN_088c6da0()
   ;          23 0e
   .org 0x088b6134
        li a3, 0x16 ; was 0x18

   ; main menu artes description - TP, number of digits
   ; 088b613c 03 00      _li     t2,0x3
   ;          0a 24
   .org 0x088b613c
        li t2, 0x4 ; was 0x3

   ; main menu artes description - TP, pos y
   ; 088b60d4 ac 00      _li     s0,0xac
   ;          10 24
   ; .org 0x088b60d4
   ;      li s0, 0xaa ; was 0xac

   ; 088b6040 ac 00      _li     s0,0xac
   ;          10 24
   ; .org 0x088b6040
   ;      li s0, 0xaa ; was 0xac

   ; main menu artes description - Mastery, pos y
   ; 088b6068 b4 00      li      a2,0xb4
   ;          06 24
   .org 0x088b6068
        li a2, 0xb6 ; was 0xb4

   ; 088b6000 b4 00      li      a2,0xb4
   ;          06 24
   .org 0x088b6000
        li a2, 0xb6 ; was 0xb4

   ; title menu description - pos y
   ; 088c0578 c0 00      li      a2,0xc0
   ;          06 24
   ; .org 0x088c0578
   ;      li a2, 0xbc ; was 0xc0

   ; title menu description - window size
   ; 08a29564 30         ??      30h    0
   ; 08a29565 01         ??      01h
   ; 08a29566 44         ??      44h    D
   ; 08a29567 00         ??      00h
   .org 0x08a29564
        ; width
        .dh 0x168 ; was 0x130
        ; height
        .dh 0x54 ; was 0x44

   ; cooking menu description - pos y
   ; 088c4bcc c0 00      li      a2,0xc0
   ;          06 24
   ; .org 0x088c4bcc
   ;      li a2, 0xbc ; was 0xc0

   ; equipment menu (left) colon
   ; 088b7600 3a 00      _li     a2,0x3a
   ;          06 24
   .org 0x088b7600
        li a2, 0x20 ; was 0x3a, replaced with space

   ; equipment menu (left) item pos x
   ; 088b75d4 34 00      li      a1,0x34
   ;          05 24
   .org 0x088b75d4
        li a1, 0x24 ; was 0x34

   ; equipment menu (left) cursor pos x
   .org 0x08a28e18
        .db 0x24 ; was 0x34

   ; equipment menu (left) number offset
   ; 088b75e4 74 00      li      a0,0x74
   ;          04 24
   .org 0x088b75e4
        li a0, 0x7c ; was 0x74

   ; equipment menu (right) - equipped items, pos x
   ; 088b7830 e8 00      li      a1,0xe8
   ;          05 24
   .org 0x088b7830
        li a1, 0xe0 ; was 0xe8

   ; equipment menu Slash y pos
   ; 088b78dc 50 00      li      a0,0x50
   ;          04 24
   .org 0x088b78dc
        li a0, 0x4c ; was 0x50

   ; 088b78ac 44 00      li      a2,0x44
   ;          06 24
   .org 0x088b78ac
        li a2, 0x40 ; was 0x44

   ; main artes menu - left side, window coords
   .org 0x08a28d9c
       ; size x
       .dh 0x94 ; was 0x80
       ; size y
       ; .dh 0x84

   ; main artes menu - right side, window coords
   .org 0x08a28db0
       ; pos x
       .dh 0x9c ; was 0x88
       ; pos y
       .dh 0x20
       ; size x
       .dh 0x9c ; was 0xb0
       ; size y
       .dh 0x84

   ; main artes menu - right side, artes pos x
   ; 088b5a50 9c 00      addiu   v0,v0,0x9c
   ;          42 24
   .org 0x088b5a50
        addiu v0, v0, 0xac ; was 0x9c

   ; main artes menu - right side, current column
   ; 088b5a2c 01 00      andi    v1,s3,0x1
   ;          63 32
   .org 0x088b5a2c
        move v1, zero  ; forced to one column


   ; main artes menu - right side, column number
   ; 088b5a18 43 10      _sra    v0,s3,0x1
   ;          13 00
   .org 0x088b5a18
        move v0, s3

   ; main artes menu - right side, cursor position
   .org 0x08a28cf4
        ; x pos
        .db 0xa4 ; was 0x94
        ; y pos
        .db 0x40

   ; main artes menu - Auto/Semi-Auto/Manual - window size
   .org 0x08a28de4
        .dh 0x9c ; was 0xa0

   .org 0x08a28dec
        .dh 0x9c ; was 0xa0

   ; main artes menu - Auto - cursor, pos x
   .org 0x08a28d14
        .dh 0xaa ; was 0xa8

   ; main artes menu - Semi-Auto - cursor, pos x
   .org 0x08a28d1c
        .dh 0xce ; was 0xcc

   ; main artes menu - Manual - cursor, pos x
   .org 0x08a28d24
        .dh 0x102 ; was 0x100

   ; set_menu_special_max - main artes menu number of columns and rows
   ; 088b54dc 02 00      li      s2,0x2
   ;          12 24
   ; 088b54e0 06 00      li      s1,0x6
   ;          11 24
   .org 0x088b54dc
        li s2, 0x1 ; was 0x2

   ; FUN_088c4f80 - discard message
   ; 088c4fec ed 81      jal     add_str_prim                      undefined add_str_prim()
   ;          23 0e
   .org 0x088c4fec
       j discard_msg_stub-reloc_base
       nop

   ; main artes menu - column width (multiply by 0x58)
   ; 088b5d04 80 10      sll     v0,v1,0x2
   ;          03 00
   ; 088b5d08 21 10      addu    v0,v0,v1
   ;          43 00
   ; 088b5d0c 40 10      sll     v0,v0,0x1
   ;          02 00
   ; 088b5d10 21 10      addu    v0,v0,v1
   ;          43 00
   ; 088b5d14 c0 10      sll     v0,v0,0x3
   ;          02 00
   ; 088b5d18 28 00      addiu   v0,v0,0x28
   ;          42 24
   ; 088b5d1c 20 86      seh     s0,v0
   ;          02 7c
   .org 0x088b5d04
        li v0, 0x88
        mult v0, v1
        nop
        mflo v0
        nop
        addiu v0, v0, 0x28

   ; main artes menu - cursor position
   ; .org 0x08a28d04
   ;      .db 0x10 ; was 0x20

   ; main artes menu - cursor position, column width
   .org 0x08a28d08
        .db 0x88 ; was 0x58

   ; main artes menu - number of columns
   ; 088b5538 03 00      li      s2,0x3
   ;          12 24
   .org 0x088b5538
        li s2, 0x2 ; was 0x3

   ; main artes menu - number of columns (divide by 3)
   ; 088b5cc8 55 55      lui     v0,0x5555
   ;          02 3c
   ; 088b5ccc 56 55      ori     v0,v0,0x5556
   ;          42 34
   ; 088b5cd0 18 00      mult    v0,s3
   ;          53 00
   ; 088b5cd4 03 00      li      a2,0x3
   ;          06 24
   ; 088b5cd8 c2 2f      srl     a1,s3,0x1f
   ;          13 00
   ; 088b5cdc 21 20      move    a0,s2
   ;          40 02
   ; 088b5ce0 10 18      mfhi    v1
   ;          00 00
   .org 0x088b5cc8
        sra v1, s3, 1
        li a2, 0x2 ; was 0x3
        srl a1, s3, 0x1f
        move a0, s2
        nop
        nop
        nop

   ; battle artes menu (Cless) - left window coords
   .org 0x089b0828
        ; width
        .dh 0x90 ; was 0x80

   ; battle artes menu (Cless) - right window coords
   .org 0x089b082c
        ; pos x
        .dh 0x100 ; was 0xf0
        ; pos y
        .dh 0x20
        ; width
        .dh 0x70 ; was 0x80

   ; battle items/artes description window height
   ; 089b081a 44         ??      44h    D
   ; 089b081b 00         ??      00h
   .org 0x089b081a
        .dh 0x54 ; was 0x44

   ; world map item description window height
   ; 088ec0e0 44 00      li      v0,0x44
   ;          02 24
   .org 0x088ec0e0
        li v0, 0x54 ; was 0x44

   ; FUN_08837560 - arte mastered routine
   ; increase fixed dest buffer on the stack

   ; 08837560 c0 ff      addiu   sp,sp,-0x40
   ;          bd 27
   .org 0x08837560
        addiu sp, sp, -0xa0

   ; 0883772c 40 00      _addiu  sp,sp,0x40
   ;          bd 27
   .org 0x0883772c
        addiu sp, sp, 0xa0

   ; clear save cover
   ; 088b2d34 9e 08      lui     a0,0x89e
   ;          04 3c
   ; 088b2d38 03 00      lui     v0,0x3
   ;          02 3c
   ; 088b2d3c c4 a1      addiu   a0=>PNG_089da1c4,a0,-0x5e3c       = <PNG-Image>
   ;          84 24
   ; 088b2d40 49 b8      jal     FUN_0892e124                      undefined FUN_0892e124()
   ;          24 0e
   ; 088b2d44 dd ce      _ori    a1,v0,0xcedd
   ;          45 34
   .org 0x089da1c4
        .area 0x08a1e000-.
        clear_save_start:
        .incbin "top_prx_clearsave.png"
        clear_save_end:
        .align 4
        save_icon_start:
        .incbin "top_prx_save.png"
        save_icon_end:
        .endarea

   ; offset didn't change, just size
   .org 0x088b2d38
        lui v0, hi(clear_save_end - clear_save_start)

   .org 0x088b2d44
        ori a1, v0, lo(clear_save_end - clear_save_start)

   ; save icon
   ; 088b2d54 0f 00      beql    v1,v0,LAB_088b2d94
   ;          62 50
   ; 088b2d58 a2 08      _lui    a0,0x8a2
   ;          04 3c
   ; the original code had 3 branches, but all use identical copies of the same image
   .org 0x088b2d54
        b 0x088b2d94
        lui a0, hi(save_icon_start - reloc_base)

   ; 088b2d94 60 ce      addiu   a0=>PNG_08a1ce60,a0,-0x31a0       = <PNG-Image>
   ;          84 24
   ; 088b2d98 3a b8      jal     FUN_0892e0e8                      undefined FUN_0892e0e8()
   ;          24 0e
   ; 088b2d9c bc 5d      _li     a1,0x5dbc
   ;          05 24
   .org 0x088b2d94
        addiu a0, a0, lo(save_icon_start - reloc_base)

   .org 0x088b2d9c
        li a1, save_icon_end - save_icon_start

   ; kana-to-sjis table
   .org 0x08c49e78
        ; patch our a-z to sjis full width a-z
        .db 0x82, 0x81
        .db 0x82, 0x82
        .db 0x82, 0x83
        .db 0x82, 0x84
        .db 0x82, 0x85
        .db 0x82, 0x86
        .db 0x82, 0x87
        .db 0x82, 0x88
        .db 0x82, 0x89
        .db 0x82, 0x8a
        .db 0x82, 0x8b
        .db 0x82, 0x8c
        .db 0x82, 0x8d
        .db 0x82, 0x8e
        .db 0x82, 0x8f
        .db 0x82, 0x90
        .db 0x82, 0x91
        .db 0x82, 0x92
        .db 0x82, 0x93
        .db 0x82, 0x94
        .db 0x82, 0x95
        .db 0x82, 0x96
        .db 0x82, 0x97
        .db 0x82, 0x98
        .db 0x82, 0x99
        .db 0x82, 0x9a

   ; status screen - equipment slot posx
   ; 088c21b0 60 00      li      a1,0x60
   ;          05 24
   .org 0x088c21b0
        li a1, 0x68 ; was 0x60

   ; status screen - equipment name posx
   ; 088c21f8 88 00      li      a1,0x88
   ;          05 24
   .org 0x088c21f8
        li a1, 0x98 ; was 0x88

   ; status screen - level number offset
   ; 088c1ebc 18 00      li      a3,0x18
   ;          07 24
   .org 0x088c1ebc
        li a3, 4 ; was 0x18

   ; status screen - NEXT - number offset
   ; 088c1f5c 18 00      li      a3,0x18
   ;          07 24
   .org 0x088c1f5c
        li a3, 0x25 ; was 0x18

   ; status screen - Strength - number offset
   ; 088c1f90 18 00      li      a3,0x18
   ;          07 24
   .org 0x088c1f90
        li a3, 0x11 ; was 0x18
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Constitution - number offset
   ; 088c1fc4 21 38      move    a3,a1
   ;          a0 00
   .org 0x088c1fc4
        li a3, 0x11 ; was 0x10
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Agility - number offset
   ; 088c1ff8 08 00      li      a3,0x8
   ;          07 24
   .org 0x088c1ff8
        li a3, 0x11 ; was 0x8
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Luck - number offset
   ; 088c202c 21 38      move    a3,a1
   ;          a0 00
   .org 0x088c202c
        li a3, 0x11 ; was 0x10
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Slash - pos y
   ; 088c2068 ac 00      li      a2,0xac
   ;          06 24
   .org 0x088c2068
        li a2, 0xa8 ; was 0xac

   ; status screen - Slash - number offset
   ; 088c206c 18 00      li      a3,0x18
   ;          07 24
   .org 0x088c206c
        li a3, 0x11 ; was 0x18
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Thrust - number offset
   ; 088c20a0 18 00      li      a3,0x18
   ;          07 24
   .org 0x088c20a0
        li a3, 0x11 ; was 0x18
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Attack - number offset
   ; 088c20d8 08 00      li      a3,0x8
   ;          07 24
   .org 0x088c20d8
        li a3, 0x11 ; was 0x8
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Defense - number offset
   ; 088c210c 08 00      li      a3,0x8
   ;          07 24
   .org 0x088c210c
        li a3, 0x11 ; was 0x8
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Accuracy - number offset
   ; 088c2140 21 38      li      a3,0
   ;          00 00
   .org 0x088c2140
        li a3, 0x11 ; was 0
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Evasion - number offset
   ; 088c2174 21 38      move    a3,a1
   ;          a0 00
   .org 0x088c2174
        li a3, 0x11 ; was 0x10
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; monster book - monster name pos x
   ; 088f05a4 30 00      li      a0,0x30
   ;          04 24
   .org 0x088f05a4
        li a0, 0x38 ; was 0x30

   ; monster book - stats x offset (last 3 stats)
   ; 088f0aac 08 00      li      a3,0x8
   ;          07 24
   .org 0x088f0aac
        li a3, 0x15 ; was 0x8

   ; 088f0ab8 68 1b      jal     FUN_088c6da0                      undefined FUN_088c6da0()
   ;          23 0e
   .org 0x088f0ab8
       jal newWriteStrAndNum-reloc_base

   ; 088f0a3c 00 00      lbu     t2,0x0(s3)=>DAT_08c69394          = 06h
   ;         6a 92
   .org 0x088f0a3c
       li t2, 8

   ; monster book - attack element pos x (label)
   ; 088f0b3c d0 00      li      a0,0xd0
   ;          04 24
   .org 0x088f0b3c
        li a0, 0xe0 ; was 0xd0

   ; monster book - attack element pos x (icon)
   ; 088f115c d0 00      li      a1,0xd0
   ;          05 24
   .org 0x088f115c
        li a1, 0xe0 ; was 0xd0

   ; monster book - attack element pos x (???? label)
   ; 088f1288 d8 00      li      a0,0xd8
   ;          04 24
   .org 0x088f1288
        li a0, 0xe8 ; was 0xd8

   ; monster book - element type, pos x
   ; 088f0e70 90 00      li      a0,0x90
   ;          04 24
   .org 0x088f0e70
        li a0, 0x93 ; was 0x90

   ; monster book - element type, pos y
   ; 088f0df8 48 00      li      s5,0x48
   ;          15 24
   .org 0x088f0df8
        li s5, 0x4a ; was 0x48

   ; monster book - attack element type, pos y
   ; 088f1160 48 00      li      a2,0x48
   ;          06 24
   .org 0x088f1160
        li a2, 0x4a ; was 0x48

   ; monster book - resistance (????), pos y
   ; 088f1228 48 00      li      a1,0x48
   ;          05 24
   .org 0x088f1228
        li a1, 0x4a ; was 0x48

   ; monster book - attack element (????), pos y
   ; 088f128c 48 00      li      a1,0x48
   ;          05 24
   .org 0x088f128c
        li a1, 0x4a ; was 0x48

   ; monster book - resistance (None), pos x
   ; 088f1040 88 00      li      a0,0x88
   ;          04 24
   ; .org 0x088f1040
   ;      li a0, 0x93 ; was 0x88

   ; monster book - resistance (None), pos y
   ; 088f1044 48 00      li      a1,0x48
   ;          05 24
   .org 0x088f1044
        li a1, 0x4a ; was 0x48

   ; monster book - attack element (None), pos x
   ; 088f10bc d8 00      _li     a0,0xd8
   ;          04 24
   .org 0x088f10bc
        li a0, 0xe8 ; was 0xd8

   ; monster book - attack element (None), pos y
   ; 088f11c0 48 00      li      a1,0x48
   ;          05 24
   .org 0x088f11c0
        li a1, 0x4a ; was 0x48

   ; monster book - number, pos y
   ; 088f0554 28 00      li      a1,0x28
   ;          05 24
   .org 0x088f0554
        li a1, 0x2c ; was 0x28

   ; item stats - evasion, number offset
   ; 088c4994 14 00      li      a3,0x14
   ;          07 24
   .org 0x088c4994
        li a3, 0xb ; was 0x14

   ; item stats - element icon, pos y
   ; 088c4ab0 d0 00      li      a2,0xd0
   ;          06 24
   .org 0x088c4ab0
        li a2, 0xd2 ; was 0xd0

   ; item stats - defense, number offset
   ; 088c4978 0c 00      li      a3,0xc
   ;          07 24
   .org 0x088c4978
        li a3, 0xb ; was 0xc

   ; 088c4918 04 00      li      a3,0x4
   ;          07 24
   .org 0x088c4918
        li a3, 2 ; was 4

   ; item stats - attack, number of digits
   ; 088c492c 21 48      _move   t1,a3
   ;          e0 00
   .org 0x088c492c
        li t1, 4

   ; item stats - slash
   ; 088c48d8 04 00      li      a3,0x4
   ;          07 24
   ; 088c48dc 20 00      li      a0,0x20
   ;          04 24
   ; 088c48e0 c0 00      li      a1,0xc0
   ;          05 24
   .org 0x088c48d8
        ; number offset
        li a3, 0xe ; was 0x4
        ; posx
        li a0, 0x10 ; was 0x20
        ; posy
        li a1, 0xc4 ; was 0xc0

   ; item stats - slash, number of digits
   ; 088c48ec 21 48      _move   t1,a3
   ;          e0 00
   .org 0x088c48ec
        li t1, 4

   ; item stats - thrust
   ; 088c48f4 04 00      li      a3,0x4
   ;          07 24
   ; 088c48f8 20 00      li      a0,0x20
   ;          04 24
   ; 088c48fc c8 00      li      a1,0xc8
   ;          05 24
   .org 0x088c48f4
        ; number offset
        li a3, 0x8 ; was 0x4
        ; posx
        li a0, 0x10 ; was 0x20
        ; posy
        li a1, 0xce ; was 0xc8

   ; item stats - thrust, number of digits
   ; 088c4908 21 48      _move   t1,a3
   ;          e0 00
   .org 0x088c4908
        li t1, 4

   ; stat-boosting items - Agility, number of digits
   ; 088bc764 68 1b      jal     FUN_088c6da0                      undefined FUN_088c6da0()
   ;          23 0e
   ; 088bc768 03 00      _li     t2,0x3
   ;          0a 24
   .org 0x088bc764
       jal newWriteStrAndNum-reloc_base
       li t2, 9

   ; stat-boosting items - Strength, number of digits
   ; 088bc7a0 68 1b      jal     FUN_088c6da0                      undefined FUN_088c6da0()
   ;          23 0e
   ; 088bc7a4 03 00      _li     t2,0x3
   ;          0a 24
   .org 0x088bc7a0
       jal newWriteStrAndNum-reloc_base
       li t2, 7

   ; stat-boosting items - Strength, pos y
   ; 088bc76c 10 00      addiu   v0,s4,0x10
   ;          82 26
   .org 0x088bc76c
        addiu v0, s4, 0x12 ; was 0x10

   ; stat-boosting items - TP, pos y
   ; 088bc700 10 00      addiu   v0,s4,0x10
   ;          82 26
   .org 0x088bc700
        addiu v0, s4, 0x12 ; was 0x10

   ; disable old code that skipped past the first 3 chars in arcane names
   ; 088375f4 03 00      li      a1,0x3
   ;          05 24
   .org 0x088375f4
        li a1, 0 ; was 0x3

   ; customize controls - right arrow pos x
   ; 088aacd0 21 10      addu    v0,v0,s0
   ;          50 00
   .org 0x088aacd0
        addiu v0, v0, 0x40

   ; main menu - Gald number offset
   ; 088b4030 21 38      li      a3,0
   ;          00 00
   .org 0x088b4030
        li a3, 5 ; was 0

   ; main menu - Max Hits number offset
   ; 088b4100 21 38      li      a3,0
   ;          00 00
   .org 0x088b4100
        li a3, 0x1d ; was 0

   ; main menu - NEXT number offset
   ; 088b3d48 08 00      li      a3,0x8
   ;          07 24
   .org 0x088b3d48
        li a3, 0x15 ; was 0x8

   ; arte popup width
   ; 08887400 43 20      _sra    a0,v1,0x1
   ;          03 00
   .org 0x08887400
        ;sra a0, v1, 0x2
        ; commented out 
        ; no longer needed with proper width code

   ; FUN_088ea7ac
   ; title screen - Kosuke Fujishima - width
   ; 088ea7cc 68 00      li      a1,0x68
   ;          05 24
   .org 0x088ea7cc
        li a1, 0x90 ; was 0x68

   ; 088ea4f4 68 00      li      a1,0x68
   ;          05 24
   .org 0x088ea4f4
        li a1, 0x90 ; was 0x68

   ; title screen - copyright - height
   ; 088ea800 10 00      li      a2,0x10
   ;          06 24
   .org 0x088ea800
        li a2, 0x28 ; was 0x10

   ; 088ea534 10 00      li      a2,0x10
   ;          06 24
   .org 0x088ea534
        li a2, 0x28 ; was 0x10

   ; 088ea544 21 38      move    a3,a2
   ;          c0 00
   .org 0x088ea544
        li a3, 0x10

   ; NDX logo height
   ; 088ea5c8 40 00      li      a2,0x40
   ;          06 24
   .org 0x088ea5c8
        li a2, 0 ; was 0x40

   ; 088ea61c 40 00      li      a2,0x40
   ;          06 24
   .org 0x088ea61c
        li a2, 0 ; was 0x40

   ; FUN_088c2b78
   ; naming screen - number of columns
   ; 088c2c28 04 00      slti    v0,s5,0x4
   ;          a2 2a
   ; 088c2c2c 02 00      addiu   s6,s6,0x2
   ;          d6 26
   ; 088c2c30 e2 ff      bne     v0,zero,LAB_088c2bbc
   ;          40 14
   .org 0x088c2c28
        ; force one column by noping the check
        addiu s6, s6, 0x2
        nop
        nop

   NAME_ENTRY_GLYPHS_PER_ROW equ 0x10
   ; NOTE: edit if you need more rows than English does
   NAME_ENTRY_NUM_ROWS equ 0x5

   ; naming screen - number of glyphs in column
   ; 088c2c08 05 00      slti    v0,s3,0x5
   ;          62 2a
   .org 0x088c2c08
        slti v0, s3, NAME_ENTRY_GLYPHS_PER_ROW ; was 0x5

   ; naming screen - number of rows
   ; 088c2c18 0b 00      slti    v0,s4,0xb
   ;          82 2a
   .org 0x088c2c18
        slti v0, s4, NAME_ENTRY_NUM_ROWS ; was 0xb

   ; naming screen - offset between rows
   ; 088c2c20 0c 00      _addiu  s0,s0,0xc
   ;          10 26
   .org 0x088c2c20
        addiu s0, s0, 0x12 ; was 0xc

   ; naming screen - offset between columns
   ; 088c2c34 48 00      _addiu  s1,s1,0x48
   ;          31 26

   ; naming screen - glyph draw
   ; 088c2bf0 79 84      jal     add_ank_prim                      undefined add_ank_prim()
   ;          23 0e
   ; 088c2bf4 ff ff      _andi   a0,v0,0xffff
   ;          44 30
   ; 088c2bf8 04 00      li      a0,0x4
   ;          04 24
   ; 088c2bfc 0d 81      jal     move_str_cursor                   undefined move_str_cur
   ;          23 0e
   .org 0x088c2bf0
        ; changed to big font
        jal add_knj_prim-reloc_base

   ; naming screen - cursor table (first column)
   .org 0x08a29631
        ; y pos
        .db 0x66 ; was 0x64
        ; chars in column
        .db NAME_ENTRY_GLYPHS_PER_ROW ; was 0x5
        ; rows
        .db NAME_ENTRY_NUM_ROWS ; was 0xb
        ; offset between columns
        .db 0x12 ; was 0xc
        ; offset between rows
        .db 0x12 ; was 0xc

   ; Don't swap cursor mode - LEFT
   .org 0x088C2740 :: nop

   ; Rollover at 16 items - LEFT
   .org 0x088C26FC :: li v1,NAME_ENTRY_GLYPHS_PER_ROW
   .org 0x088C2734 :: addiu v0,a1,NAME_ENTRY_GLYPHS_PER_ROW-1

   ; Don't swap cursor mode - RIGHT
   .org 0x088C27D8 :: nop

   ; Rollover at 16 items - RIGHT
   .org 0x088C2790 :: li v0,NAME_ENTRY_GLYPHS_PER_ROW
   .org 0x088C2798 :: li v0,NAME_ENTRY_GLYPHS_PER_ROW-1
   .org 0x088C27CC :: addiu v0,a0,-(NAME_ENTRY_GLYPHS_PER_ROW-1)

   ; naming screen - top-right window size
   .org 0x08a296fc
        .db 0xb0 ; was 0xb4

   ; naming screen - current name letters pos y
   ; 088c2d2c 30 00      li      a1,0x30
   ;          05 24
   .org 0x088c2d2c
        li a1, 0x34 ; was 0x30

   ; naming screen - current name, font type
   ; 088c2d48 02 00      li      a2,0x2
   ;          06 24
   .org 0x088c2d48
        li a2, 0 ; was 0x2

   ; titles menu - cursor table
   .org 0x08a29514
        ; pos x
        .db 0x98 ; was 0x90

   .org 0x08a29518
        ; column width
        .db 0x68 ; was 0x58

   ; titles menu - current title, cursor pos x
   .org 0x08a2950c
        .db 0x14 ; was 0x24

   ; titles menu - current title, pos x
   ; 088c026c 24 00      li      a1,0x24
   ;          05 24
   .org 0x088c026c
        li a1, 0x14 ; was 0x24

   .org 0x088c0304
        li a1, 0x14 ; was 0x24

   ; titles menu - left column window width
   .org 0x08a29554
        .dh 0x80 ; was 0x78

   ; titles menu - right column window coords
   .org 0x08a29558
        ; pos x
        .dh 0x88 ; was 0x80
        ; pos y
        .dh 0x20
        ; width
        .dh 0xe8 ; was 0xb8

   ; titles menu - right column text offset
   ; 088c03f0 90 00      addiu   v0,v0,0x90
   ;          42 24
   .org 0x088c03f0
        addiu v0, v0, 0x98 ; was 0x90

   ; titles menu - right column size (multiply by 0x58)
   ; 088c03dc 80 10      sll     v0,v1,0x2
   ;          03 00
   ; 088c03e0 21 10      addu    v0,v0,v1
   ;          43 00
   ; 088c03e4 40 10      sll     v0,v0,0x1
   ;          02 00
   ; 088c03e8 21 10      addu    v0,v0,v1
   ;          43 00
   ; 088c03ec c0 10      sll     v0,v0,0x3
   ;          02 00
   .org 0x088c03dc
        li v0, 0x68
        mult v0, v1
        nop
        mflo v0
        nop

   ; Enemy arte routine (Apple Dance)
   ; 088a2a94 01 00      li      a2,0x1
   ;          06 24
   ; 088a2a98 21 20      move    a0,s2
   ;          40 02
   ; 088a2a9c 21 28      move    a1,s0
   ;          00 02
   ; 088a2aa0 21 38      move    a3,a2
   ;          c0 00
   ; 088a2aa4 3c 00      li      t0,0x3c
   ;          08 24
   ; 088a2aa8 71 26      jal     FUN_088899c4                      undefined FUN_088899c4()
   ;          22 0e
   ; force 1-byte encoding
   .org 0x088a2a94
        li a2, 0 ; was 1

   .org 0x088a2aa0
        li a3, 1 ; was copied from a2

   ; Enemy arte routine (Demeter)
   ; 0882fde8 01 00      xori    a2,v0,0x1
   ;          46 38
   ; 0882fdec 4b 00      li      t0,0x4b
   ;          08 24
   ; 0882fdf0 71 26      jal     FUN_088899c4                      undefined FUN_088899c4()
   ;          22 0e

   ; FUN_0887653c - battle string draw
   ; 0887684c 01 00      li      t0,0x1
   ;          08 24
   ; 08876850 ed 81      jal     add_str_prim                      undefined add_str_prim()
   ;          23 0e
   ; .org 0x0887684c
   ;      li t0, 0 ; was 1

   ; FUN_0887737c - battle string draw
   ; 0887774c 01 00      li      t0,0x1
   ;          08 24
   ; 08877750 ed 81      jal     add_str_prim                      undefined add_str_prim()
   ;          23 0e
   ; .org 0x0887774c
   ;      li t0, 0; was 1

   ; FUN_088781ec - battle string draw
   ; 08878574 01 00      li      t0,0x1
   ;          08 24
   ; 08878578 ed 81      jal     add_str_prim                      undefined add_str_prim()
   ;          23 0e
   ; force 1-byte encoding
   ; .org 0x08878574
   ;      li t0, 0 ; was 1

   ; FUN_08878fdc - battle string draw
   ; 08879320 01 00      li      t0,0x1
   ;          08 24
   ; 08879324 ed 81      jal     add_str_prim                      undefined add_str_prim()
   ;          23 0e
   ; force 1-byte encoding
   ; .org 0x08879320
   ;      li t0, 0 ; was 1

   ; FUN_0887a93c - battle string draw
   ; 0887a9b0 01 00      li      t0,0x1
   ;          08 24
   ; 0887a9b4 ed 81      jal     add_str_prim                      undefined add_str_prim()
   ;          23 0e
   ; force 1-byte encoding
   ; .org 0x0887a9b0
   ;      li t0, 0 ; was 1

   ; FUN_0887c0f0 - battle string draw
   ; 0887c434 01 00      li      t0,0x1
   ;          08 24
   ; 0887c438 ed 81      jal     add_str_prim                      undefined add_str_prim()
   ;          23 0e
   ; force 1-byte encoding
   ; .org 0x0887c434
   ;      li t0, 0 ; was 1

   ; FUN_08889a48 - battle string draw
   ; 08889a8c 71 26      jal     FUN_088899c4                      undefined FUN_088899c4()
   ;          22 0e
   ; 08889a90 01 00      _li     a2,0x1
   ;          06 24
   ; force 1-byte encoding
   ; .org 0x08889a8c
   ;      li a2, 0 ; was 1

   ; battle debug menu width
   ; 089b09c8 50         ??      50h    P
   ; 089b09c9 00         ??      00h
   .org 0x089b09c8
        .dh 0x60 ; was 0x50

   ; Dhaos Laser
   ; 08892ac0 01 00      li      a2,0x1
   ;          06 24
   ; 08892ac4 21 28      move    a1,s0
   ;          00 02
   ; 08892ac8 21 20      move    a0,s2
   ;          40 02
   ; 08892acc 21 38      move    a3,a2
   ;          c0 00
   ; forced encoding to 1-byte
   .org 0x08892ac0
        li a2, 0 ; was 0x1

   .org 0x08892acc
        li a3, 1 ; was copied from a2

   ; enemy name popup - counting chars until space
   ; 089824b0 21 38      li      a3,0
   ;          00 00
   ; 089824b4 21 20      li      a0,0
   ;          00 00
   ; 089824b8 10 00      li      v1,0x10
   ;          03 24
   ;                  LAB_089824bc                      XREF[1]: 089824dc(j)  
   ; 089824bc 21 10      addu    v0,s5,a0
   ;          a4 02
   ; 089824c0 00 00      lb      v0,0x0(v0)
   ;          42 80
   ; 089824c4 08 00      beql    v0,v1,LAB_089824e8
   ;          43 50
   ; 089824c8 00 00      _lh     v1,0x0(a2)
   ;          c3 84
   ; 089824cc 05 00      beq     v0,zero,LAB_089824e4
   ;          40 10
   .org 0x089824b0
        ; replace with out string width call
        jal getStringWidthMenu
        ; s5 - string offset
        move a0, s5
        ; a3 - original char count
        move a3, v0

   ; enemy name popup - branch for negative char length
   ; 089824f8 03 00      bgez    a3,LAB_08982508
   ;          e1 04
   ; 089824fc 3e 00      _sh     v1,local_2(sp)
   ;          a3 a7
   ; 08982500 01 00      addiu   v0,a3,0x1
   ;          e2 24
   ; 08982504 43 10      sra     v0,v0,0x1
   ;          02 00
   .org 0x089824f8
        ; skip the entire branch
        b 0x08982508

   ; enemy name popup - another instance of char counting up to 0x16 bytes
   ; 089824e0 01 00      _addiu  a3,a3,0x1
   ;          e7 24
   .org 0x089824e0
        nop

   ; enemy name popup - multiply halved char width by 8 (for centering?)
   ; 08982508 c0 18      sll     v1,v0,0x3
   ;          02 00
   .org 0x08982508
        ; already has pixel width, no need to multiply
        move v1, a3

   ; enemy name popup - multiply char count by 8 to get width
   ; 0898253c c0 88      sll     s1,a3,0x3
   ;          07 00
   .org 0x0898253c
        ; already has pixel width, no need to multiply
        move s1, a3

   ; enemy name popup - branch for odd number of chars
   ; 08982514 02 00      beq     v0,zero,LAB_08982520
   ;          40 10
   ; 08982518 00 00      _nop
   ;          00 00
   ; 0898251c fe ff      addiu   v0,v0,-0x2
   ;          42 24
   .org 0x08982514
        ; skip the entire branch
        b 0x08982520

   ; expand save description name buffer to 7 spaces
   .org 0x08a289fc
        .db 0x81, 0x40
        .db 0x81, 0x40
        .db 0x81, 0x40
        .db 0x81, 0x40
        .db 0x81, 0x40
        .db 0x81, 0x40
        .db 0x81, 0x40
        .db 0x00

   ; Collector's Book - Completion colon posx
   ; 088afcdc e0 00      li      a0,0xe0
   ;          04 24
   .org 0x088afcdc
        li a0, 0xcd ; was 0xe0

   ; Collector's Book - item list posx
   ; 088afdb4 28 00      addiu   v0,v0,0x28
   ;          42 24
   ; .org 0x088afdb4
   ;      addiu v0, v0, 0x18 ; was 0x28

   ; Collector's Book - item list column width (multiply by 0x58)
   ; 088afd9c 18 00      mult    a1,s0
   ;          b0 00
   ; 088afda0 80 10      sll     v0,v1,0x2
   ;          03 00
   ; 088afda4 21 10      addu    v0,v0,v1
   ;          43 00
   ; 088afda8 40 10      sll     v0,v0,0x1
   ;          02 00
   ; 088afdac 21 10      addu    v0,v0,v1
   ;          43 00
   ; 088afdb0 c0 10      sll     v0,v0,0x3
   ;          02 00
   ; 088afdb4 28 00      addiu   v0,v0,0x28
   ;          42 24
   ; 088afdb8 20 2e      seh     a1,v0
   ;          02 7c
   ; 088afdbc 10 10      mfhi    v0
   ;          00 00
   ; 088afdc0 21 18      addu    v1,v0,t0
   ;          48 00
   .org 0x088afd9c
        mult a1, s0
        nop
        mfhi at

        li v0, 0x62
        mult v1, v0
        nop
        mflo v0

        ; item list posx (replaces the original above)
        addiu v0, v0, 0x18 ; was 0x28
        seh a1, v0

        addu v1, at, t0

   ; Collector's Book number/number, pos x
   ; 088afc9c 18 00      li      a1,0x18
   ;          05 24

   ; Collector's Book - item list column width, cursor
   ; 089bd138 58         ??      58h    X
   .org 0x089bd138
        .db 0x62 ; was 0x58

   ; Collector's Book - Item list column width, cursor
   ; 089bd134 28         ??      28h    (
   .org 0x089bd134
        .db 0x18 ; was 0x28

   ; Formation menu - Level label pos x
   ; 088bfbec 64 00      addiu   v0,s0,0x64
   ;          02 26
   .org 0x088bfbec
        addiu v0, s0, 0x5e ; was 0x64

   ; Formation menu - Level label draw call
   ; 088bfc1c 68 1b      jal     FUN_088c6da0                      undefined FUN_088c6da0()
   ;          23 0e
   ; 088bfc20 03 00      _li     t2,0x3
   ;          0a 24
   .org 0x088bfc1c
       jal newWriteStrAndNum-reloc_base
       li t2, 0x6 ; was 0x3

   ; Formation menu - HP/TP, pos x
   ; 088bfc34 2c 00      addiu   s0,s0,0x2c
   ;          10 26
   ; .org 0x088bfc34
   ;     addiu s0, s0, 0x35 ; was 0x2c

   ; Formation menu - HP, number pos x
   ; 088bfc3c 0c 00      li      a3,0xc
   ;          07 24
   .org 0x088bfc3c
        li a3, 0x15

   ; Formation menu - TP, number pos x
   ; 088bfc60 0c 00      _li     a3,0xc
   ;          07 24
   .org 0x088bfc60
        li a3, 0x15

   ; Formation menu - clip box, fix original game bug
   .org 0x08a294d0
        .dh 0x5a ; was 0x58

   ; game_main
   ; 088add58 02 00      li      v1,0x2
   ;          03 24
   ; game mode - start by playing opening FMV instead of immediately displaying the title screen
   .org 0x088add58
        li v1, 0x3 ; was 0x2

   ; Enemy artes routine Conceal (Neo Dhaos)
   ; 08894ea8 01 00      li      a2,0x1
   ;          06 24

   ; 08894ec4 21 38      move    a3,a2
   ;          c0 00
   ; 08894ec8 5a 00      li      t0,0x5a
   ;          08 24
   ; 08894ecc 71 26      jal     btl_msg_disp                      undefined btl_msg_disp()
   ;          22 0e

   ; force 1-byte encoding
   .org 0x08894ea8
        li a2, 0 ; was 1

   .org 0x08894ec4
        li a3, 1 ; was copied from a1

   ; FUN_08887494 - arte popup
   ; encoding for arte popup
   ; 088874c8 84 00      lb      t0,0x84(s2)
   ;          48 82
   .org 0x088874c8
       ; force encoding to 1-byte (fixes Origin's Collapse, possibly others)
       li t0, 0

   ; FUN_088c17b4 - recipe list
   ; pos x
   ; 088c190c 2c 00      li      a1,0x2c
   ;          05 24
   .org 0x088c190c
        li a1, 0x1c ; was 0x2c

   ; 088c18d0 2c 00      li      a1,0x2c
   ;          05 24
   .org 0x088c18d0
        li a1, 0x1c ; was 0x2c

   ; 088c1894 2c 00      li      a1,0x2c
   ;          05 24
   .org 0x088c1894
        li a1, 0x1c ; was 0x2c

   ; cursor pos
   .org 0x08a29568
        .db 0x1c ; was 0x2c

   ; monster book - monster index on first view
   .org 0x089bbac8
        ; was set to the fifth entry for some reason
        .db 0x00 ; was 0x04

   ; sound mode - Voiceover
   ; 088ddfe0 68 1b      jal     FUN_088c6da0                      undefined FUN_088c6da0()
   ;          23 0e
   ; 088ddfe4 04 00      _li     t2,0x4
   ;          0a 24
   .org 0x088ddfe0
       jal newWriteStrAndNum-reloc_base
       li t2, 0xa ; was 0x4

   ; sound mode - Sound Effect
   ; 088ddfa8 68 1b      jal     FUN_088c6da0                      undefined FUN_088c6da0()
   ;          23 0e
   ; 088ddfac 04 00      _li     t2,0x4
   ;          0a 24
   .org 0x088ddfa8
       jal newWriteStrAndNum-reloc_base
       li t2, 0x7 ; was 0x4

   ; sound mode - Song
   ; 088de06c 68 1b      jal     FUN_088c6da0                      undefined FUN_088c6da0()
   ;          23 0e
   ; 088de070 04 00      _li     t2,0x4
   ;          0a 24
   .org 0x088de06c
       jal newWriteStrAndNum-reloc_base
       li t2, 0x9 ; was 0x4

   ; sound mode - Skit
   ; 088de0b0 68 1b      jal     FUN_088c6da0                      undefined FUN_088c6da0()
   ;          23 0e
   ; 088de0b4 04 00      _li     t2,0x4
   ;          0a 24
   .org 0x088de0b0
       jal newWriteStrAndNum-reloc_base
       li t2, 0x9 ; was 0x4

   ; sound mode - Level, pos x
   ; 088de144 40 00      li      a1,0x40
   ;          05 24
   .org 0x088de144
        li a1, 0x19 ; was 0x40

   ; sound mode - Spectrum Analyzer, pos x
   ; 088de28c a8 00      li      a1,0xa8
   ;          05 24
   .org 0x088de28c
        li a1, 0x71 ; was 0xa8

   ; sound mode - total time, pos x
   ; 088de110 38 00      li      a1,0x38
   ;          05 24
   .org 0x088de110
        li a1, 0x30 ; was 0x38

   ; sound mode - get BGM title pointer
   ; 088ddef8 93 7b      jal     FUN_088dee4c                      undefined FUN_088dee4c()
   ;          23 0e
   .org 0x088ddef8
        jal get_bgm_title-reloc_base

   ; sound mode - get voiceover title pointer
   ; 088de018 73 7b      jal     FUN_088dedcc                      undefined FUN_088dedcc()
   ;          23 0e
   ; .org 0x088de018
   ;      jal get_vo_title-reloc_base

   ; replace the old skit event size table
   .org 0x08c5d618
   .area 0x08c5d81c-.
        monsterbook_sort_lut:
        .incbin "out/monsterbook-sorting.bin"
   .endarea

   ; monster number (actual index)
   ; 088f0568 01 00      addiu   a1,fp,0x1
   ;          c5 27
   ; 088f056c 03 00      li      a2,0x3
   ;          06 24
   .org 0x088f0568
        jal monsterbook_get_display_number_sorted

   ; monster number (sequential)
   ; 088f0688 00 00      lh      a1,0x0(v0)=>DAT_0908afc2          = ??
   ;          45 84
   .org 0x088f0688
        jal monsterbook_get_display_number_seq

   ; mon_init
   ; 088f0198 21 40      li      t0,0
   ;          00 00
   ; 088f019c 21 38      li      a3,0
   ;          00 00
   ; 088f01a0 84 5f      addiu   t2,t2,0x5f84
   ;          4a 25
   ; 088f01a4 84 aa      addiu   t1,t1,-0x557c
   ;          29 25
   ; 088f01a8 09 09      lui     v1,0x909
   ;          03 3c
   .org 0x088f0198
        jal monsterbookFixNumbering
        nop
        lw ra, 0xc(sp)
        jr ra
        addiu sp, sp, 0x30

   ; kill reloc
   .orga 0x4E90B4
        nop :: nop

    .orga 0x4E90C4
        nop :: nop

    .orga 0x4E90DC
        nop :: nop

   ; mon_init - number of monsters
   ; 088f0050 d2 01      li      v1,0x1d2
   ;          03 24
   .org 0x088f0050
        li v1, 476 ; was 0x1d2

   .org 0x08c68ed8
        .incbin "monsterbook/dhaos-stats.bin"

   ; monster book - divide by 466 for percentage
   ; 088f07bc a2 8c      lui     v0,0x8ca2
   ;          02 3c
   ; 088f07c0 05 9c      ori     v0,v0,0x9c05
   ;          42 34
   ; 088f07c4 18 00      mult    v0,a1
   ;          45 00
   ; 088f07c8 c2 1f      srl     v1,a1,0x1f
   ;          05 00
   .org 0x088f07bc
        ; replaced with divide by 476
        jal monsterbook_calc_percentage
        nop
        b 0x088f07cc

   ; main item description
   ; 088c489c 19 1c      jal     draw_menu_knj                     undefined draw_menu_kn
   ;          23 0e
   ; 088c48a0 30 00      _li     a1,0x30
   ;          05 24
   .org 0x088c489c
        jal displayWrappedMain-reloc_base

   ; main artes description
   ; 088b5fd0 19 1c      jal     draw_menu_knj                     undefined draw_menu_kn
   ;          23 0e
   ; 088b5fd4 21 40      _li     t0,0
   ;          00 00
   .org 0x088b5fd0
        jal displayWrappedMain-reloc_base

   ; main strategy description
   ; 088bd22c 19 1c      jal     draw_menu_knj                     undefined draw_menu_kn
   ;          23 0e
   ; 088bd230 21 40      _li     t0,0
   ;          00 00
   .org 0x088bd22c
        jal displayWrappedMain-reloc_base

   ; main title description
   ; 088c057c 19 1c      jal     draw_menu_knj                     undefined draw_menu_kn
   ;          23 0e
   ; 088c0580 21 40      _li     t0,0
   ;          00 00
   .org 0x088c057c
        jal displayWrappedMainTitles-reloc_base

   ; cooking description
   ; 088c4bd0 19 1c      jal     draw_menu_knj                     undefined draw_menu_kn
   ;          23 0e
   ; 088c4bd4 21 40      _li     t0,0
   ;          00 00
   ; .org 0x088c4bd0
   ;      jal displayWrappedMain-reloc_base

   ; battle item description
   ; 0887c404 ed 81      jal     add_str_prim                      undefined add_str_prim()
   ;          23 0e
   ; 0887c408 21 48      _li     t1,0
   ;          00 00
   .org 0x0887c404
        jal displayWrappedBattle-reloc_base

   ; battle artes description
   ; 088761dc ed 81      jal     add_str_prim                      undefined add_str_prim()
   ;          23 0e
   ; 088761e0 21 48      _li     t1,0
   ;          00 00
   .org 0x088761dc
        jal displayWrappedBattle-reloc_base

   ; battle strategy description
   ; 088792f0 ed 81      jal     add_str_prim                      undefined add_str_prim()
   ;          23 0e
   ; 088792f4 21 48      _li     t1,0
   ;          00 00
   .org 0x088792f0
        jal displayWrappedBattle-reloc_base

   ; game_mode_end_movie - video play
   ; 088ae2a8 0a 7f      jal     FUN_088dfc28                      undefined FUN_088dfc28()
   ;          23 0e
   ; 088ae2ac 00 00      _nop
   ;          00 00
   .org 0x088ae2a8
        jal end_movie_stub-reloc_base

   ; FUN_0892f578 - audio decode
   ; 0892f6c4 c1 a1      jal     FUN_08928704                      undefined FUN_08928704()
   ;          24 0e
   .org 0x0892f6c4
        jal end_movie_audio_stub-reloc_base

   ; FUN_088b578c - position for SC label
   ; 088b5894 20 00      li      a1,0x20
   ;          05 24
   ; 088b5898 93 00      li      a2,0x93
   ;          06 24
   .org 0x088b5894
        ; pos x
        li a1, 0x24 ; was 0x20
        ; pos y
        li a2, 0x94 ; was 0x93

   ; NG+ message, window y size
   ; 08a2978e 78         ??      78h    x
   ; 08a2978f 00         ??      00h
   .org 0x08a2978e
        .dh 0x60 ; was 0x78

   ; grade shop grade number, number of digits
   ; 088ba0e4 04 00      li      a2,0x4
   ;          06 24
   ; .org 0x088ba0e4
   ;      li a2, 0x7 ; was 0x4

   ; grade shop grade number pos x
   ; 088ba09c b3 00      li      a0,0xb3
   ;          04 24
   .org 0x088ba09c
        li a0, 0xc2 ; was 0xb3

   ; grade shop Total grade number pos x
   ; 088ba100 9a 01      li      a0,0x19a
   ;          04 24
   .org 0x088ba100
       li a0, 0x1aa ; was 0x19a

   ; NOTE: may need to be updated if you add extra accents that require custom sorting
   ; sort_code_dat -  look-up table for sorting kana
   .org 0x08c27704
        .area 256
            .incbin "item-sort-lut.bin"
        .endarea
