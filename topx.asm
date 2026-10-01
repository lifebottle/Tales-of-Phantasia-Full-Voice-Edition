.open "orig/PSP_GAME/USRDIR/top.prx","out/EBOOT.BIN",0x08803FAC
.psp

; .orga 0x494634
; 	.fill 0x92900, 0x0
;
.definelabel msg_next_line, 0x088e2104
.definelabel text_y_pos, 0x09087B46
.definelabel text_x_pos, 0x09087B44
.definelabel text_color, 0x09087b48
.definelabel start_x_pos, 0x09087BDC
.definelabel msg_ptr, 0x09087b70
.definelabel msg_size, 0x09087BCE
.definelabel box_position, 0x09087BE0
.definelabel draw_character, 0x088e0d5c
.definelabel current_char, 0x09087BCC
.definelabel x_char_index, 0x09087B68
.definelabel box_width, 0x09087B64
.definelabel text_draw_status, 0x09087B69

.definelabel ioReadFile, 0x892dae8
.definelabel reloc_base, 0x8804000
.definelabel custom_file_offset, 0x90C2300

.definelabel get_pad_data, 0x88CC34C
.definelabel get_game_mode, 0x88AF154
.definelabel enable_csr_data, 0x88E40E8
.definelabel snd_si_se, 0x88E5994
.definelabel request_battle, 0x88D4030
.definelabel request_change_map, 0x88D3DEC
.definelabel system_fade, 0x88E5C74
.definelabel del_sce_loop, 0x88D27A8
.definelabel add_sce_loop, 0x88D26F8
.definelabel disable_sys_pad, 0x88D54FC
.definelabel enable_sys_pad, 0x88D5508
.definelabel request_play_movie, 0x88D473C
.definelabel request_mini_game, 0x88D4120
.definelabel request_talk, 0x88E8244
.definelabel init_encount_count, 0x88D13C8
.definelabel get_pad_decide, 0x88C88AC
.definelabel get_pad_rep, 0x88CC384
.definelabel set_pad_number, 0x88C8768
.definelabel set_csr_data_base, 0x88E4114
.definelabel start_csr_data, 0x88E3EBC
.definelabel exec_csr_data, 0x88E3410
.definelabel get_csr_data_no, 0x88E4228
.definelabel add_csr_data_prim, 0x88E44D4
.definelabel set_str_cursor, 0x88E0410
.definelabel add_str_prim, 0x88E07B4
.definelabel add_dec_prim, 0x88E0618
.definelabel get_pad_dat_csr, 0x88E4084
.definelabel get_pad_new_csr, 0x88E3FD4
.definelabel add_window_prim, 0x88A8848
.definelabel init_msg_ot, 0x88E32F0
.definelabel debug_menu, 0x8941944
.definelabel get_sys_msg_ptr, 0x88E14CC
.definelabel get_pad_new, 0x88CC368
.definelabel pad_read, 0x88CC1AC
.definelabel init_party_main, 0x88EB95C
.definelabel get_class, 0x88CF508
.definelabel memset, 0x880B668
.definelabel mon_wall_tim_read, 0x88F1E20
.definelabel snd_set_voice, 0x88CB5C8
.definelabel double_buffer_change, 0x088726B0
.definelabel pchr_disp, 0x08889908
.definelabel snd_vsync_callback, 0x88CBB00
.definelabel PutDispEnv, 0x08991960
.definelabel g_sync, 0x0892B760
.definelabel load_knj_vram, 0x088E1700
.definelabel trans_start, 0x0888AF00
.definelabel g_setRenderTarget, 0x0892B9DC
.definelabel g_getRenderTargetFormat, 0x0892B98C
.definelabel g_getRenderTargetAddr, 0x0892B930
.definelabel sceGuTexMode, 0x08993B70
.definelabel sceGuTexImage, 0x08993C44
.definelabel sceGuEnable, 0x089934F0
.definelabel sceGuDisable, 0x08993548
.definelabel sceGuTexFlush, 0x08993CC4
.definelabel sceGuBlendFunc, 0x08993FC8
.definelabel sceGuColor, 0x08993A84
.definelabel sceGuCopyImage, 0x089937C8
.definelabel sceGuSpriteMode, 0x08993750
.definelabel sceGuDrawSprite, 0x0899376C
.definelabel sceKernelDcacheWritebackAll, 0x089951D0
.definelabel sceDisplayGetVcount, 0x08995268
.definelabel sceCtrlPeekBufferPositive, 0x08995290
.definelabel sceKernelExitThread, 0x089951B0
.definelabel sc_decode, 0x088A82FC
.definelabel set_cdread_adr_block, 0x088AD240
.definelabel malloc_heap, 0x088E6134
.definelabel free_heap, 0x088E62E4
.definelabel get_fps_ptr, 0x088AD438
.definelabel func_0892BE00, 0x0892BE00
.definelabel func_0895FBD8, 0x0895FBD8
.definelabel func_0896006C, 0x0896006C
.definelabel sceGuDepthFunc, 0x08993E74
.definelabel DrawOTagNoScale, 0x088E69A4
.definelabel g_dlFinish, 0x0892B6C4
.definelabel g_swapBuffers, 0x0892B84C
.definelabel g_dlSwap, 0x0892B748
.definelabel g_dlStart, 0x0892B69C
.definelabel g_waitVblank, 0x0892B790
.definelabel snd_get_voice_status, 0x88CB710
.definelabel snd_set_seq, 0x88C9050
.definelabel VSync, 0x881BF34

.definelabel sce, 0x9089D04
.definelabel party_data, 0x9088ED0
.definelabel intp, 0x9033010
.definelabel system_ot, 0x9087DC0
.definelabel original_system_ot, 0x9087DC4
.definelabel sce_loop_skip, 0x9033020
.definelabel csr_r, 0x9087B40
.definelabel csr_x, 0x9087B44
.definelabel csr_y, 0x9087B46
.definelabel csr_l, 0x9087B49
.definelabel sys_pad_flag, 0x8C28FD0
.definelabel sce_off, 0x9033018
.definelabel last_movie, 0x8E2C7C8
.definelabel init_dat, 0x8C5E43C
.definelabel init_type, 0x8C5E48C
.definelabel MonNum, 0x89BBAC8
.definelabel mon_dat, 0x8C65F84
.definelabel mon, 0x908AEC0
.definelabel custom, 0x9089C8C
.definelabel psFbDisplayW, 0x8C9A220
.definelabel psFbDisplayY, 0x8C9A224
.definelabel psFbDisplayX, 0x8C9A228
.definelabel VRAM_ADDR, 0x4110000
.definelabel ipl_start_MAYBE, 0x88b01cc
.definelabel title_step, 0x9088eae
.definelabel title_fade_mode, 0x9088eb8
.definelabel title_time, 0x9088ea8
.definelabel logo_move_cnt, 0x9088eb2
.definelabel sel_title, 0x9088ea4
.definelabel title_menu_dat, 0x8c5e16c
.definelabel back_shade, 0x9088eb4
.definelabel disable_mcard, 0x88b0ad4
.definelabel set_game_mode, 0x88af160
.definelabel title_fade, 0x88eb0b8
.definelabel snd_stop_seq, 0x88c95a4

; replace start_snd_sys epilog
.org 0x088cbcc4
	j load_custom_file

.org 0x089961c0
custom_file:
.asciiz "julian.dat"

.org 0x089961f0
.func load_custom_file	
	addiu sp, sp, -0x10
	sw ra, 0xc(sp)
	li a0, custom_file
	li a1, custom_file_offset
	jal ioReadFile
	lui a2, 0x10

    ; intro logos
	jal startup_logos_thread
	nop

	lw ra, 0xc(sp)
	jr ra
	addiu sp, sp, 0x10
.endfunc

; main menu nix the ndx

; No L/R
.org 0x088E9580 :: b 0x088E95F4

; No NDX prims
.org 0x088E9F68 :: b 0x088E9FC0
.org 0x088EA028 :: b 0x088EA080
.org 0x088E9FCC :: b 0x088EA018
.org 0x088EA08C :: b 0x088EA0DC

.org 0x088EA758 :: nop
.org 0x088EA788 :: nop


.org 0x088e10a8 
    addiu a0, a0, 0x6   ; replace with char width at some point

; 088e2980 
; slti for number of lines
; then addiu for 0x44 buffer size

.org 0x088E2C7C 
    li v1, 0x54     ; new start x-pos for box text printing
                    ; changed from 0x7c

; opening
.org 0x088e2c58		
	li v1, 0x54     ; new start x-pos for box text printing
                    ; changed from 0x7c

.org 0x088e3340
    li a3, 0x140    ; new box width
                    ; changed from 0xE8

.org 0x088E2CF0
    li a1, 0x50     ; new starting x-pos for box
                    ; changed from 0x7c

.org 0x088e2eb8
    addiu v0, v0, 0x123     ; new x-pos for circle prompt button
                            ; changed from 0xd6

; adjustment for topOriGuScissor
; fixes descenders getting cut off on bottom row...
; removed in favor of a proper fix
;.org 0x0881e14c
;    addiu a3, v0, 0x2		; change from +1 to +2 for an extra y

; this is the true chaotic fix
; make every area the full screen >:D
;.org 0x0881e13c
	;li a0, 0
	;li a1, 0
	;li a2, 479
	;j 0x08993efc	; topOriGuScissor
	;li a3, 271

; battle arte menu width
.org 0x089B0910
	.byte 0x40 + 0x20	; incr width from 40 to 60

; battle item menu height
.org 0x089B096E
	.byte 0x60 + 1	; incr by 1 for bottom line descenders

; main item menu height
.org 0x08A28F7A
	.byte 0x54 + 1	; incr by 1 for bottom line descenders

; adjustment for name menu - 7 characters
; writing name back to ram
.org 0x088c2998
    slti v0, a3, 0x7
.org 0x088c29a8
    li a1, 0x7
; displaying text squares
.org 0x088c2d7c
    slti v0, s1, 0x7
; move last name x
.org 0x088C2CE4
    li a1, 0x8C
; move last name y
.org 0x088C2D1C
    li a2, 0x36
; move entered name starting x to center-sorta
.org 0x088C2D28
    addiu a0, s0, 0x4
; somethign to do with the arrow pointer..
.org 0x088C287C
    slti v0, s1, 0x7
.org 0x08a29622
    .byte 0x7	; change max cursor to 7
.org 0x088C2618
	slti at, a0, 0x6		; allow keyboard to go to 7th char while typing
.org 0x088c29ac
	addiu a0, a0, lo(0x8dfc6ef-reloc_base)	; change hardcoded addr when counting backwards
							; to be 1 higher, fixes the space at end

;.org 0x088e2ca4
    ; may need to change these to add some flex at the top

; auto line break, commented out for now
; uncomment and try it out! :D
; .org 0x088e1e4c
; 	jal Process_Line_Break_Check-0x2200
; 	nop
; 	b 0x88e1e78
; 	nop

; patch for various sce_func_msg_tbl funcs
; removes 4 from a2
; .org 0x088d57dc
; 	li a2, 2	; idk what this does and it scares me
; .org 0x088d56bc
;     li a2, 0    ; idk what this does either but here we go

; Monster Book fixes
.org 0x088f09b0
    li t2, 8
    jal newWriteStrAndNum-reloc_base

.org 0x088f0960
	li a3, 0x15

; move down to 0xe0 where image icon is written to
.org 0x08A3AB9A
	.byte 0xe0		; chg from 0, y pos in image
; change where image is read from
.org 0x088c698c
	li t2, 0xe0		; chg from 0, y pos in image 

.org 0x088873ec
	jal getStringWidth-reloc_base

; Make battle arte menus 2 column
COL_WIDTH equ 0x7A
div_mod_end equ 0x887639c

; div/mod by 2 instead of 3
.org 0x08876354
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

.org 0x08876534
div_mod_ret:

; Only update rows each 2 items
.org 0x0887693C :: nop

; Rollover - LEFT
; .org 0x8876b2c :: nop
; .org 0x8876b4c :: nop
.org 0x08876BD4 :: li v0,1

; Rollover at 9 items - RIGHT
.org 0x08876C6C :: li v0,0x9
.org 0x08876D48 :: li v0,0x8

; Rollover - UP
.org 0x08876A14 :: addiu v0,v0,-2
.org 0x088769DC :: slti v0,v0,2
.org 0x088769E0 :: slti at,v0,2
.org 0x08876A04 :: slti v0,v0,2

; Rollover at 9 items - DONW
.org 0x08876A50 :: slti at,v0,0x8
.org 0x08876A64 :: addiu v0,v0,2

; draw only 2 columns
.org 0x0887672C :: nop
.org 0x088767B8 :: slti v0,s1,0x2

; adjust second colum pos
.org 0x088767B4 :: addiu v1,COL_WIDTH

; update max scroll down amount
.org 0x08875AC8 :: addiu a0,v1,-10
.org 0x08875AD4 :: sra v1,a0,1
.org 0x08875AD8 :: nop :: nop :: nop
.org 0x08875AE4 :: nop :: nop :: nop
.org 0x08875ac0 :: slti at, v1, 10

; display subs before battle fade-in during prolog
.org 0x0888dbd4
	j opening_start
	nop

; main - patch language to system locale
; 088b087c 21 20      li      a0,0
;          00 00
; 088b0880 42 55      jal     sceImposeSetLanguageMode          undefined sceImposeSet
;          26 0e
.org 0x088b087c
    li a0, -1 ; was 0

; FUN_0892ec08 - utility dialog language
; 0892ec10 08 00      sw      s1,local_1008(sp)
;         b1 af
; 0892ec14 21 88      move    s1,a0
;         80 00
.org 0x0892ec10
    jal utility_lang_stub
    nop

; 0892ec44 1e 09      lui     v0,0x91e
;         02 3c
; 0892ec48 30 c2      sw      zero,-0x3dd0(v0)=>DAT_091dc230    = ??
;         40 ac
.org 0x0892ec44
    ; disable the old store
    nop :: nop

; FUN_0892e980 - utility dialog language 2
; 0892e98c 04 00      sw      s1,local_100c(sp)
;         b1 af
; 0892e990 21 88      move    s1,a0
;         80 00
.org 0x0892e98c
    jal utility_lang_stub2
    nop

; 0892e9c4 1e 09      lui     v0,0x91e
;         02 3c
; 0892e9c8 30 c2      sw      zero,-0x3dd0(v0)=>DAT_091dc230    = ??
;         40 ac
.org 0x0892e9c4
    ; disable the old store
    nop :: nop

.org 0x089B8754 :: .word logos_path

.orga 0x4C0DF4 :: nop :: nop ; reloc kill
.org 0x088b0928
	nop

.ifndef disable_qol
; patch Suzu inputs to match ToP PSX
.org 0x089af2c3
    .db 0x4b ; was 0x47

.org 0x089af2c5
    .db 0x46 ; was 0x4b

; Sorcerer ring everywhere

; enable effect if in inventory
.orga 0x4D50BC :: nop :: nop :: nop :: nop ; reloc kill
.org 0x088D0CB4 :: j sorcerer_ring_chk :: nop

; enable effect if equipped
.org 0x088D0D4C :: j sorcerer_ring_chk2 :: lhu t3, 0(t9)

; Add scePowerSetClockFrequency to the import list
.org 0x08995B98
; scePower
.word 0x04B7766E ; scePowerRegisterCallback
.word 0x737486F2 ; scePowerSetClockFrequency
; sceImpose
.word 0x36AA6E91 ; sceImposeSetLanguageMode

; Place the new stubs
.org 0x08996100
scePowerRegisterCallback:
jr ra
nop
scePowerSetClockFrequency:
jr ra
nop

; Update scePower data
.org 0x089956B2 :: .dh 0x2 ; list 2 imports
.org 0x089956B8 :: .word scePowerRegisterCallback-reloc_base ; new stub base

; Make the original scePowerRegisterCallback jump to the new one
.org 0x08995500 :: j scePowerRegisterCallback

; Update sceImpose nid location
.org 0x089956C8 
.word 0x08995BA0-reloc_base

; exec_sce - handle bottles
; 088d07f4 a7 43      jal     exec_sce_encount                  undefined exec_sce_enc
;         23 0e
; 088d07f8 00 00      _nop
;         00 00
.org 0x088d07f4
    jal holy_bottle_stub-reloc_base

; Patch Suzu's Kuroyuri to be non-elemental
; .org 0x089d01df
;     .db 0 ; was 0x7

; Patch Suzu's Ninja Sword to be non-elemental
.org 0x089d01ff
    .db 0 ; was 0x7

; exe_grade_end - epilog
; 088bc0dc 0c 00      lw      ra,local_dc4(sp)
;         bf 8f
; 088bc0e0 08 00      lw      s0,local_dc8(sp)
;         b0 8f
; 088bc0e4 08 00      jr      ra
;         e0 03
; 088bc0e8 d0 0d      _addiu  sp,sp,0xdd0
;         bd 27

; carry over Scout Orb and Curio's Mirror on NG+
.org 0x088bc0dc
    j exe_grade_end_stub
    nop

.endif

; load_game - epilog
; 088ae6a8 08 00      jr      ra
;         e0 03
; 088ae6ac 10 00      _addiu  sp,sp,0x10
;         bd 27
.org 0x088ae6a8
    j npc_name_fix

; add_party_member - epilog
; 088cec54 08 00      jr      ra
;         e0 03
; 088cec58 20 00      _addiu  sp,sp,0x20
;         bd 27
.org 0x088cec54
    j npc_name_fix

.include "topx-reloc-msgbuf.asm", "UTF8"

.include "topx-vwf.asm", "UTF8"

.include "topx-skits.asm", "UTF8"

.include "topx-dbg.asm", "UTF8"



.org 0x08c32074
    .area 0x342c
    .incbin "bamco.tga"
    .endarea

; patch source for gald/play time save description
; 088b2dfc a3 08      lui     a1,0x8a3
;         05 3c
; 088b2e14 d8 89      _addiu  a1=>s_Gald:%d_PlayTime:%d:%02d_0  = "Gald:%d  PlayTime:%
;         a5 24
.org 0x088b2dfc
    lui a1, hi(playtime_str-reloc_base)

.org 0x088b2e14
    addiu a1, a1, lo(playtime_str-reloc_base)

; save cancel
; 088b2f50 a3 08      lui     a1,0x8a3
;           05 3c
; 088b2f5c 30 8a      _addiu  a1=>s_HAN_HIRAGANA_KATAKANA#_08a  = "セーブを中止しますか？"
;          a5 24
.org 0x088b2f50
    lui a1, hi(save_cancel-reloc_base)

.org 0x088b2f5c
    addiu a1, lo(save_cancel-reloc_base)

; load cancel
; 088b31f0 a3 08      lui     a1,0x8a3
;         05 3c
; 088b31fc 48 8a      _addiu  a1=>s_HAN_HIRAGANA_KATAKANA#_08a  = "ロードを中止しますか？"
;         a5 24
.org 0x088b31f0
    lui a1, hi(load_cancel-reloc_base)

.org 0x088b31fc
    addiu a1, lo(load_cancel-reloc_base)

; erase cancel
; 088b3294 a3 08      lui     a1,0x8a3
;         05 3c
; 088b32a0 60 8a      _addiu  a1=>s_HAN_HIRAGANA#_08a28a60,a1,  = "削除を中止しますか？"
;         a5 24
.org 0x088b3294
    lui a1, hi(erase_cancel-reloc_base)

.org 0x088b32a0
    addiu a1, lo(erase_cancel-reloc_base)

; memory stick not inserted
; 0892f1c4 c8 08      lui     a1,0x8c8
;         05 3c
; 0892f1c8 01 00      li      a0,0x1
;         04 24
; 0892f1cc 60 ba      jal     FUN_0892e980                      undefined FUN_0892e980()
;         24 0e
; 0892f1d0 04 0d      _addiu  a1=>s_HAN_HIRAGANA_KATAKANA#384K  = "メモリースティック",81h
;         a5 24
.org 0x0892f1c4
    lui a1, hi(no_ms_inserted-reloc_base)

.org 0x0892f1d0
    addiu a1, lo(no_ms_inserted-reloc_base)

; not enough space on memory stick
; 0892f370 c8 08      lui     a1,0x8c8
;         05 3c
; 0892f374 01 00      li      a0,0x1
;         04 24
; 0892f378 60 ba      jal     FUN_0892e980                      undefined FUN_0892e980()
;         24 0e
; 0892f37c 9c 0d      _addiu  a1=>s_HAN_HIRAGANA_KATAKANA#384K  = "記録メディアの空き容量が
;         a5 24
.org 0x0892f370
    lui a1, hi(ms_space_error-reloc_base)

.org 0x0892f37c
    addiu a1, lo(ms_space_error-reloc_base)

; "run game anyway?" message
; 0892f394 c8 08      lui     a1,0x8c8
;         05 3c
; 0892f398 10 01      li      a0,0x110
;         04 24
; 0892f39c 60 ba      jal     FUN_0892e980                      undefined FUN_0892e980()
;         24 0e
; 0892f3a0 34 0e      _addiu  a1=>s_HAN_HIRAGANA_KATAKANA#_08c  = "このままゲームを開始しま
;         a5 24
.org 0x0892f394
    lui a1, hi(continue_anyway-reloc_base)

.org 0x0892f3a0
    addiu a1, lo(continue_anyway-reloc_base)

; language for system messages
; 0892e19c 1e 09      lui     v0,0x91e
;         02 3c
; 0892e1a0 1c bc      sw      zero,-0x43e4(v0)=>DAT_091dbc1c    = ??
;         40 ac
.org 0x0892e19c
    jal utility_lang_stub3
    nop

; reloc kill
.orga 0x4FBDA4
    nop :: nop :: nop :: nop

; put skit 130 back into the skit queue
.org 0x8c5dd92
    .dh (130) << 7, 0xAA, 0xAA
    .dh 0, 0, 0

; relocate fc_default_dat
.org 0x8c5ddbc
    .word fc_default_dat_new-reloc_base

; update Ishrantu's monster entry to "weak to earth
.org 0x08c6624a
    .dh 0xa

.close

.create "out/julian.dat",0x90C2300
	.importlib "julian-top.a"
	.align 4

    new_msg_buf:
    .fill line_len*4, 0x00

    .include "topx-new-code.asm", "UTF8"
.close
