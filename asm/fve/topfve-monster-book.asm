; Monster Book fixes
.org 0x0890b900
    li t2, 8
    jal newWriteStrAndNum-reloc_base

.org 0x0890b8b8
	li a3, 0x15

   ; monster book - monster name pos x
   ; 0890b4f8 30 00      li      a0,0x30
   ;          04 24
   .org 0x0890b4f8
        li a0, 0x38 ; was 0x30

   ; monster book - stats x offset (last 3 stats)
   ; 0890b9fc 08 00      li      a3,0x8
   ;          07 24
   .org 0x0890b9fc
        li a3, 0x15 ; was 0x8

   ; 0890ba08 09 07      jal     draw_title_param                 undefined draw_title_param()
   ;          21 0e
   .org 0x0890ba08
       jal newWriteStrAndNum-reloc_base

   ; 0890b98c 00 00      lbu     t2,0x0(s3)=>DAT_08c0cbdc          = 06h
   ;         6a 92
   .org 0x0890b98c
       li t2, 8

   ; monster book - attack element pos x (label)
   ; 0890ba8c d0 00      li      a0,0xd0
   ;          04 24
   .org 0x0890ba8c
        li a0, 0xe0 ; was 0xd0

   ; monster book - attack element pos x (icon)
   ; 0890c0b0 d0 00      li      a1,0xd0
   ;          05 24
   .org 0x0890c0b0
        li a1, 0xe0 ; was 0xd0

   ; monster book - attack element pos x (???? label)
   ; 0890c1dc d8 00      li      a0,0xd8
   ;          04 24
   .org 0x0890c1dc
        li a0, 0xe8 ; was 0xd8

   ; monster book - element type, pos x
   ; 0890bdc4 90 00      li      a0,0x90
   ;          04 24
   .org 0x0890bdc4
        li a0, 0x93 ; was 0x90

   ; monster book - element type, pos y
   ; 0890bd4c 48 00      li      s5,0x48
   ;          15 24
   .org 0x0890bd4c
        li s5, 0x4a ; was 0x48

   ; monster book - attack element type, pos y
   ; 0890c0b4 48 00      li      a2,0x48
   ;          06 24
   .org 0x0890c0b4
        li a2, 0x4a ; was 0x48

   ; monster book - resistance (????), pos y
   ; 0890c17c 48 00      li      a1,0x48
   ;          05 24
   .org 0x0890c17c
        li a1, 0x4a ; was 0x48

   ; monster book - attack element (????), pos y
   ; 0890c1e0 48 00      li      a1,0x48
   ;          05 24
   .org 0x0890c1e0
        li a1, 0x4a ; was 0x48

   ; monster book - resistance (None), pos x
   ; 0890bf94 88 00      li      a0,0x88
   ;          04 24
   ; .org 0x0890bf94
   ;      li a0, 0x93 ; was 0x88

   ; monster book - resistance (None), pos y
   ; 0890bf98 48 00      li      a1,0x48
   ;          05 24
   .org 0x0890bf98
        li a1, 0x4a ; was 0x48

   ; monster book - attack element (None), pos x
   ; 0890c010 d8 00      _li     a0,0xd8
   ;          04 24
   .org 0x0890c010
        li a0, 0xe8 ; was 0xd8

   ; monster book - attack element (None), pos y
   ; 0890c114 48 00      li      a1,0x48
   ;          05 24
   .org 0x0890c114
        li a1, 0x4a ; was 0x48

   ; monster book - number, pos y
   ; 0890b4a8 28 00      li      a1,0x28
   ;          05 24
   .org 0x0890b4a8
        li a1, 0x2c ; was 0x28

   ; monster book - monster index on first view
   .org 0x08962360
        ; was set to the fifth entry for some reason
        .db 0x00 ; was 0x04

   ; replace the old skit event size table
   .org 0x08bee27c
   .area 0x08bee480-.
        monsterbook_sort_lut:
        .incbin OUT_DIR+"/monsterbook-sorting.bin"
   .endarea

   ; monster number (actual index)
   ; 0890b4bc 01 00      addiu   a1,fp,0x1
   ;          c5 27
   ; 0890b4d0 03 00      li      a2,0x3
   ;          06 24
   .org 0x0890b4bc
        jal monsterbook_get_display_number_sorted

   ; monster number (sequential)
   ; 0890b5dc 00 00      lh      a1,0x0(v0)=>DAT_09ce8fba          = ??
   ;          45 84
   .org 0x0890b5dc
        jal monsterbook_get_display_number_seq

   ; mon_init
   ; 0890b0f8 21 40      li      t0,0
   ;          00 00
   ; 0890b0fc 21 38      li      a3,0
   ;          00 00
   ; 0890b100 dc 97      addiu   t2,t2,-0x6824
   ;          4a 25
   ; 0890b104 e0 91      addiu   t1,t1,-0x6e20
   ;          29 25
   ; 0890b108 cf 09      lui     v1,0x9cf
   ;          03 3c
   .org 0x0890b0f8
        jal monsterbookFixNumbering
        nop
        lw ra, 0xc(sp)
        jr ra
        addiu sp, sp, 0x30

   ; kill relocs
   .orga 0x47F954 :: nop :: nop
   .orga 0x47F964 :: nop :: nop
   .orga 0x47F97C :: nop :: nop

   ; mon_init - number of monsters
   ; 0890afa8 d2 01      li      v1,0x1d2
   ;          03 24
   .org 0x0890afa8
        li v1, 476 ; was 0x1d2

   .org 0x08c0c730
        .incbin OUT_DIR+"/monsterbook/dhaos-stats.bin"

   ; monster book - divide by 466 for percentage
   ; 0890b710 a2 8c      lui     v0,0x8ca2
   ;          02 3c
   ; 0890b714 05 9c      ori     v0,v0,0x9c05
   ;          42 34
   ; 0890b718 18 00      mult    v0,a1
   ;          45 00
   ; 0890b71c c2 1f      srl     v1,a1,0x1f
   ;          05 00
   .org 0x0890b710
        ; replaced with divide by 476
        jal monsterbook_calc_percentage
        nop
        b 0x0890b720
