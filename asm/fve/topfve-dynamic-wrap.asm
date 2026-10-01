; auto line break, commented out for now
; uncomment and try it out! :D
.orga 0x44FB94 :: nop :: nop :: nop :: nop ; reloc kill
.org 0x0885baf4
	jal Process_Line_Break_Check
	nop
	b 0x0885bb20
	nop

; patch for various sce_func_msg_tbl funcs
; removes 4 from a2
.org 0x0884f790
	li a2, 2	; idk what this does and it scares me
.org 0x0884f670
    li a2, 0    ; idk what this does either but here we go

