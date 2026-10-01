   ; arte popup width
   ; 088ed2e0 43 20      _sra    a0,v1,0x1
   ;          03 00
   .org 0x088ed2e0
        ;sra a0, v1, 0x2
        ; commented out 
        ; no longer needed with proper width code

   ; FUN_088643d8
   ; title screen - Kosuke Fujishima - width
   ; 088643f8 68 00      li      a1,0x68
   ;          05 24
   .org 0x088643f8
        li a1, 0x90 ; was 0x68

   ; 088641ac 68 00      li      a1,0x68
   ;          05 24
   .org 0x088641ac
        li a1, 0x90 ; was 0x68

   ; title screen - copyright - height
   ; 0886442c 10 00      li      a2,0x10
   ;          06 24
   .org 0x0886442c
        li a2, 0x28 ; was 0x10

   ; 088641ec 10 00      li      a2,0x10
   ;          06 24
   .org 0x088641ec
        li a2, 0x28 ; was 0x10

   ; 088641fc 21 38      move    a3,a2
   ;          c0 00
   .org 0x088641fc
        li a3, 0x10

   ; expand save description name buffer to 7 spaces
   .org 0x089bcbd4
        .db 0x81, 0x40
        .db 0x81, 0x40
        .db 0x81, 0x40
        .db 0x81, 0x40
        .db 0x81, 0x40
        .db 0x81, 0x40
        .db 0x81, 0x40
        .db 0x00

   ; game_main
   ; 0882b490 02 00      li      v1,0x2
   ;          03 24
   ; game mode - start by playing opening FMV instead of immediately displaying the title screen
   .org 0x0882b490
        li v1, 0x3 ; was 0x2

   ; game_mode_end_movie - video play
   ; 0882b9cc 33 66      jal     FUN_088598cc                      undefined FUN_088598cc()
   ;          21 0e
   ; 0882b9d0 00 00      _nop
   ;          00 00
   .org 0x0882b9cc
        jal end_movie_stub-reloc_base

   ; FUN_0888e030 - audio decode
   ; 0888e170 c9 3e      jal     FUN_0888fb24                      undefined FUN_0888fb24()
   ;          22 0e
   .org 0x0888e170
        jal end_movie_audio_stub-reloc_base

; ipl_start
; 0882da94 3c 17      jal     sceKernelCreateThread             SceUID sceKernelCreate
;         25 0e
; disable old logos
.org 0x0882da94
    li v0, -1

; logos
.org 0x0895efe0 :: .word logos_path

; Not needed in FVE
 ; .orga 0x431854 :: nop :: nop ; reloc kill
 ; .org 0x0882e1b4
 ; 	nop

; produced by logo in ending credits
.org 0x08bc2d48
    .area 0x342c
    .incbin OUT_DIR+"/bamco.tga"
    .endarea
