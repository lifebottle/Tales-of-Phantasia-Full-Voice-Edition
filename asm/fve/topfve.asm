.open "EBOOT.BIN",OUT_DIR+"/EBOOT.BIN",0x08803FA0
.psp

; .orga 0x42457C
; 	.fill 0x77330, 0x0
;
.definelabel msg_next_line, 0x088e2104
.definelabel text_y_pos, 0x09047eb4 ; csr_y
.definelabel text_x_pos, 0x09047eb6 ; csr_x
.definelabel text_color, 0x09047eb2 ; csr_c
.definelabel start_x_pos, 0x09047e1c ; msg_win_x
.definelabel msg_ptr, 0x09047e88
.definelabel msg_size, 0x9047e2a
.definelabel box_position, 0x09047e18 ; msg_win_cv
.definelabel draw_character, 0x0885aa00 ; add_knj_prim
.definelabel current_char, 0x09047e2c ; msg_code
.definelabel x_char_index, 0x09047e91 ; msg_chr
.definelabel box_width, 0x09047ea4 ; msg_win.width
.definelabel text_draw_status, 0x09047e90 ; msg_stat
.definelabel ioReadFile, 0x0888c8ec
.definelabel reloc_base, 0x08804000

.definelabel custom_file_offset, 0x09d46634

.definelabel get_pad_data, 0x0890953c
.definelabel get_game_mode, 0x0882c874
.definelabel enable_csr_data, 0x0885dda0
.definelabel snd_si_se, 0x0885f698
.definelabel request_battle, 0x0884e108
.definelabel request_change_map, 0x0884dec4
.definelabel system_fade, 0x0885f8a4
.definelabel del_sce_loop, 0x0884c87c
.definelabel add_sce_loop, 0x0884c7cc
.definelabel disable_sys_pad, 0x0884f5f8
.definelabel enable_sys_pad, 0x0884f604
.definelabel request_play_movie, 0x0884e81c
.definelabel request_mini_game, 0x0884e1f8
.definelabel request_talk, 0x0886215c
.definelabel init_encount_count, 0x0884b494
.definelabel get_pad_decide, 0x08843680
.definelabel get_pad_rep, 0x08909590
.definelabel set_pad_number, 0x0884353c
.definelabel set_csr_data_base, 0x0885ddcc
.definelabel start_csr_data, 0x0885db74
.definelabel exec_csr_data, 0x0885d0c8
.definelabel get_csr_data_no, 0x0885dee0
.definelabel add_csr_data_prim, 0x0885e18c
.definelabel set_str_cursor, 0x0885a0b4
.definelabel move_str_cursor, 0x0885a0d8
.definelabel add_str_prim, 0x0885a458
.definelabel add_dec_prim, 0x0885a2bc
.definelabel get_pad_dat_csr, 0x0885dd3c
.definelabel get_pad_new_csr, 0x0885dc8c
.definelabel add_window_prim, 0x08865aec
.definelabel init_msg_ot, 0x0885cfa8
.definelabel debug_menu, 0x08867030
.definelabel get_sys_msg_ptr, 0x0885b170
.definelabel get_pad_new, 0x08909574
.definelabel pad_read, 0x089093b4
.definelabel init_party_main, 0x088652f8
.definelabel get_class, 0x08849d90
.definelabel memset, 0x0880af00
.definelabel mon_wall_tim_read, 0x0890cd64
.definelabel snd_set_voice, 0x08846264
.definelabel double_buffer_change, 0x088ddc30
.definelabel pchr_disp, 0x088ef674
.definelabel snd_vsync_callback, 0x08846788
.definelabel PutDispEnv, 0x0887f660
.definelabel g_sync, 0x00888abe8
.definelabel load_knj_vram, 0x0885b3a4
.definelabel trans_start, 0x088f0ce8
.definelabel g_setRenderTarget, 0x0888ae64
.definelabel g_getRenderTargetFormat, 0x0888ae14
.definelabel g_getRenderTargetAddr, 0x0888adb0
.definelabel sceGuTexMode, 0x0887bf4c
.definelabel sceGuTexImage, 0x0887c028
.definelabel sceGuEnable, 0x08879d3c
.definelabel sceGuDisable, 0x0887a0fc
.definelabel sceGuTexFlush, 0x0887c128
.definelabel sceGuBlendFunc, 0x0887c4ec
.definelabel sceGuColor, 0x0887be14
.definelabel sceGuCopyImage, 0x0887b13c
.definelabel sceGuSpriteMode, 0x0887aeec
.definelabel sceGuDrawSprite, 0x0887af08
.definelabel sceKernelDcacheWritebackAll, 0x08945d70
.definelabel sceDisplayGetVcount, 0x08945e70
.definelabel sceCtrlPeekBufferPositive, 0x08945e50
.definelabel sceKernelExitThread, 0x08945d48
.definelabel sc_decode, 0x0890a570
.definelabel set_cdread_adr_block, 0x0882ab34
.definelabel malloc_heap, 0x0885fd48
.definelabel free_heap, 0x0885fecc
.definelabel get_fps_ptr, 0x0882aca8
.definelabel func_0892BE00, 0x0888b2ac
.definelabel func_0895FBD8, 0x00000000 ; doesn't exist
.definelabel func_0896006C, 0x00000000 ; doesn't exist
.definelabel sceGuDepthFunc, 0x0887c348
.definelabel DrawOTagNoScale, 0x088608b8
.definelabel g_dlFinish, 0x0888ab70
.definelabel g_swapBuffers, 0x0888accc
.definelabel g_dlSwap, 0x0888abd0
.definelabel g_dlStart, 0x0888ab48
.definelabel g_waitVblank, 0x0888ac18
.definelabel snd_get_voice_status, 0x0884638c
.definelabel snd_set_seq, 0x08843d74
.definelabel VSync, 0x0887f27c
.definelabel sceKernelPrintf, 0x08945c70
.definelabel sprintf, 0x0880d298
.definelabel sceIoOpen, 0x08945bd8
.definelabel sceIoClose, 0x08945ba8
.definelabel sceIoIoctlAsync, 0x08945bc8
.definelabel sceIoWaitAsync, 0x08945bc0
.definelabel pad_action, 0x0887339c

.definelabel sce, 0x0905d238
.definelabel party_data, 0x0905d928
.definelabel cur_map, 0x0905e500
.definelabel intp, 0x090030b4
.definelabel original_system_ot, 0x0905c798
.definelabel system_ot, 0x0905c79c
.definelabel sce_loop_skip, 0x090030a4
.definelabel csr_r, 0x09047eba
.definelabel csr_x, 0x09047eb6
.definelabel csr_y, 0x09047eb4
.definelabel csr_l, 0x09047eb1
.definelabel sys_pad_flag, 0x08bba014
.definelabel sce_off, 0x090030ac
.definelabel last_movie, 0x08e0af14
.definelabel init_dat, 0x08bef048
.definelabel init_type, 0x08bef098
.definelabel MonNum, 0x08962360
.definelabel mon_dat, 0x08c097dc
.definelabel mon, 0x09ce8eb8
.definelabel custom, 0x0905d8ec
.definelabel psFbDisplayW, 0x090b1034
.definelabel psFbDisplayY, 0x090b1038
.definelabel psFbDisplayX, 0x090b103c
.definelabel VRAM_ADDR, 0x4110000
.definelabel ipl_start_MAYBE, 0x0882da70
.definelabel title_step, 0x0905d212
.definelabel title_fade_mode, 0x0905d208
.definelabel title_time, 0x0905d218
.definelabel logo_move_cnt, 0x0905d20e
.definelabel sel_title, 0x0905d21c
.definelabel back_shade, 0x0905d20c
.definelabel disable_mcard, 0x0882e2a0
.definelabel set_game_mode, 0x0882c880
.definelabel title_fade, 0x08864ce4
.definelabel snd_stop_seq, 0x088442bc
.definelabel active, 0x09d96894
.definelabel db_env, 0x09d947a4
.definelabel curr_ots, 0x09dcdf18
.definelabel draw_string, 0x08867524
.definelabel get_sce_switch, 0x0884dcb4
.definelabel check_object_sub, 0x08862d98
.definelabel check_stage_sub, 0x08862cd0

; replace start_snd_sys epilog
.org 0x088468f0
	j load_custom_file

.org 0x08946a30
custom_file:
.asciiz "julian.dat"

.align 4
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

; Not needed in FVE
  ;; main menu nix the ndx

  ;; No L/R
  ;.org 0x088E9580 :: b 0x088E95F4

  ;; No NDX prims
  ;.org 0x088E9F68 :: b 0x088E9FC0
  ;.org 0x088EA028 :: b 0x088EA080
  ;.org 0x088E9FCC :: b 0x088EA018
  ;.org 0x088EA08C :: b 0x088EA0DC

  ;.org 0x088EA758 :: nop
  ;.org 0x088EA788 :: nop

; 0885c634 
; slti for number of lines
; then addiu for 0x44 buffer size

; .include "asm/fve/topfve-dynamic-wrap.asm", "UTF8"

.ifndef disable_qol
    .include "asm/fve/topfve-qol.asm", "UTF8"
.endif

.include "asm/fve/topfve-reloc-msgbuf.asm", "UTF8"
.include "asm/fve/topfve-reloc-mapbuf.asm", "UTF8"
.include "asm/fve/topfve-vwf.asm", "UTF8"
.include "asm/fve/topfve-new-code-eboot.asm", "UTF8"
.include "asm/fve/topfve-sys-lang.asm", "UTF8"
.include "asm/fve/topfve-monster-book.asm", "UTF8"
.include "asm/fve/topfve-menus.asm", "UTF8"
.include "asm/fve/topfve-battle-menus.asm", "UTF8"
.include "asm/fve/topfve-naming-screen.asm", "UTF8"
.include "asm/fve/topfve-misc.asm", "UTF8"
.include "asm/fve/topfve-skits.asm", "UTF8"
.include "asm/fve/topfve-dbg.asm", "UTF8"

  ; .org 0x8925704
  ; j dbg_overlay
  ; nop
  ; 
  ; .org 0x894c98c
  ; jal dbg_overlay_3d-reloc_base

  ; needed for psp debugger
  ; 0882e1ac 0f 2e      jal     FUN_0888b83c                      undefined FUN_0888b83c()
  ;          22 0e
  ; 0882e1b0 fc 79      _addiu  a0=>s_disc0:/PSP_GAME/USRDIR/_08  = "disc0:/PSP_GAME/USR
  ;          84 24
  ; .org 0x0882e1ac
  ;   nop

.close

.create OUT_DIR+"/julian.dat",0x09d46634
	.importlib "julian-top.a"
	.align 4

    new_msg_buf:
    .fill line_len*4, 0x00

    .include "asm/fve/topfve-new-code.asm", "UTF8"
.close
