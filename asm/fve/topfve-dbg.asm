; Restored debug menu stuff

; Add "Debug" option to title screen:
; Make Debug show when sce_debug_mode (0x0905d558) is enabled
.org 0x08863ca0 :: lui      s1, hi(title_menu_dat-reloc_base)
.org 0x08863cb0 :: addiu    s1,s1,lo(title_menu_dat-reloc_base)
.org 0x08863124 :: lui      v0, hi(title_menu_dat+14-reloc_base)
.org 0x0886312c :: sh       v1, lo(title_menu_dat+14-reloc_base)(v0)

.org 0x08863d7c
    jal ttl_check_debug_enabled
    nop

.org 0x088631f4
    j sel_title_main
    nop

; Does not apply to FVE, needs the title item struct moved to the C reimpl 
  ; ; Go to debug gamemode
  ; .org 0x088E9698 :: li a0, 10
  ; .org 0x08C5E18C :: .dh 0x4, 0x80, 0x170

; Hook/add the stubbed debug functions
.org 0x0882f644
    j _menu_top_main
    nop

.orga 0x45181C :: nop :: nop ; reloc kill
.orga 0x451824 :: nop :: nop ; reloc kill
.org 0x0885f78c
    j __init_sys_ot
    nop

.org 0x0884f354
    j call_scdeb_win
    nop

.org 0x08829318
    j check_scdeb_window
    nop

.org 0x0884ece4
    j _init_scdeb_window
    nop

.org 0x0884f614
    j check_sce_window
    nop

.orga 0x451C3C :: nop :: nop ; reloc kill
.orga 0x451C44 :: nop :: nop ; reloc kill
.org 0x0885fcd4
	nop
	nop

.orga 0x45A1E4 :: nop :: nop ; reloc kill
.org 0x088733fc
	j _check_dbg
	nop

.org 0x0885f784
    j debug_pause
    nop

; .orga 0x47F7F4 :: nop :: nop ; reloc kill
.org 0x0890ae9c
    j _mon_init-reloc_base
    ; keep this instruction the same

.orga 0x47FCCC :: nop :: nop ; reloc kill
.org 0x0890b570
    j _mon_vsync_loop
    ; keep this instruction the same

.org 0x088652a0
    j init_party
    nop
