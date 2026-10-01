   ; battle item list colon x offset
   ; 088e4f98 40 00      addiu   v0,v0,0x40
   ;          42 24
   .org 0x088e4f98
        addiu v0, v0, 0x48 ; was 0x40

   ; battle item list colon
   ; 088e4fa8 2d 00      _li     a3,0x2d
   ;          07 24
   .org 0x088e4fa8
        li a3, spacer ; was 0x2d

   ; battle item list number offset
   ; 088e4fb8 08 00      addiu   v1,v1,0x8
   ;          63 24

   ; FUN_08908494 - shift-jis conversion - prolog
   ; 089084a0 c1 08      lui     a3,0x8c1
   ;          07 3c
   ; 089084a4 10 00      li      a2,0x10
   ;          06 24
   ; 089084a8 60 82      addiu   a3,a3,-0x7da0
   ;          e7 24

   ; 089084ac 00 00      lhu     t0,0x0(a1)
   ;          a8 94
   ; .org 0x089084ac
   ;     ; skip past the old conversion code
   ;     b 0x089084e8
   ;     lbu v1, 0x0(a1)

   ; 089084ec 02 00      addiu   a1,a1,0x2
   ;          a5 24
   ; .org 0x089084ec
   ;      ; new encoding is 8-bit
   ;      addiu a1, a1, 0x1 ; was 0x2

   ; call to sjis memcpy (enemy names)
   ; 088c142c 25 21      jal     FUN_08908494                      undefined FUN_08908494()
   ;          24 0e
   ; 088c1430 5f 00      _sb     s0,0x5f(s3)
   ;          70 a2
   .org 0x088c142c
        jal get_monster_name-reloc_base

   ; 089084b8 00 00      lhu     v1,0x0(t2)=>DAT_08c08260          = 4081h
   ;          43 95                                                = 4A81h
   ; .org 0x089084b8

   ; btl_msg_disp
   ; arte popup routine
   ; 088ef76c 3d c2      jal     st2cpy                           undefined st2cpy()
   ;          23 0e
   .org 0x088ef76c
        jal get_battle_arte_popup_name-reloc_base

   ; tokugi_start - mastered message
   ; 088ae698 3d c2      jal     st2cpy                           undefined st2cpy()
   ;          23 0e
   ; 088ae69c 20 00      _addiu  a0,sp,0x20
   ;          a4 27
   .orga 0x46E8CC :: nop :: nop ; reloc kill
   .orga 0x46E8D4 :: nop :: nop ; reloc kill
   .org 0x088ae698
       jal masteredMsg-reloc_base
       addiu a0, sp, 0x20
       nop
       nop
       nop
       nop
       nop

   ; battle artes menu - glyph width
   ; 08908848 08 00      addiu   v0,v0,0x8
   ;         42 24
   ; 0890884c 2c 00      sh      v0,local_4(sp)
   ;         a2 a7
   .org 0x08908848
        jal battle_arte_width_stub
        nop

   ; battle artes menu - TP label, position
   ; 08c07a90 10         ??      10h
   ; 08c07a91 01         ??      01h
   .org 0x08c07a90
        ; pos x
        .dh 0x118 ; was 0x110
        ; pos y
        .dh 0xaa ; was 0xac

   ; battle artes menu - TP number, position
   ; 08c07a94 48         ??      48h    H
   ; 08c07a95 01         ??      01h
   .org 0x08c07a94
        ; pos x
        .dh 0x14e ; was 0x148
        ; pos y
        .dh 0xaa ; was 0xac

   ; Battle Formation menu pos x
   ; 088e4194 28 00      li      a0,0x28
   ;          04 24
   .org 0x088e4194
        li a0, 0x08 ; was 0x28

   ; battle menu artes description - pos y
   ; 088e0610 c0 00      li      a1,0xc0
   ;          05 24
   ; .org 0x088e0610
   ;      li a1, 0xbc ; was 0xc0

   ; FVE is slightly different
   ; main artes menu - column width (multiply by 0x58)
   ; 08831968 80 18      sll     v1,a2,0x2
   ;          06 00
   ; 0883196c 21 18      addu    v1,v1,a2
   ;          66 00
   ; 08831970 40 18      sll     v1,v1,0x1
   ;          03 00
   ; 08831974 21 18      addu    v1,v1,a2
   ;          66 00
   ; 08831978 c0 18      sll     v1,v1,0x3
   ;          03 00
   ; 0883197c 28 00      addiu   v1,v1,0x28
   ;          63 24
   ; 08831980 20 96      seh     s2,v1
   ;          03 7c
   .org 0x08831968
        li v1, 0x88
        mult v1, a2
        nop
        mflo v1
        nop
        addiu v1, v1, 0x28
   ; Enemy artes routine Conceal (Neo Dhaos)
   ; 088fa380 01 00      li      a2,0x1
   ;          06 24

   ; 088fa39c 21 38      move    a3,a2
   ;          c0 00
   ; 088fa3a0 5a 00      li      t0,0x5a
   ;          08 24
   ; 088fa3a4 c0 bd      jal     btl_msg_disp                      undefined btl_msg_disp()
   ;          23 0e

   ; force 1-byte encoding
   .org 0x088fa380
        li a2, 0 ; was 1

   .org 0x088fa39c
        li a3, 1 ; was copied from a1

   ; pd_msg - arte popup
   ; encoding for arte popup
   ; 088ed3a8 84 00      lb      t0,0x84(s0)
   ;          08 82
   .org 0x088ed3a8
       ; force encoding to 1-byte (fixes Origin's Collapse, possibly others)
       li t0, 0

   ; battle item description
   ; 088e50b0 16 69      jal     add_str_prim                      undefined add_str_prim()
   ;          21 0e
   ; 088e50b4 21 48      _li     t1,0
   ;          00 00
   .org 0x088e50b0
        jal displayWrappedBattle-reloc_base

   ; battle artes description
   ; 088e0638 16 69      jal     add_str_prim                      undefined add_str_prim()
   ;          21 0e
   ; 088e063c 21 48      _li     t1,0
   ;          00 00
   .org 0x088e0638
        jal displayWrappedBattle-reloc_base

   ; battle strategy description
   ; 088e3740 16 69      jal     add_str_prim                      undefined add_str_prim()
   ;          21 0e
   ; 088e3740 21 48      _li     t1,0
   ;          00 00
   .org 0x088e3740
        jal displayWrappedBattle-reloc_base



   ; Enemy arte routine (Apple Dance)
   ; 0890491c 01 00      li      a2,0x1
   ;          06 24
   ; 08904920 21 20      move    a0,s2
   ;          40 02
   ; 08904924 21 28      move    a1,s0
   ;          00 02
   ; 08904928 21 38      move    a3,a2
   ;          c0 00
   ; 0890492c 3c 00      li      t0,0x3c
   ;          08 24
   ; 08904930 c0 bd      jal     btl_msg_disp                      undefined btl_msg_disp()
   ;          23 0e
   ; force 1-byte encoding
   .org 0x0890491c
        li a2, 0 ; was 1

   .org 0x08904928
        li a3, 1 ; was copied from a2

   ; Enemy arte routine (Demeter)
   ; 088a81bc 01 00      xori    v0,v0,0x1
   ;          42 38
   ; 088a81c0 21 20      move    a0,s2
   ;          40 02
   ; 088a81c4 ff 00      andi    a2,v0,0xff
   ;          46 30
   ; 088a81c8 4b 00      li      t0,0x4b
   ;          08 24
   ; 088a81cc c0 bd      jal     btl_msg_disp                      undefined btl_msg_disp()
   ;          23 0e

   ; FUN_088e0b48 - battle string draw
   ; 088e0f34 01 00      li      t0,0x1
   ;          08 24
   ; 088e0f38 16 69      jal     add_str_prim                      undefined add_str_prim()
   ;          21 0e
   ; .org 0x088e0f34
   ;      li t0, 0 ; was 1

   ; FUN_088e1950 - battle string draw
   ; 088e1db0 01 00      li      t0,0x1
   ;          08 24
   ; 088e1db4 16 69      jal     add_str_prim                      undefined add_str_prim()
   ;          21 0e
   ; .org 0x088e1db0c
   ;      li t0, 0; was 1

   ; FUN_088e27c4 - battle string draw
   ; 088e2bf4 01 00      li      t0,0x1
   ;          08 24
   ; 088e2bf8 16 69      jal     add_str_prim                      undefined add_str_prim()
   ;          21 0e
   ; force 1-byte encoding
   ; .org 0x088e2bf4
   ;      li t0, 0 ; was 1

   ; FUN_088e3424 - battle string draw
   ; 088e3770 01 00      li      t0,0x1
   ;          08 24
   ; 088e3774 16 69      jal     add_str_prim                      undefined add_str_prim()
   ;          21 0e
   ; force 1-byte encoding
   ; .org 0x088e3770
   ;      li t0, 0 ; was 1

   ; FUN_088e4148 - battle string draw
   ; 088e41bc 01 00      li      t0,0x1
   ;          08 24
   ; 088e41c0 16 69      jal     add_str_prim                      undefined add_str_prim()
   ;          21 0e
   ; force 1-byte encoding
   ; .org 0x088e41bc
   ;      li t0, 0 ; was 1

   ; FUN_088e4d94 - battle string draw
   ; 088e50e0 01 00      li      t0,0x1
   ;          08 24
   ; 088e50e4 16 69      jal     add_str_prim                      undefined add_str_prim()
   ;          21 0e
   ; force 1-byte encoding
   ; .org 0x088e50e0
   ;      li t0, 0 ; was 1

   ; btl_msg_disp2 - battle string draw
   ; 088ef7c4 c0 bd      jal     btl_msg_disp                      undefined btl_msg_disp()
   ;          23 0e
   ; 088ef7c8 01 00      _li     a2,0x1
   ;          06 24
   ; force 1-byte encoding
   ; .org 0x088ef7c4
   ;      li a2, 0 ; was 1

   ; battle debug menu width
   ; 08c07bbc 50         ??      50h    P
   ; 08c07bc0 00         ??      00h
   .org 0x08c07bbc
        .dh 0x60 ; was 0x50

   ; Dhaos Laser
   ; 088f8208 01 00      li      a2,0x1
   ;          06 24
   ; 088f820c 21 28      move    a1,s0
   ;          00 02
   ; 088f8210 21 20      move    a0,s2
   ;          40 02
   ; 088f8214 21 38      move    a3,a2
   ;          c0 00
   ; forced encoding to 1-byte
   .org 0x088f8208
        li a2, 0 ; was 0x1

   .org 0x088f8214
        li a3, 1 ; was copied from a2

   ; battle artes menu (Cless) - left window coords
   .org 0x08c079fc
        ; width
        .dh 0x90 ; was 0x80

   ; battle artes menu (Cless) - right window coords
   .org 0x08c07a00
        ; pos x
        .dh 0x100 ; was 0xf0
        ; pos y
        .dh 0x20
        ; width
        .dh 0x70 ; was 0x80

   ; battle items/artes description window height
   ; 08c079ee 44         ??      44h    D
   ; 08c079ef 00         ??      00h
   .org 0x08c079ee
        .dh 0x66 ; was 0x44

   ; tokugi_start - arte mastered routine
   ; increase fixed dest buffer on the stack

   ; 088ae5a0 c0 ff      addiu   sp,sp,-0x40
   ;          bd 27
   .org 0x088ae5a0
        addiu sp, sp, -0xa0

   ; 088ae750 40 00      _addiu  sp,sp,0x40
   ;          bd 27
   .org 0x088ae750
        addiu sp, sp, 0xa0

   ; arte shortcut y pos, button prompt
   .org 0x08C07AA6
        .dh 0xf0 ; was 0xe8

   .org 0x08c07aaa
        .dh 0xfd ; was 0xf5

   ; arte shortcut y pos, character name
   .org 0x08C07AAE
        .dh 0xf4 ; was 0xec

    .org 0x08c07ab2
        .dh 0x101 ; was 0xf9

   ; arte shortcut y pos, arte name
   .org 0x08C07AB6
        .dh 0xf4 ; was 0xec

    .org 0x08c07aba
        .dh 0x101 ; was 0xf9

 ; Make battle arte menus 2 column
 COL_WIDTH equ 0x7A
 div_mod_end equ 0x088e09a8

 ; div/mod by 2 instead of 3
 .org 0x088e0960
 .area div_mod_end-.,0x00
 ; The logic in C is:
 ; pos.x = (index % COL_COUNT) * COL_WIDTH + 0x80;

 li v1, COL_WIDTH
 andi v0,a3,1
 subu v0,zero,v0
 and v0,v0,v1
 addiu v0,v0,0x80
 sh v0,0(a0)

 ; pos.y = (index / COL_COUNT) * ROW_HEIGHT + 0x54;
 sra a3,a3,1
 sll a3,a3,4
 addiu a3,a3,0x54
 sh a3,2(a0)
 b div_mod_ret
 nop
 .endarea

 .org 0x088e0b40
 div_mod_ret:

 ; Only update rows each 2 items
 .org 0x088e102c :: nop

 ; Rollover - LEFT
 ; .org 0x8876b2c :: nop
 ; .org 0x8876b4c :: nop
 .org 0x088e12e0 :: li v0,1

 ; Rollover at 9 items - RIGHT
 .org 0x088e1378 :: li v0,0x9
 .org 0x088e1454 :: li v0,0x8

 ; Rollover - UP
 .org 0x088e1120 :: addiu v0,v0,-2
 .org 0x088e10e8 :: slti v0,v0,2
 .org 0x088e10ec :: slti at,v0,2
 .org 0x088e1110 :: slti v0,v0,2

 ; Rollover at 9 items - DONW
 .org 0x088e115c :: slti at,v0,0x8
 .org 0x088e1170 :: addiu v0,v0,2
 ; 
 ; ; draw only 2 columns
 .org 0x088e0d84 :: nop
 .org 0x088e0e88 :: slti v0,s3,0x2 ; FVE: different register
 ; 
 ; ; adjust second colum pos
 .org 0x088e0e84 :: addiu v1,COL_WIDTH
 ; 
 ; update max scroll down amount
 .org 0x088e0084 :: addiu a0,v1,-10
 .org 0x088e0090 :: sra v1,a0,1
 .org 0x088e0094 :: andi v0, a0, 1 :: addu v1, v0, v1 :: nop
 .org 0x088e00a0 :: nop :: nop :: nop
 .org 0x088e007c :: slti at, v1, 10

; MAX HIT BONUS - number of sprites
; 088eea9c 03 00      slti    v0,s4,0x3
;          82 2a
; .org 0x088eea9c
;     slti v0, s4, 0x2 ; was 0x3

; MAX HIT BONUS - starting sprite ID
; 088eea80 4a 00      addiu   v0,v0,0x4a
;          42 24
; .org 0x088eea80
;     addiu v0, v0, 0x4b ; was 0x4a

; MAX HIT BONUS - pos x
; MAX
; 08c07c24 a8 00      undef   00A8h
; HIT
; 08c07c26 d4 00      undef   00D4h
; BONUS
; 08c07c28 f8         ??      F8h
; .org 0x08c07c24
;     .dh 0xb0; was 0xa8
;     .dh 0xe8 ; was 0xd4
