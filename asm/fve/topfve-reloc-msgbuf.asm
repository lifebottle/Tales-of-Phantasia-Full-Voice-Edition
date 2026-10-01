line_len equ 0x220
msg_buf equ new_msg_buf-reloc_base
msg_buf_2 equ msg_buf+line_len
msg_buf_3 equ msg_buf+(line_len*2)
msg_buf_4 equ msg_buf+(line_len*3)

.macro init_zero,dest,reg
    lui reg, hi(dest)
    sh zero, lo(dest)(reg)
.endmacro

.macro init_buf,reg
    init_zero msg_buf, reg
    init_zero msg_buf_2, reg
    init_zero msg_buf_3, reg
    init_zero msg_buf_4, reg
.endmacro

; NOTE: change this if you added new glyphs to the font
zero_width_char equ 0x6f

; fixed dialogue buffers - multiplication by 0x44 (changed to 0x88)
; make_msg_buf

.org 0x0885baa0
   ; 0885baa0 80 30      sll     a2,a2,0x2
   sll a2, a2, 0x5 ; was 0x2

.org 0x0885bb74
   ; 0885bb74 80 30      sll     a2,a2,0x2
   sll a2, a2, 0x5 ; was 0x2

.org 0x0885bc6c
   ; 0885bc6c 80 28      sll     a1,a1,0x2
   sll a1, a1, 0x5 ; was 0x2

.org 0x0885bcd8
   ; 0885bcd8 80 18      sll     v1,v1,0x2
   sll v1, v1, 0x5 ; was 0x2

; make_msg_buf - relocate buffer
   ; 0885ba8c 04 09      lui     a1,0x904
   ;          05 3c
   ; 0885ba90 08 7d      addiu   a1,a1,0x7d08
   ;          a5 24
   .org 0x0885ba8c
        la a1, msg_buf

   ; 0885bc58 04 09      lui     a0,0x904
   ;          04 3c
   ; 0885bc5C 08 7d      addiu   a0,a0,0x7d08
   ;          84 24
   .org 0x0885bc58
        la a0, msg_buf

   ; 0885bb60 04 09      lui     a1,0x904
   ;          05 3c
   ; 0885bb64 08 7d      addiu   a1,a1,0x7d08
   ;          a5 24
   .org 0x0885bb60
        la a1, msg_buf

   ; 0885bcc0 04 09      lui     a1,0x904
   ;          05 3c
   ; 0885bcc4 08 7d      addiu   a1,a1,0x7d08
   ;          a5 24
   .org 0x0885bcc0
        la a1, msg_buf


; fixed dialogue buffers - add 0x44 (changed to 0x88)

; FUN_0885c4f0
.org 0x0885c63c
   ; 088e2988 44 00      _addiu  s0,s0,0x44
   ;          10 26
    addiu s0, s0, line_len ; was 0x44

; FUN_0885c4f0 - relocate buffer

   ; 0885c5cc 04 09      lui     s0,0x904
   ;          10 3c
   .org 0x0885c5cc
        lui s0, hi(msg_buf)

   ; 0885c5e0 08 7d      addiu   s0,s0,0x7d08
   ;          10 26
   .org 0x0885c5e0
        addiu s0, s0, lo(msg_buf)

; clear_msg_buf
   ; 0885b938 04 09      lui     v1,0x904
   ;          03 3c
   ; 0885b93c 08 7d      sh      zero,offset msg_buf(v1)           = ??
   ;          60 a4
   ; 0885b940 04 09      lui     v1,0x904
   ;          03 3c
   ; 0885b944 4c 7d      sh      zero,offset msg_buf[68](v1)
   ;          60 a4
   ; 0885b948 04 09      lui     v1,0x904
   ;          03 3c
   ; 0885b94c 90 7d      sh      zero,offset msg_buf[136](v1)
   ;          60 a4
   ; 0885b950 04 09      lui     v1,0x904
   ;          03 3c
   ; 0885b954 d4 7d      sh      zero,offset msg_buf[204](v1)
   ;          60 a4
.org 0x0885b938
    init_buf v1

; init_msg_win_sys
.org 0x0885d038
   ; 0885d038 04 09      lui     v0,0x904
   ;          02 3c
   ; 0885d03c 08 7d      sh      zero,offset msg_buf(v0)           = ??
   ;          40 a4
   ; 0885d040 04 09      lui     v0,0x904
   ;          02 3c
   ; 0885d044 4c 7d      sh      zero,offset msg_buf[68](v0)
   ;          40 a4
   ; 0885d048 04 09      lui     v0,0x904
   ;          02 3c
   ; 0885d04c 90 7d      sh      zero,offset msg_buf[136](v0)
   ;          40 a4
   ; 0885d050 04 09      lui     v0,0x904
   ;          02 3c
   ; 0885d054 d4 7d      sh      zero,offset msg_buf[204](v0)
   ;          40 a4
    init_buf v0

; msg_window_frame
.org 0x0885ca64
   ; 0885ca64 04 09      lui     v0,0x904
   ;          02 3c
   ; 0885ca68 08 7d      sh      zero,offset msg_buf(v0)           = ??
   ;          40 a4
   ; 0885ca6c 04 09      lui     v0,0x904
   ;          02 3c
   ; 0885ca70 4c 7d      sh      zero,offset msg_buf[68](v0)
   ;          40 a4
   ; 0885ca74 04 09      lui     v0,0x904
   ;          02 3c
   ; 0885ca78 90 7d      sh      zero,offset msg_buf[136](v0)
   ;          40 a4
   ; 0885ca7c 04 09      lui     v0,0x904
   ;          02 3c
   ; 0885ca80 d4 7d      sh      zero,offset msg_buf[204](v0)
   ;          40 a4
    init_buf v0

   ; 0885cac4 04 09      lui     v0,0x908
   ;          02 3c
   ; 0885cac8 08 7d      sh      zero,offset msg_buf(v0)           = ??
   ;          40 a4
   ; 0885cacc 04 09      lui     v0,0x908
   ;          02 3c
   ; 0885cad0 4c 7d      sh      zero,offset msg_buf[68](v0)
   ;          40 a4
   ; 0885cad4 04 09      lui     v0,0x908
   ;          02 3c
   ; 0885cad8 90 7d      sh      zero,offset msg_buf[136](v0)
   ;          40 a4
   ; 0885cadc 04 09      lui     v0,0x908
   ;          02 3c
   ; 0885cae0 d4 7d      sh      zero,offset msg_buf[204](v0)
   ;          40 a4
   .org 0x0885cac4
    init_buf v0

   ; 0885cbf4 04 09      lui     v0,0x904
   ;          02 3c
   ; 0885cbf8 08 7d      lhu     v0,offset msg_buf(v0)             = ??
   ;          42 94
   .org 0x0885cbf4
        lui v0, hi(msg_buf)
        lhu v0, lo(msg_buf)(v0)

   ; 0885cce8 04 09      lui     a0,0x904
   ;          04 3c
   ; 0885ccec 04 09      lui     a1,0x904
   ;          05 3c
   .org 0x0885cce8
        lui a0, hi(msg_buf)
        lui a1, hi(msg_buf)

   ; 0885ccf0 04 09      lui     v0,0x904
   ;          02 3c
   ; 0885ccf4 ff ff      addiu   v1,v1,-0x1
   ;          63 24
   ; 0885ccf8 08 7d      addiu   a0=>msg_buf,a0,0x7d08             = ??
   ;          84 24
   .org 0x885ccf8
        addiu a0, a0, lo(msg_buf)

   ; 0885ccfc 22 7e      sh      v1,offset msg_line(v0)            = ??
   ;          43 a4
   ; 0885cd00 4c 7d      addiu   a1=>msg_buf[68],a1,0x7d4c
   ;          a5 24
   .org 0x0885cd00
        addiu a1, a1, lo(msg_buf_2)

   ; 0885cd04 af 2a      jal     memcpy                            void * memcpy(void * _
   ;          20 0e
   ; 0885cd08 cc 00      _li     a2,0xcc
   ;          06 24
   .org 0x0885cd08
        li a2, (line_len*3) ; was 0xcc

   ; 0885cd0c 04 09      lui     v0,0x908
   ;          02 3c
   ; 0885cd10 d4 7d      sh      zero,offset msg_buf[204](v0)
   ;          40 a4
   .org 0x0885cd0c
        lui v0, hi(msg_buf_4)
        sh zero, lo(msg_buf_4)(v0)

   ; disable char limit in dialogue boxes
   ; 0885baf8 91 7e      lbu     v1,offset msg_chr(v1)             = ??
   ;          63 90
   ; 0885bafc 10 00      slti    v1,v1,0x10
   ;          63 28
   ; 0885bb00 07 00      bne     v1,zero,LAB_0885bb20
   ;          60 14
   ; 0885bb04 00 00      _nop
   ;          00 00
   ; 0885bb08 ff ff      andi    v1,v0,0xffff
   ;          43 30
   ; 0885bb0c 10 00      slti    v1,v1,0x10
   ;          63 28
   .org 0x0885bafc
        b 0x0885bb20
        nop

    .org 0x0885bb0c
        b 0x0885bb20
        nop

   ; 0885bbb8 0f 00      slti    v1,v1,0xf
   ;          63 28
   ; 0885bbbc 3e 00      bne     v1,zero,LAB_0885bcb8
   ;          60 14
   .org 0x0885bbb8
        b 0x0885bcb8
        nop

   ; set_msg_addr
   ; 0885b6e8 00 39      sll     a3,t1,0x4
   ;          09 00
   ; .org 0x0885b6e8
   ;      sll a3, t1, 0x6 ; was 0x4

   ; 0885b6f8 80 10      sll     v0,v0,0x2
   ;          02 00
   .org 0x0885b6f8
        sll v0, v0, 0x5 ; was 0x2

   ; msg_next_page
   ; 0885be58 00 29      sll     a1,a3,0x4
   ;          07 00
   ; .org 0x0885be58
   ;      sll a1, a3, 0x6 ; was 0x4

   ; 0885be68 80 18      sll     v1,v1,0x2
   ;          03 00
   .org 0x0885be68
        sll v1, v1, 0x5 ; was 0x2

   ; msg_buf - relocate buffer
   ; 0885be48 04 09      lui     a0,0x904
   ;          04 3c
   ; 0885be4c 08 7d      addiu   a0,a0,0x7d08
   ;          84 24
   .org 0x0885be48
        la a0, msg_buf

   ; msg_next_line
   ; 0885bdd0 80 28      sll     a1,a1,0x2
   ;          05 00
   .org 0x0885bdd0
        sll a1, a1, 0x5 ; was 0x2

   ; msg_next_line, relocate msg_buf
   ; 0885bdb8 04 09      lui     a0,0x904
   ;          04 3c
   ; 0885bdbc 08 7d      addiu   a0,a0,0x7d08
   ;          84 24
   .org 0x0885bdb8
        la a0, msg_buf

   ; set_msg_addr - opening quote
   ; 0885baa8 06 00      bne     a3,a0,LAB_0885bac4
   ;          e4 14
   ; replace msg_head_char with space
   .org 0x0885baa8
        b 0x0885bac4

   ; set_msg_addr - auto-indent space
   ; 0885bac4 10 00      li      a0,0x10
   ;          04 24
   .org 0x0885bac4
        li a0, zero_width_char ; changed to zero-width character

   ; set_msg_addr - relocate msg_buf
   ; 0885b6d8 04 09      lui     v1,0x904
   ;          03 3c
   ; 0885b6dc 08 7d      addiu   v1,v1,0x7d08
   ;          63 24
   .org 0x0885b6d8
        la v1, msg_buf
