   ; number of chars in name entry
   ; 0883e5f8 06 00      slti    v0,s1,0x6
   ;          22 2a
   ; .org 0x0883e5f8
   ;      slti v0, s1, 0x7 ; was 0x6

   ; another number of chars in name entry?
   ; 0883e0fc 06 00      slti    v0,s1,0x6
   ;          22 2a
   ; .org 0x0883e0fc
   ;      slti v0, s1, 0x7 ; was 0x6

   ; length check for name variable
   ; 0883e674 06 00      slti    v0,a1,0x6
   ;          a2 28
   .org 0x0883e674
        slti v0, a1, 0x7 ; was 0x6

   ; another length for name variable
   ; 0883e29c 06 00      slti    v1,a2,0x6
   ;          c3 28
   .org 0x0883e29c
        slti v1, a2, 0x7 ; was 0x6

   ; FUN_0883e3f8
   ; naming screen - number of columns
   ; 0883e4a8 04 00      slti    v0,s5,0x4
   ;          a2 2a
   ; 0883e4ac 02 00      addiu   s6,s6,0x2
   ;          d6 26
   ; 0883e4b0 e2 ff      bne     v0,zero,LAB_0883e43c
   ;          40 14
   .org 0x0883e4a8
        ; force one column by noping the check
        addiu s6, s6, 0x2
        nop
        nop

   NAME_ENTRY_GLYPHS_PER_ROW equ 0x10
   ; NOTE: edit if you need more rows than English does
   NAME_ENTRY_NUM_ROWS equ 0x5

   ; naming screen - number of glyphs in column
   ; 0883e488 05 00      slti    v0,s3,0x5
   ;          62 2a
   .org 0x0883e488
        slti v0, s3, NAME_ENTRY_GLYPHS_PER_ROW ; was 0x5

   ; naming screen - number of rows
   ; 0883e498 0b 00      slti    v0,s4,0xb
   ;          82 2a
   .org 0x0883e498
        slti v0, s4, NAME_ENTRY_NUM_ROWS ; was 0xb

   ; naming screen - offset between rows
   ; 0883e4a0 0c 00      _addiu  s0,s0,0xc
   ;          10 26
   .org 0x0883e4a0
        addiu s0, s0, 0x12 ; was 0xc

   ; naming screen - offset between columns
   ; 0883e4b4 48 00      _addiu  s1,s1,0x48
   ;          31 26

   ; naming screen - glyph draw
   ; 0883e470 a2 6b      jal     add_ank_prim                      undefined add_ank_prim()
   ;          21 0e
   ; 0883e474 ff ff      _andi   a0,v0,0xffff
   ;          44 30
   ; 0883e478 04 00      li      a0,0x4
   ;          04 24
   ; 0883e47c 36 68      jal     move_str_cursor                   undefined move_str_cur
   ;          21 0e
   .org 0x0883e470
        ; changed to big font
        jal add_knj_prim-reloc_base

   ; naming screen - cursor table (first column)
   .org 0x089bd75d
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
   .orga 0x43C204 :: nop :: nop ; reloc kill
   .orga 0x43C20C :: nop :: nop ; reloc kill
   .org 0x0883dfc0 :: nop

   ; Rollover at 16 items - LEFT
   .org 0x0883df7c :: li v1,NAME_ENTRY_GLYPHS_PER_ROW
   .org 0x0883dfb4 :: addiu v0,a1,NAME_ENTRY_GLYPHS_PER_ROW-1

   ; Don't swap cursor mode - RIGHT
   .orga 0x43C254 :: nop :: nop ; reloc kill
   .orga 0x43C25C :: nop :: nop ; reloc kill
   .org 0x0883e058 :: nop

   ; Rollover at 16 items - RIGHT
   .org 0x0883e010 :: li v0,NAME_ENTRY_GLYPHS_PER_ROW
   .org 0x0883e018 :: li v0,NAME_ENTRY_GLYPHS_PER_ROW-1
   .org 0x0883e04c :: addiu v0,a0,-(NAME_ENTRY_GLYPHS_PER_ROW-1)

    ; entry count for page swap
    .org 0x089bd762
        .dh NAME_ENTRY_NUM_ROWS*NAME_ENTRY_GLYPHS_PER_ROW

   ; naming screen - top-right window size
   .org 0x089bd828
        .db 0xb0 ; was 0xb4

   ; naming screen - current name letters pos y
   ; 0883e5a8 30 00      li      a1,0x30
   ;          05 24
   .org 0x0883e5a8
        li a1, 0x34 ; was 0x30

   ; naming screen - current name, font type
   ; 0883e5c4 02 00      li      a2,0x2
   ;          06 24
   .org 0x0883e5c4
        li a2, 0 ; was 0x2

; FUN_0883e508 - rename screen, remove reversed name order for Suzu (squares)
; 0883e554 06 00      li      v0,0x6
;          02 24
; 0883e558 04 00      beql    v1,v0,LAB_0883e56c
;          62 50
; 0883e55c 20 00      _li     a1,0x20
;          05 24
.org 0x0883e554
    nop :: nop :: nop

; start_menu_name - rename screen, remove reversed name order for Suzu (cursor)
; 0883e310 00 00      lhu     v1,0x0(s0)=>party_data
;          03 96
; 0883e314 06 00      li      v0,0x6
;          02 24
; 0883e318 02 00      beql    v1,v0,LAB_0883e324
;          62 50
; 0883e31c 60 00      _li     v0,0x60
;          02 24
.org 0x0883e310
    nop :: nop :: nop :: nop

; load_game - epilog
; 0882bdcc 08 00      jr      ra
;         e0 03
; 0882bdd0 10 00      _addiu  sp,sp,0x10
;         bd 27
.org 0x0882bdcc
    j npc_name_fix

; add_party_member - epilog
; 088494d0 08 00      jr      ra
;         e0 03
; 088494d4 20 00      _addiu  sp,sp,0x20
;         bd 27
.org 0x088494d0
    j npc_name_fix

; adjustment for name menu - 7 characters
; writing name back to ram
.org 0x0883e218
    slti v0, a3, 0x7
.org 0x0883e228
    li a1, 0x7
; displaying text squares
.org 0x0883e5f8
    slti v0, s1, 0x7
; move last name x
.org 0x0883e560
    li a1, 0x8C
; move last name y
.org 0x0883e598
    li a2, 0x36
; move entered name starting x to center-sorta
.org 0x0883e5a4
    addiu a0, s0, 0x4
; somethign to do with the arrow pointer..
.org 0x0883e0fc
    slti v0, s1, 0x7
.org 0x089bd74e
    .byte 0x7	; change max cursor to 7
.org 0x0883de98
	slti at, a0, 0x6		; allow keyboard to go to 7th char while typing
.org 0x0883e22c
    ; change hardcoded addr when counting backwards
    ; to be 1 higher, fixes the space at end
    addiu a0, a0, lo(0x08dfac73-reloc_base)    
; copy all 7 chars on init (FVE-only)
.org 0x0883e18c
    slti v1, a2, 0x7
