   ; old skit lip debug
   ; 08860bb0 0e 00      beq     v1,zero,LAB_08860bec
   ;          60 10
   ; 08860bb4 00 00      _nop
   ;          00 00
   ; 08860bb8 08 00      li      a0,0x8
   ;          04 24
   ; 08860bbc 21 28      move    a1,a0
   ;          80 00
   ; 08860bc0 04 81      jal     set_str_cursor                    undefined set_str_curs
   ;          23 0e
   ; 08860bc4 21 30      _li     a2,0
   ;          00 00
   ; 08860bc8 06 09      lui     v0,0x906
   ;          02 3c
   ; 08860bcc 5c 8e      lh      a1,-0x3854(v0)=>DAT_0905c7ac      = ??
   ;          45 84
   ; 08860bd0 05 00      li      a2,0x5
   ;          06 24
   ; 08860bd4 21 38      li      a3,0
   ;          00 00
   ; 08860bd8 06 09      lui     v0,0x906
   ;          02 3c
   ; 08860bdc bc c7      lw      a0,-0x3844(v0)=>DAT_0905c7bc      = ??
   ;          44 8c
   ; 08860be0 21 40      li      t0,0
   ;          00 00
   ; 08860be4 af 68      jal     add_dec_prim                      undefined add_dec_prim()
   ;          23 0e
   ; 08860be8 21 48      _li     t1,0
   ;          00 00

   ; replaced old skit debug
   .org 0x08860bb0
        j display_skit_stub
        nop

   ; FUN_08861700 (tsce_talk_parameter)
   ; 08861860 03 00      sb      zero,0x3(v0)=>DAT_0905c7e7        = ??
   ;          40 a0
   ; 08861864 02 00      lbu     v1,0x2(v0)=>DAT_0905c7e6          = ??
   ;          43 90
   ; 08861868 08 00      ori     v1,v1,0x8
   ;          63 34
   ; increment current string on lip flap
   .org 0x08861860
        jal increment_skit_str

   ; exec_sce_talk
   ; note: Phantasian Productions did this hook at 8860a58
   ; 08860c80 64 00      li      a0,0x64
   ;          04 24
   ; reset current string on skit fade-out
   .org 0x08860c80
        jal reset_skit_str

   ; read skit size from skit header instead of table
   .org 0x08862114
        lhu a2, 0x4(a1)

   ; snd_set_r_voice prolog, s3 = voice clip number (different register in FVE)
   ; 08845f6c 21 a8      move    s5,a1
   ;          a0 00
   .org 0x08845f6c
       jal btl_quote_set

   ; snd_end_r_voice epilog
   ; 0884625c 08 00      jr      ra
   ;          e0 03
   ; 0884625c 10 00      _addiu  sp,sp,0x10
   ;          bd 27
   .org 0x0884625c
        j btl_quote_stop

   ; battle_init epilog
   ; 088a1490 08 00      jr      ra
   ;          e0 03
   ; 088a1494 10 00      _addiu  sp,sp,0x10
   ;          bd 27
   .org 0x088a1490
        j btl_quote_stop

   ; snd_break_voice
   ; 08846368 ce a4      jal     sndStrStop                        undefined sndStrStop()
   ;          24 0e
   ; .org 0x08846368
   ;      jal btl_quote_stop-reloc_base

   ; sndStrStop epilog
   ; 08890708 08 00      jr      ra
   ;          e0 03
   ; 0889070c 21 10      _li     v0,0
   ;          00 00
   ; .org 0x08890708
   ;      j btl_quote_stop

   ; pchr_disp - battle draw routine
   ; 088ef690 21 80      li      s0,0
   ;          00 00
   ; 088ef694 f8 7f      addu    s1,s1,0x7ff8
   ;          31 26
   .org 0x088ef690
        jal display_quote_stub

   ; arte popup text y pos
   ; 088ed3a4 0e 00      _li     a1,0xe
   ;          05 24
   .org 0x088ed3a4
        li a1, 0x1e ; was 0xe

   ; FVE uses PSX-style rendering instead of X's sprite Manager
   ; arte popup - window, y pos
   .org 0x08c07bea
        .db 0x1a ; was 0x0a

   ; cooking menu routine epilog
   ; 0883fe3c 08 00      jr      ra
   ;          e0 03
   ; 0883fe40 30 00      _addiu  sp,sp,0x30
   ;          bd 27

   ; cooking recipe description draw
   ; 0883fe20 ba 07      jal     draw_menu_knj                     undefined draw_menu_kn
   ;          21 0e
   ; 0883fe24 21 40      _li     t0,0
   ;          00 00
   .org 0x0883fe20
        jal display_cooking_stub-reloc_base

   ; cooking recipe message routine epilog
   ; 0883cd54 08 00      jr      ra
   ;          e0 03
   ; 0883cd58 10 00      _addiu  sp,sp,0x10
   ;          bd 27

   ; displaying the recipe icon and name
   ; 0883fd84 ff ff      addiu   v0,v0,-0x1
   ;          42 24
   ; 0883fd88 72 1a      jal     FUN_0884184c                      undefined FUN_0884184c()
   ;          23 0e
   ; .org 0x0883fd88
   ;      jal recipe_skip_icon-reloc_base

   ; cooking recipe "Ingredients Used" draw
   ; 0883cc5c 85 07      jal     draw_menu_str                     undefined draw_menu_st
   ;          21 0e
   ; 0883cc60 01 00      _li     t0,0x1
   ;          08 24
   .org 0x0883cc5c
        jal btl_quote_stop_cooking-reloc_base

   ; msg_window_frame epilog
   ; 0885cf88 08 00      jr      ra
   ;          e0 03
   ; 0885cf8c 10 00      _addiu  sp,sp,0x10
   ;          bd 27
   .org 0x0885cf88
        j display_quote_nmap

   ; game_mode_arche - epilog
   ; 0882c848 08 00      jr      ra
   ;          e0 03
   ; 0882c84c 30 00      _addiu  sp,sp,0x30
   ;          bd 27
   ; blank out phantom Groovy Arche subs
   .org 0x0882c848
        j btl_quote_stop_stub

   ; game_mode_sndmode - epilog
   ; 0882c0f0 08 00      jr      ra
   ;          e0 03
   ; 0882c0f4 10 00      _addiu  sp,sp,0x10
   ;          bd 27
   ; get rid of phantom subs after exiting sound mode
   .org 0x0882c0f0
        j btl_quote_stop_stub

   ; dsp_menu_custom_main - row gap (text)
   ; 08828f10 0f 00      addiu   s5,s5,0xf
   ;          b5 26
   .org 0x08828f10
        .ifndef disable_qol
            addiu s5, s5, 0xd ; was 0xf
        .else
            addiu s5, s5, 0xe ; was 0xf
        .endif

   ; menu_custom_main - row gap (cursor)
   ; 089e6f49 0f         ??      0Fh
   .org 0x089e6f49
        .ifndef disable_qol
            .db 0x0d ; was 0xf
        .else
            .db 0x0e ; was 0xf
        .endif

   ; menu_custom_main - number of items (cursor)
   ; 089e6f4a 0e         ??      0Eh
   .org 0x089e6f4a
        .ifndef disable_qol
            .db 0x10 ; was 0xe
        .else
            .db 0xf ; was 0xe
        .endif

   ; menu_custom_main - number of values
   ; 088271b8 0d 00      sltiu   at,v0,0xd
   ;          41 2c
   .org 0x0088271b8
        .ifndef disable_qol
            sltiu at, v0, 0xf ; was 0xd
        .else
            sltiu at, v0, 0xe ; was 0xd
        .endif

   ; start_menu_custom - number of items (cursor) in full customize menu (overwrites the above)
   ; 088289f8 0b 00      li      v1,0xb
   ;          03 24
   .org 0x088289f8
        .ifndef disable_qol
            li v1, 0xd ; was 0xb
        .else
            li v1, 0xc ; was 0xb
        .endif

   ; start_menu_custom - number of items (cursor) in normal customize menu (overwrites the above)
   ; 088289ec 0c 00      _li     v1,0xc
   ;          03 24
   .org 0x088289ec
        .ifndef disable_qol
            li v1, 0xe ; was 0xc
        .else
            li v1, 0xd ; was 0xc
        .endif

   ; dsp_menu_custom_main - number of toggles to draw
   ; 08828f0c 0c 00      slti    v0,s0,0xc
   ;          02 2a
   .org 0x08828f0c
        .ifndef disable_qol
            slti v0, s0, 0xe ; was 0xc
        .else
            slti v0, s0, 0xd ; was 0xc
        .endif

   ; dsp_menu_custom_main - number of labels to draw
   ; 08828b28 0b 00      li      v0,0xb
   ;          02 24
   .org 0x08828b28
        .ifndef disable_qol
            li v0, 0xd ; was 0xb
        .else
            li v0, 0xc ; was 0xb
        .endif

   ; dsp_menu_custom_main - number of values to draw
   ; 08828b70 0c 00      sltiu   at,s0,0xc
   ;          01 2e
   .org 0x08828b70
        .ifndef disable_qol
            sltiu at, s0, 0xe ; was 0xc
        .else
            sltiu at, s0, 0xd ; was 0xc
        .endif

   ; dsp_menu_custom_main - jump table for drawing values
   ; 08828b7c 95 08      lui     v1,0x895
   ;          03 3c
   ; 08828b80 bc a4      addiu   v1,v1,-0x5b44
   ;          63 24
   .org 0x08828b7c
        la v1, dsp_menu_custom_switch-reloc_base

   ; menu_custom_main - jump table for value storage
   ; 088271c4 08 03      lui     v1,0x895
   ;          03 3c
   ; 088271c8 a4 63      addiu   v1,v1,-0x5b98
   ;          63 24
   ; 088271cc 80 10      v0,a0,0x2
   ;          04 00
   .org 0x088271c4
        lui v1, hi(menu_custom_main_switch-reloc_base)
        addiu v1, v1, lo(menu_custom_main_switch-reloc_base)
        sll v0, a0, 0x2

   ; default value for customization flag (enable battle subs)
   .org 0x08bef060
        .db 0x0b ; was 0x03

   ; dsp_menu_custom_main_stub - else branch for labels
   ; 08828b68 e4 1b      jal     draw_menu_str                     undefined draw_menu_st
   ;          23 0e
   ; 08828b6c 01 00      _li     t0,0x1
   ;          08 24
   .org 0x08828b68
        jal dsp_menu_custom_main_stub-reloc_base

; put skit 130 back into the skit queue
.org 0x08bee9f6
    .dh (130) << 7, 0xAA, 0xAA
    .dh 0, 0, 0

; relocate fc_default_dat
.org 0x08beea20
    .word fc_default_dat_new-reloc_base

; set_game_mode - reset skit string counter on game mode change
; 0882c89c 08 00      jr      ra
;         e0 03
; 0882c8a0 c0 ea      _sw     a0,-0x1540(v1)=>game_mode                  = ??
;         64 ac
.org 0x0882c89c
    j set_game_mode_stub

; display subs before battle fade-in during prolog
.org 0x088f3858
	j opening_start
	nop
