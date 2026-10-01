; is this even needed in FVE? (old addresses)
 ; ; patch Suzu inputs to match ToP PSX
 ; .org 0x089af2c3
 ;     .db 0x4b ; was 0x47
 ; 
 ; .org 0x089af2c5
 ;     .db 0x46 ; was 0x4b
 ; 
; Sorcerer ring everywhere

; enable effect if in inventory
.orga 0x44336C :: nop :: nop :: nop :: nop ; reloc kill
.org 0x0884ad74 :: j sorcerer_ring_chk :: nop

; enable effect if equipped
.org 0x0884ae0c :: j sorcerer_ring_chk2 :: lhu t3, 0(t9)

; Not needed for FVE (old addresses)
 ; ; Add scePowerSetClockFrequency to the import list
 ; .org 0x08995B98
 ; ; scePower
 ; .word 0x04B7766E ; scePowerRegisterCallback
 ; .word 0x737486F2 ; scePowerSetClockFrequency
 ; ; sceImpose
 ; .word 0x36AA6E91 ; sceImposeSetLanguageMode
 ;
 ; ; Place the new stubs
 ; .org 0x08996100
 ; scePowerRegisterCallback:
 ; jr ra
 ; nop
 ; scePowerSetClockFrequency:
 ; jr ra
 ; nop
 ; 
 ; ; Update scePower data
 ; .org 0x089956B2 :: .dh 0x2 ; list 2 imports
 ; .org 0x089956B8 :: .word scePowerRegisterCallback-reloc_base ; new stub base
 ; 
 ; ; Make the original scePowerRegisterCallback jump to the new one
 ; .org 0x08995500 :: j scePowerRegisterCallback
 ; 
 ; ; Update sceImpose nid location
 ; .org 0x089956C8 
 ; .word 0x08995BA0-reloc_base

; exec_sce - handle bottles
; 0884a8a8 d9 2b      jal     exec_sce_encount                  undefined exec_sce_enc
;         21 0e
; 0884a8ac 00 00      _nop
;         00 00
.org 0x0884a8a8
    jal holy_bottle_stub-reloc_base

; Patch Suzu's Kuroyuri to be non-elemental
.org 0x0896fc9b
    .db 0 ; was 0x7

; Patch Suzu's Ninja Sword to be non-elemental
.org 0x0896fcbb
    .db 0 ; was 0x7

; exe_grade_end - epilog
; 08837b84 0c 00      lw      ra,local_d94(sp)
;         bf 8f
; 08837b88 08 00      lw      s0,local_d98(sp)
;         b0 8f
; 08837b8c 08 00      jr      ra
;         e0 03
; 08837b90 a0 0d      _addiu  sp,sp,0xda0
;         bd 27

; carry over Scout Orb and Curio's Mirror on NG+
.org 0x08837b84
    j exe_grade_end_stub
    nop

; add Technical Ring to initial equipment
.org 0x8beee38
    .dh 0x16b
