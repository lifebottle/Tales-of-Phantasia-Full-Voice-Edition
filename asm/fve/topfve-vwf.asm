; NOTE: you need to change this if you added new glyphs
vwf_glyphs_end equ 0x90
spacer equ 0x6d

.definelabel add_knj_prim,0x0885aa00
.definelabel btl_str2,0x088a8f30
.definelabel strcpy,0x0880d6e4

; add_knj_prim - prolog
   ; 0885aa10 ff ff      andi    s1,a0,0xffff
   ;          91 30
   ; 0885aa14 01 07      slti    at,s1,0x701
   ;          21 2a
   .org 0x0885aa10
        j add_knj_prim_prolog_stub
        nop

; add_knj_prim - char width
   ; 0885ad40 04 09      lui     v1,0x904
   ;          03 3c
   ; 0885ad44 b6 7e      lh      a0,offset csr_x(v1)              = ??
   ;          64 84
   ; 0885ad48 04 09      lui     v1,0x904
   ;          03 3c
   ; 0885ad4c 0e 00      addiu   a0,a0,0xe
   ;          84 24
   .orga 0x44F0A4 :: nop :: nop ; reloc kill
   .org 0x0885ad48
        j add_knj_prim_width_stub
        nop

; add_knj_prim - epilog
   ; 0885ad64 08 00      jr      ra
   ;          e0 03
   ; 0885ad68 10 00      _addiu  sp,sp,0x10
   ;          bd 27
   ; .org 0x0885ad68
   ;      addiu sp, sp, 0x14 ; was 0x10

; set_top_win_adr prolog
   ; 0885b4fc ff ff      andi    v1,v0,0xffff
   ;          43 30
   ; 0885b4fc 0f 00      li      v0,0xf
   ;          02 24
   .org 0x0885b4fc
        j set_top_win_adr_stub
        andi v1, v0, 0xffff

; set_top_win_adr char width
   ; 0885b53c 0e 00      addiu   s5,s5,0xe
   ;          b5 26
   org 0x0885b53c
        addu s5, s5, t0

; set_top_win_adr window width
   ; 0885b574 e0 01      li      v0,0x1e0
   ;          02 24
   ; 0885b578 23 18      subu    v1,v0,s5
   ;          55 00
   org 0x0885b574
        j set_top_win_adr_width
        nop

   ; disable play time animation for now
   ;                  s_%3d_%02d_089bcdf4               XREF[2]: FUN_088301fc:0883025c(
   ;                                                             089bce04(*)  
   ; 089bcdf4 25 33      ds      "%3d %02d"
   ;          64 20 
   ;          25 30 
   .org 0x089bcdf4
        .asciiz "%3d:%02d"

   ; FUN_088301fc - animated play time
   ; 088302d4 21 30      li      a2,0
   ;          00 00
   ; 088302d8 21 38      li      a3,0
   ;          00 00
   .org 0x088302d4
        jal play_time_stub
        nop

   ; shop spacer (dot)
   ; 08854dec 50 00      li      v1,0x50
   ;          03 24
   .org 0x08854dec
        li v1, spacer ; was 0x50


   ; add_ank_prim - kana font width
   ; 0885b068 04 09      lui     v1,0x904
   ;          03 3c
   ; 0885b06c 08 00      addiu   a0,a0,0x8
   ;          84 24
   .orga 0x44F284 :: nop :: nop ; reloc kill
   .org 0x0885b068
       j add_ank_prim_width_stub
       nop

   ; kana font y pos
   ; 0885af74 0a 00      sh      t2,0xa(v1)
   ;          6a a4
   ; 0885af78 0c 00      sb      t4,0xc(v1)
   ;          6c a0
   .org 0x0885af74
        j menu_get_char_yoffs
        nop

   ; add_ank_prim prolog
   ; 0885ae88 be 08      lui     v1,0x8be
   ;          03 3c
   ; 0885ae8c dc a9      lhu     a2,-0x5624(v1)=>ank_cnv_tbl       = 00CDh
   ;          66 94
   .orga 0x44F154 :: nop :: nop ; reloc kill
   .orga 0x44F15C :: nop :: nop ; reloc kill
   .org 0x0885ae88
        j add_ank_prim_prolog_stub
        nop

   ; add_ank_prim dakuten/handakuten
   ; 0885afa8 2d 00      beq     v1,zero,LAB_0885b060
   ;          60 10
   .org 0x0885afa8
        b 0x0885b060

   ; disp_str_8 - battle item glyph width
   ; 089087ac 08 00      addiu   v0,v0,0x8
   ;          42 24
   ; 089087b0 1c 00      sh      v0,local_4(sp)
   ;          a2 a7
   .org 0x089087ac
        jal battle_item_width_stub
        nop

; adjustment for topOriGuScissor
; fixes descenders getting cut off on bottom row...
; removed in favor of a proper fix
.org 0x08882714
   addiu a3, v0, 0x2		; change from +1 to +2 for an extra y

; battle arte menu width
.org 0x08c07b04
	.byte 0x40 + 0x20	; incr width from 40 to 60

; battle item menu height
 .org 0x08c07b62
 	.byte 0x60 + 1	; incr by 1 for bottom line descenders

; main item menu height
.org 0x089bd0a6
	.byte 0x54 + 1	; incr by 1 for bottom line descenders

.org 0x0885c930 
    li v1, 0x54     ; new start x-pos for box text printing
                    ; changed from 0x7c

; opening
.org 0x0885c90c	
	li v1, 0x54     ; new start x-pos for box text printing
                    ; changed from 0x7c

.org 0x0885cff8
    li a3, 0x140    ; new box width
                    ; changed from 0xE8

.org 0x0885c9a4
    li a1, 0x50     ; new starting x-pos for box
                    ; changed from 0x7c

.org 0x0885cb6c
    addiu v0, v0, 0x123     ; new x-pos for circle prompt button
                            ; changed from 0xd6

; arte popup proper width
.org 0x088ed2cc
	jal getStringWidth-reloc_base

   ; battle item primitive coords 
   ; pos x
   ; 08908694 08 00      sh      v0,0x8(s1)
   ;          22 a6
   ; pos y
   ; 08908698 02 00      lh      v0,0x2(s2)
   ;          42 86
   ; 0890869c 87 fd      jal     GetClut                           undefined GetClut()
   ;          21 0e
   ; 089086a0 0a 00      _sh     v0,0xa(s1)
   ;          22 a6
   ;
   .org 0x08908694
        jal battle_item_yoffs_stub
        sh v0, 0x8(s1)

   ; change space in ascii2ank conversion table to our spacer
   .org 0x08bda50c
        .db spacer ; was 0x10

   ; char width in menu titles (called from dsp_menu_title)
   ; 0885a280 0e 00      _addiu  s2,s2,0xe
   ;          52 26
   ; .org 0x0885a280
   ;      addiu s2, s2, 0x20

    ; .org 0x0885ae7c
    ;     addiu v1, v1, 0x6 ; was 0xc

   ; furigana for main artes menu
   ; 08831b98 04 00      bne     s0,zero,LAB_08831bac
   ;          00 16
      .org 0x08831b98
        nop

   ; fix menu title centering
   ; 0883f7cc 4e 68      jal     get_str_len                       undefined get_str_len()
   ;          21 0e
   .org 0x0883f7cc
        jal getStringWidth-reloc_base

   ; shop name - disable centering
   ; 088549e4 20 2e      seh     a1,v0
   ;          02 7c
   ; .org 0x088549e4
   ;      li a1, 0x18

   ; fix shop name centering
   ; 088549c4 4e 68      jal     get_str_len                       undefined get_str_len()
   ;          21 0e
   .org 0x088549c4
        jal getStringWidth-reloc_base

   ; kana-to-sjis table
   .org 0x08bdaae8
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

   ; make_msg_buf - remove special handling for quote character
   ; 0885bb44 12 00      li      v1,0x12
   ;          03 24
   ; 0885bb48 71 00      beq     a0,v1,LAB_0885bd10
   ;          83 10
   .org 0x0885bb44
        nop
        nop
