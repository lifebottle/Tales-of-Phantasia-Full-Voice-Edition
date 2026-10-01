   ; font mode for main menu options
   ; 08830060 01 00      li      a2,0x1
   ;          06 24
   .org 0x08830060
        li a2, 0 ; was 1

    ; 089bcdd4 - table for main menu options (>= 0x80 - sprite, <0x80 - string num)

    ; 089bcdd6 - Item sprite, change to string num
    .org 0x089bcdd6
        .db 7 ; was 0x80

    ; 089bcddb - Status sprite
    .org 0x089bcddb
        .db 8 ; was 0x81

    ; 089bcddc - Customize sprite
    .org 0x089bcddc
        .db 9 ; was 0x82

    ; 089bcddd - Save sprite
    .org 0x089bcddd
        .db 0x0a ; was 0x83

    ; 0089bcdde - Load sprite
    .org 0x089bcdde
        .db 0x0b ; was 0x84

   ; main menu options - x position
   ; 08830020 1c 00      li      a0,0x1c
   ;          04 24
   .org 0x08830020
        li a0, 0x14 ; was 0x1c

   ; 08bdaa32 - line-height for big font (used in menu descriptions)
   ; .org 0x08bdaa32
   ;     .db 0x0d ; was 0x10

   ; main item description - pos x
   ; 0883faf0 30 00      _li     a1,0x30
   ;          05 24
   ; .org 0x0883faf0
   ;      li a1, 0x40 ; was 0x30

   ; main item description - pos y
   ; 0883fad8 c0 00      li      a2,0xc0
   ;          06 24
   ; .org 0x0883fad8
   ;      li a2, 0xbc ; was 0xc0

   ; main item description - window height
   ; 089bd93a 44         ??      44h    D
   ; 089bd93b 00         ??      00h
   .org 0x089bd93a
        .dh 0x54 ; was 0x44

   ; main item menu colon
   ; 08834db4 3a 00      _li     a2,0x3a
   ;          06 24
   .org 0x08834db4
        li a2, 0x20 ; was 0x3a, changed to space

   ; main item menu left column pos x
   ; 08834a58 36 00      li      a1,0x36
   ;          05 24
   .org 0x08834a58
        li a1, 0x26 ; was 0x36

   ; main item menu right column pos x
   ; 08834a98 ca 00      _li     a1,0xca
   ;          05 24
   .org 0x08834a98
        li a1, 0xc0 ; was 0xca

   ; main item menu cursor pos x
   .org 0x089bd000
        .db 0x18 ; was 0x28

   ; main item menu cursor pos x
   .org 0x089bd004
        .db 0x9a ; was 0x94

   ; main item menu top arrow pos x
   ; 08834b00 9a 00      li      a2,0x9a
   ;          06 24
   .org 0x08834b00
        li a2, 0x9c ; was 0x9a

   ; main item menu bottom arrow pos x
   ; 08834b34 9a 00      li      a2,0x9a
   ;          06 24
   .org 0x08834b34
        li a2, 0x9c ; was 0x9a

   ; main item menu - offset between name and number
   ; 08834d94 40 00      addiu   v0,v0,0x40
   ;          42 24
   .org 0x08834d94
        addiu v0, v0, 0x58 ; was 0x40

   ; main item menu - item type pos x
   ; 0883fa74 f3 00      li      v0,0xf3
   ;          02 24
   ; 0883fa78 23 10      subu    v0,v0,v1
   ;          43 00
   .org 0x0883fa74
        li v0, 0xc0
        nop

   ; main menu artes description - pos y
   ; 08831ba8 c0 00      _li     s0,0xc0
   ;          10 24
   ; .org 0x08831ba8
   ;      li s0, 0xbc ; was 0xc0

   ; main menu artes description - window height
   ; 089bcf02 44         ??      44h    D
   ; 089bcf03 00         ??      00h
   .org 0x089bcf02
        .dh 0x54 ; was 0x44

   ; main menu artes description - TP, number offset
   ; 08831d88 18 00      li      a3,0x18
   ;          07 24
   ; 08831d8c 09 07      jal     draw_title_param                 undefined draw_title_param()
   ;          21 0e
   .org 0x08831d88
        li a3, 0x16 ; was 0x18

   ; main menu artes description - TP, number of digits
   ; 08831d90 03 00      _li     t2,0x3
   ;          0a 24
   .org 0x08831d90
        li t2, 0x4 ; was 0x3

   ; main menu artes description - TP, pos y
   ; 08831d28 ac 00      _li     s0,0xac
   ;          10 24
   ; .org 0x08831d28
   ;      li s0, 0xaa ; was 0xac

   ; 08831c94 ac 00      _li     s0,0xac
   ;          10 24
   ; .org 0x08831c94
   ;      li s0, 0xaa ; was 0xac

   ; main menu artes description - Mastery, pos y
   ; 08831cbc b4 00      li      a2,0xb4
   ;          06 24
   .org 0x08831cbc
        li a2, 0xb6 ; was 0xb4

   ; 08831c54 b4 00      li      a2,0xb4
   ;          06 24
   .org 0x08831c54
        li a2, 0xb6 ; was 0xb4

   ; title menu description - pos y
   ; 0883be6c c0 00      li      a2,0xc0
   ;          06 24
   ; .org 0x0883be6c
   ;      li a2, 0xbc ; was 0xc0

   ; title menu description - window size
   ; 089bd690 30         ??      30h    0
   ; 089bd691 01         ??      01h
   ; 089bd692 44         ??      44h    D
   ; 089bd693 00         ??      00h
   .org 0x089bd690
        ; width
        .dh 0x168 ; was 0x130
        ; height
        .dh 0x54 ; was 0x44

   ; cooking menu description - pos y
   ; 0883fe1c c0 00      li      a2,0xc0
   ;          06 24
   ; .org 0x0883fe1c
   ;      li a2, 0xbc ; was 0xc0

   ; equipment menu (left) colon
   ; 08833190 3a 00      _li     a2,0x3a
   ;          06 24
   .org 0x08833190
        li a2, 0x20 ; was 0x3a, replaced with space

   ; equipment menu (left) item pos x
   ; 08833164 34 00      li      a1,0x34
   ;          05 24
   .org 0x08833164
        li a1, 0x24 ; was 0x34

   ; equipment menu (left) cursor pos x
   .org 0x089bcf44
        .db 0x24 ; was 0x34

   ; equipment menu (left) number offset
   ; 08833174 74 00      li      a0,0x74
   ;          04 24
   .org 0x08833174
        li a0, 0x7c ; was 0x74

   ; equipment menu (right) - equipped items, label, pos x
   ; 088333c0 e8 00      li      a1,0xe8
   ;          05 24
   .org 0x088333c0
        li a1, 0xe0 ; was 0xe8

   ; equipment menu Slash y pos
   ; 0883346c 50 00      li      a0,0x50
   ;          04 24
   .org 0x0883346c
        li a0, 0x4c ; was 0x50

   ; 0883343c 44 00      li      a2,0x44
   ;          06 24
   .org 0x0883343c
        li a2, 0x40 ; was 0x44

   ; main artes menu - left side, window coords
   .org 0x089bcec8
       ; size x
       .dh 0x94 ; was 0x80
       ; size y
       ; .dh 0x84

   ; main artes menu - right side, window coords
   .org 0x089bcedc
       ; pos x
       .dh 0x9c ; was 0x88
       ; pos y
       .dh 0x20
       ; size x
       .dh 0x9c ; was 0xb0
       ; size y
       .dh 0x84

   ; FVE code is slightly different
   ; main artes menu - right side, artes pos x
   ; 088316d4 9c 00      addiu   v0,v0,0x9c
   ;          42 24
   .org 0x088316d4
        addiu v0, v0, 0xac ; was 0x9c

   ; FVE code is slightly different
   ; main artes menu - right side, current column
   ; 088316bc 01 00      andi    v1,s0,0x1
   ;          03 32
   .org 0x088316bc
        move v1, zero  ; forced to one column

   ; FVE code is slightly different
   ; main artes menu - right side, column number
   ; 088316e0 43 10      _sra    v0,s0,0x1
   ;          10 00
   .org 0x088316e0
        move v0, s0

   ; main artes menu - right side, cursor position
   .org 0x089bce20
        ; x pos
        .db 0xa4 ; was 0x94
        ; y pos
        .db 0x40

   ; main artes menu - Auto/Semi-Auto/Manual - window size
   .org 0x089bcf10
        .dh 0x9c ; was 0xa0

   .org 0x089bcf18
        .dh 0x9c ; was 0xa0

   ; main artes menu - Auto - cursor, pos x
   .org 0x089bce40
        .dh 0xaa ; was 0xa8

   ; main artes menu - Semi-Auto - cursor, pos x
   .org 0x089bce48
        .dh 0xce ; was 0xcc

   ; main artes menu - Manual - cursor, pos x
   .org 0x089bce50
        .dh 0x102 ; was 0x100

   ; set_menu_special_max - main artes menu number of columns and rows
   ; 08831330 02 00      li      s2,0x2
   ;          12 24
   ; 08831334 06 00      li      s1,0x6
   ;          11 24
   .org 0x08831330
        li s2, 0x1 ; was 0x2

   ; FUN_088401d0 - discard message
   ; 0884023c 16 69      jal     add_str_prim                      undefined add_str_prim()
   ;          21 0e
   .org 0x0884023c
       j discard_msg_stub-reloc_base
       nop

   ; dsp_menu_title - pos x
   ; 0883f7ec 20 2e      seh     a1,v0
   ;          02 7c
   ; disable old centering
   ; .org 0x0883f7ec
   ;      li a1, 0x18

   ; shop menu help - second column, button prompts, pos x
   ; 08854fcc 74 00      li      a2,0x74
   ;          06 24
   .org 0x08854fcc
        li a2, 0x7c

   ; shop menu help - second column, labels, pos x
   ; 08854ff4 84 00      li      a1,0x84
   ;          05 24
   .org 0x08854ff4
        li a1, 0x8c

   ; Uses sprite manager, which is not in FVE
     ; ; arte popup - width for auto-centering
     ; ; 08982854 80 18      sll     v1,v0,0x2
     ; ;          02 00
     ; 
     ; ; pd_msg - draw text box for arte popup (a1 = width)
     ; ; 089828d0 0c 00      _addiu  a2,s0,0xc
     ; ;          06 26

   ; Optional ingredients string pos x in cooking menu
   ; 0883d3f0 c8 00      li      a1,0xc8
   ;          05 24
   .org 0x0883d3f0
        li a1, 0xb0 ; was 0xc8

   ; Requisite string pos x in cooking menu
   ; 0883d42c b8 00      li      a1,0xb8
   ;          05 24
   .org 0x0883d42c
        li a1, 0xa0 ; was 0xb8

   ; shop list pos x
   ; 08854cb8 20 00      li      a1,0x20
   ;          05 24
   .org 0x08854cb8
        li a1, 0x18 ; was 0x20

   ; shop list cursor pos x
   .org 0x08bbaa9c
        .db 0x18 ; was 0x20

   ; shop list page number pos x and y
   ; 08854ae4 a0 00      li      a1,0xa0
   ;          05 24
   ; 08854ae8 24 00      li      a2,0x24
   ;          06 24
   .org 0x08854ae4
        li a1, 0xa2 ; was 0xa0
        li a2, 0x26 ; was 0x24

   ; better right align
   ; 08854e1c 60 00      li      a1,0x60
   ;          05 24
   ; .org 0x08854e1c
   ;      li a1, 0x68 ; was 0x60

   ; main item description
   ; 0883faec ba 07      jal     draw_menu_knj                     undefined draw_menu_kn
   ;          21 0e
   ; 0883faf0 30 00      _li     a1,0x30
   ;          05 24
   .org 0x0883faec
        jal displayWrappedMain-reloc_base

   ; main artes description
   ; 08831c24 ba 07      jal     draw_menu_knj                     undefined draw_menu_kn
   ;          21 0e
   ; 08831c28 21 40      _li     t0,0
   ;          00 00
   .org 0x08831c24
        jal displayWrappedMain-reloc_base

   ; main strategy description
   ; 08838cd4 ba 07      jal     draw_menu_knj                     undefined draw_menu_kn
   ;          21 0e
   ; 08838cd8 21 40      _li     t0,0
   ;          00 00
   .org 0x08838cd4
        jal displayWrappedMain-reloc_base

   ; main title description
   ; 0883be70 ba 07      jal     draw_menu_knj                     undefined draw_menu_kn
   ;          21 0e
   ; 0883be74 21 40      _li     t0,0
   ;          00 00
   .org 0x0883be70
        jal displayWrappedMainTitles-reloc_base

   ; main menu - Gald number offset
   ; 088300f4 21 38      li      a3,0
   ;          00 00
   .org 0x088300f4
        li a3, 0xd ; was 0

   ; main menu - Encounters number offset
   ; 08830178 21 38      li      a3,0
   ;          00 00
   .org 0x08830178
        li a3, 8 ; was 0

   ; main menu - Max Hits number offset
   ; 088301c4 21 38      li      a3,0
   ;          00 00
   .org 0x088301c4
        li a3, 0x1d ; was 0

   ; status screen - EXP - number offset
   ; 0883d79c 08 00      li      a3,0x8
   ;         07 24
   ; .org 0x0883d79c
   ;     li a3, 0x27 ; was 0x8

   ; main menu - NEXT number offset
   ; 0882fe14 08 00      li      a3,0x8
   ;          07 24
   .org 0x0882fe14
        li a3, 0x15 ; was 0x8

   ; type of font to use for main artes list (0 = dialogue font, 1 = small kanji, 2 = small font)
   ; passed to get_special_name
   ; 088319e0 01 00      li      a1,0x1
   ;          05 24
   ; .org 0x088319e0
   ;     li a1, 2 ; was 1

   ; main artes menu list (Cless) - type of font
   ; 08831748 01 00      li      a1,0x1
   ;          05 24
   ; .org 0x08831748
   ;      li a1, 2 ; was 1

   ; main artes list (Cless) - type of font, left side
   ; 08831568 01 00      li      a1,0x1
   ;          05 24
   ; .org 0x08831568
   ;      li a1, 2 ; was 1

   ; patch some entries in spc_name to force artes to be read as kana
   .org 0x08bbf5b8
        ; multi-byte
        .db 0
        ; font type
        .db 0

   .org 0x08bbf5c8
        ; multi-byte
        .db 0
        ; font type
        .db 0

   .org 0x08bbf5d8
        ; multi-byte
        .db 0
        ; font type
        .db 0

   .org 0x08bbf538
        ; multi-byte
        .db 0

    .org 0x08bbf548
        ; multi-byte
        .db 0

    .org 0x08bbf558
        ; multi-byte
        .db 0

   ; status screen - equipment slot posx
   ; 0883da28 60 00      li      a1,0x60
   ;          05 24
   .org 0x0883da28
        li a1, 0x68 ; was 0x60

   ; status screen - equipment name posx
   ; 0883da70 88 00      li      a1,0x88
   ;          05 24
   .org 0x0883da70
        li a1, 0x98 ; was 0x88

   ; status screen - level number offset
   ; 0883d730 18 00      li      a3,0x18
   ;          07 24
   .org 0x0883d730
        li a3, 4 ; was 0x18

   ; status screen - NEXT - number offset
   ; 0883d7d0 18 00      li      a3,0x18
   ;          07 24
   .org 0x0883d7d0
        li a3, 0x25 ; was 0x18

   ; status screen - Strength - number offset
   ; 0883d804 18 00      li      a3,0x18
   ;          07 24
   .org 0x0883d804
        li a3, 0x11 ; was 0x18
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Constitution - number offset
   ; 0883d838 21 38      move    a3,a1
   ;          a0 00
   .org 0x0883d838
        li a3, 0x11 ; was 0x10
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Agility - number offset
   ; 0883d86c 08 00      li      a3,0x8
   ;          07 24
   .org 0x0883d86c
        li a3, 0x11 ; was 0x8
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Luck - number offset
   ; 0883d8a0 21 38      move    a3,a1
   ;          a0 00
   .org 0x0883d8a0
        li a3, 0x11 ; was 0x10
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Slash - pos y
   ; 0883d8dc ac 00      li      a2,0xac
   ;          06 24
   .org 0x0883d8dc
        li a2, 0xa8 ; was 0xac

   ; status screen - Slash - number offset
   ; 0883d8e0 18 00      li      a3,0x18
   ;          07 24
   .org 0x0883d8e0
        li a3, 0x11 ; was 0x18
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Thrust - number offset
   ; 0883d914 18 00      li      a3,0x18
   ;          07 24
   .org 0x0883d914
        li a3, 0x11 ; was 0x18
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Attack - number offset
   ; 0883d950 08 00      li      a3,0x8
   ;          07 24
   .org 0x0883d950
        li a3, 0x11 ; was 0x8
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Defense - number offset
   ; 0883d984 08 00      li      a3,0x8
   ;          07 24
   .org 0x0883d984
        li a3, 0x11 ; was 0x8
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Accuracy - number offset
   ; 0883d9b8 21 38      li      a3,0
   ;          00 00
   .org 0x0883d9b8
        li a3, 0x11 ; was 0
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; status screen - Evasion - number offset
   ; 0883d9ec 21 38      move    a3,a1
   ;          a0 00
   .org 0x0883d9ec
        li a3, 0x11 ; was 0x10
        jal newWriteStrAndNum-reloc_base
        li t2, 8

   ; item stats - evasion, number offset
   ; 0883fbe4 14 00      li      a3,0x14
   ;          07 24
   .org 0x0883fbe4
        li a3, 0xb ; was 0x14

   ; item stats - element icon, pos y
   ; 0883fd00 d0 00      li      a2,0xd0
   ;          06 24
   .org 0x0883fd00
        li a2, 0xd2 ; was 0xd0

   ; item stats - defense, number offset
   ; 0883fbc8 0c 00      li      a3,0xc
   ;          07 24
   .org 0x0883fbc8
        li a3, 0xb ; was 0xc

   ; 0883fb68 04 00      li      a3,0x4
   ;          07 24
   .org 0x0883fb68
        li a3, 2 ; was 4

   ; item stats - attack, number of digits
   ; 0883fb7c 21 48      _move   t1,a3
   ;          e0 00
   .org 0x0883fb7c
        li t1, 4

   ; item stats - slash
   ; 0883fb28 04 00      li      a3,0x4
   ;          07 24
   ; 0883fb2c 20 00      li      a0,0x20
   ;          04 24
   ; 0883fb30 c0 00      li      a1,0xc0
   ;          05 24
   .org 0x0883fb28
        ; number offset
        li a3, 0xe ; was 0x4
        ; posx
        li a0, 0x10 ; was 0x20
        ; posy
        li a1, 0xc4 ; was 0xc0

   ; item stats - slash, number of digits
   ; 0883fb3c 21 48      _move   t1,a3
   ;          e0 00
   .org 0x0883fb3c
        li t1, 4

   ; item stats - thrust
   ; 0883fb44 04 00      li      a3,0x4
   ;          07 24
   ; 0883fb48 20 00      li      a0,0x20
   ;          04 24
   ; 0883fb4c c8 00      li      a1,0xc8
   ;          05 24
   .org 0x0883fb44
        ; number offset
        li a3, 0x8 ; was 0x4
        ; posx
        li a0, 0x10 ; was 0x20
        ; posy
        li a1, 0xce ; was 0xc8

   ; item stats - thrust, number of digits
   ; 0883fb58 21 48      _move   t1,a3
   ;          e0 00
   .org 0x0883fb58
        li t1, 4

  ; item stats - luck, number offset
  ; 0883fc00 0c 00      li      a3,0xc
  ;         07 24
  ; .org 0x0883fc00
  ;     li a3, 2 ; was 0xc

   ; stat-boosting items - Agility, number of digits
   ; 08838218 09 07      jal     draw_title_param                 undefined draw_title_param()
   ;          21 0e
   ; 0883821c 03 00      _li     t2,0x3
   ;          0a 24
   .org 0x08838218
       jal newWriteStrAndNum-reloc_base
       li t2, 9

   ; stat-boosting items - Strength, number of digits
   ; 08838254 09 07      jal     draw_title_param                 undefined draw_title_param()
   ;          21 0e
   ; 08838258 03 00      _li     t2,0x3
   ;          0a 24
   .org 0x08838254
       jal newWriteStrAndNum-reloc_base
       li t2, 7

   ; stat-boosting items - Strength, pos y
   ; 08838220 10 00      addiu   v0,s4,0x10
   ;          82 26
   .org 0x08838220
        addiu v0, s4, 0x12 ; was 0x10

   ; stat-boosting items - TP, pos y
   ; 088381b0 10 00      addiu   v0,s4,0x10
   ;          82 26
   .org 0x088381b0
        addiu v0, s4, 0x12 ; was 0x10

   ; disable old code that skipped past the first 3 chars in arcane names
   ; 088ae618 03 00      li      a1,0x3
   ;          05 24
   .org 0x088ae618
        li a1, 0 ; was 0x3

   ; customize controls - right arrow pos x
   ; 08828728 21 10      addu    v0,v0,s0
   ;          50 00
   .org 0x08828728
        addiu v0, v0, 0x40

   ; main artes menu - cursor position
   ; .org 0x089bce30
   ;      .db 0x10 ; was 0x20

   ; main artes menu - cursor position, column width
   .org 0x089bce34
        .db 0x88 ; was 0x58

   ; main artes menu - number of columns
   ; 08831390 03 00      li      s2,0x3
   ;          12 24
   .org 0x08831390
        li s2, 0x2 ; was 0x3

   ; Collector's Book - Completion colon posx
   ; 0882d39c e0 00      li      a0,0xe0
   ;          04 24
   .org 0x0882d39c
        li a0, 0xcd ; was 0xe0

   ; Collector's Book - item list posx
   ; 0882d474 28 00      addiu   v0,v0,0x28
   ;          42 24
   ; .org 0x0882d474
   ;      addiu v0, v0, 0x18 ; was 0x28

   ; Collector's Book - item list column width (multiply by 0x58)
   ; 0882d45c 18 00      mult    a1,s0
   ;          b0 00
   ; 0882d460 80 10      sll     v0,v1,0x2
   ;          03 00
   ; 0882d464 21 10      addu    v0,v0,v1
   ;          43 00
   ; 0882d468 40 10      sll     v0,v0,0x1
   ;          02 00
   ; 0882d46c 21 10      addu    v0,v0,v1
   ;          43 00
   ; 0882d470 c0 10      sll     v0,v0,0x3
   ;          02 00
   ; 0882d474 28 00      addiu   v0,v0,0x28
   ;          42 24
   ; 0882d478 20 2e      seh     a1,v0
   ;          02 7c
   ; 0882d47c 10 10      mfhi    v0
   ;          00 00
   ; 0882d480 21 18      addu    v1,v0,t0
   ;          48 00
   .org 0x0882d45c
        mult a1, s0
        nop
        mfhi at

        li v0, 0x62
        mult v1, v0
        nop
        mflo v0

        ; item list posx (replaces the original above)
        addiu v0, v0, 0x18 ; was 0x28
        seh a1, v0

        addu v1, at, t0

   ; Collector's Book number/number, pos x
   ; 0882d354 18 00      li      a1,0x18
   ;          05 24

   ; Collector's Book - item list column width, cursor
   ; 08963458 58         ??      58h    X
   .org 0x08963458
        .db 0x62 ; was 0x58

   ; Collector's Book - Item list column width, cursor
   ; 08963454 28         ??      28h    (
   .org 0x08963454
        .db 0x18 ; was 0x28

   ; Formation menu - Level label pos x
   ; 0883b538 64 00      addiu   v0,s0,0x64
   ;          02 26
   .org 0x0883b538
        addiu v0, s0, 0x5e ; was 0x64

   ; Formation menu - Level label draw call
   ; 0883b568 09 07      jal     draw_title_param                 undefined draw_title_param()
   ;          21 0e
   ; 0883b56c 03 00      _li     t2,0x3
   ;          0a 24
   .org 0x0883b568
       jal newWriteStrAndNum-reloc_base
       li t2, 0x6 ; was 0x3

   ; Formation menu - HP/TP, pos x
   ; 0883b580 2c 00      addiu   s0,s0,0x2c
   ;          10 26
   ; .org 0x0883b580
   ;     addiu s0, s0, 0x35 ; was 0x2c

   ; Formation menu - HP, number pos x
   ; 0883b588 0c 00      li      a3,0xc
   ;          07 24
   .org 0x0883b588
        li a3, 0x15

   ; Formation menu - TP, number pos x
   ; 0883b5ac 0c 00      _li     a3,0xc
   ;          07 24
   .org 0x0883b5ac
        li a3, 0x15

   ; Formation menu - clip box, fix original game bug
   .org 0x089bd5fc
        .dh 0x5a ; was 0x58

   ; sound mode - Voiceover
   ; 08857c70 09 07      jal     draw_title_param                 undefined draw_title_param()
   ;          21 0e
   ; 08857c74 04 00      _li     t2,0x4
   ;          0a 24
   .org 0x08857c70
       jal newWriteStrAndNum-reloc_base
       li t2, 0xa ; was 0x4

   ; sound mode - Sound Effect
   ; 08857c38 09 07      jal     draw_title_param                 undefined draw_title_param()
   ;          21 0e
   ; 08857c3c 04 00      _li     t2,0x4
   ;          0a 24
   .org 0x08857c38
       jal newWriteStrAndNum-reloc_base
       li t2, 0x7 ; was 0x4

   ; sound mode - Song
   ; 08857d00 09 07      jal     draw_title_param                 undefined draw_title_param()
   ;          21 0e
   ; 08857d04 04 00      _li     t2,0x4
   ;          0a 24
   .org 0x08857d00
       jal newWriteStrAndNum-reloc_base
       li t2, 0x9 ; was 0x4

   ; sound mode - Skit
   ; 08857d44 09 07      jal     draw_title_param                  undefined draw_title_param()
   ;          21 0e
   ; 08857d48 04 00      _li     t2,0x4
   ;          0a 24
   .org 0x08857d44
       jal newWriteStrAndNum-reloc_base
       li t2, 0x9 ; was 0x4

   ; sound mode - Level, pos x
   ; 08857dd8 40 00      li      a1,0x40
   ;          05 24
   .org 0x08857dd8
        li a1, 0x19 ; was 0x40

   ; sound mode - Spectrum Analyzer, pos x
   ; 08857f20 a8 00      li      a1,0xa8
   ;          05 24
   .org 0x08857f20
        li a1, 0x71 ; was 0xa8

   ; sound mode - total time, pos x
   ; 08857da4 38 00      li      a1,0x38
   ;          05 24
   .org 0x08857da4
        li a1, 0x30 ; was 0x38

   ; sound mode - get BGM title pointer
   ; 08857b88 b7 62      jal     FUN_08858adc                      undefined FUN_08858adc()
   ;          21 0e
   .org 0x08857b88
        jal get_bgm_title-reloc_base

   ; sound mode - get voiceover title pointer
   ; 08857cac 97 62      jal     FUN_08858a5c                      undefined FUN_08858a5c()
   ;          21 0e
   ; .org 0x08857cac
   ;      jal get_vo_title-reloc_base

   ; cooking description
   ; 0883fe20 ba 07      jal     draw_menu_knj                     undefined draw_menu_kn
   ;          21 0e
   ; 0883fe24 21 40      _li     t0,0
   ;          00 00
   ; .org 0x0883fe20
   ;      jal displayWrappedMain-reloc_base

   ; NG+ message, window y size
   ; 089bd8ba 78         ??      78h    x
   ; 089bd8bb 00         ??      00h
   .org 0x089bd8ba
        .dh 0x60 ; was 0x78

   ; grade shop grade number, number of digits
   ; 08835c90 04 00      li      a2,0x4
   ;          06 24
   ; .org 0x08835c90
   ;      li a2, 0x7 ; was 0x4

   ; grade shop grade number pos x
   ; 08835c44 b3 00      li      a0,0xb3
   ;          04 24
   .org 0x08835c44
        li a0, 0xc2 ; was 0xb3

   ; grade shop Total grade number pos x
   ; 08835cac 9a 01      li      a0,0x19a
   ;          04 24
   .org 0x08835cac
       li a0, 0x1aa ; was 0x19a

   ; titles menu - cursor table
   .org 0x089bd640
        ; pos x
        .db 0x98 ; was 0x90

   .org 0x089bd644
        ; column width
        .db 0x68 ; was 0x58

   ; titles menu - current title, cursor pos x
   .org 0x089bd638
        .db 0x14 ; was 0x24

   ; titles menu - current title, pos x
   ; 0883bb64 24 00      li      a1,0x24
   ;          05 24
   .org 0x0883bb64
        li a1, 0x14 ; was 0x24

   .org 0x0883bc00
        li a1, 0x14 ; was 0x24

   ; titles menu - left column window width
   .org 0x089bd680
        .dh 0x80 ; was 0x78

   ; titles menu - right column window coords
   .org 0x089bd684
        ; pos x
        .dh 0x88 ; was 0x80
        ; pos y
        .dh 0x20
        ; width
        .dh 0xe8 ; was 0xb8

   ; titles menu - right column text offset
   ; 0883bce8 90 00      addiu   v0,v0,0x90
   ;          42 24
   .org 0x0883bce8
        addiu v0, v0, 0x98 ; was 0x90

   ; titles menu - right column size (multiply by 0x58)
   ; 0883bcd4 80 10      sll     v0,v1,0x2
   ;          03 00
   ; 0883bcd8 21 10      addu    v0,v0,v1
   ;          43 00
   ; 0883bcdc 40 10      sll     v0,v0,0x1
   ;          02 00
   ; 0883bce0 21 10      addu    v0,v0,v1
   ;          43 00
   ; 0883bce4 c0 10      sll     v0,v0,0x3
   ;          02 00
   .org 0x0883bcd4
        li v0, 0x68
        mult v0, v1
        nop
        mflo v0
        nop

   ; NOTE: needs to be edited if message changes
   ; Replace with whom - hardcoded offset to character num
   ; 0883b0bc 02 00      sh      v0,0x2(a3)=>str14_dat[512]
   ;          e2 a4
   .org 0x0883b0bc
        sh v0, 0x12(a3) ; was 0x2

   ; NOTE: needs to be edited if message changes
   ; Rune Bottle "Changed into" message, hardcoded offset to item num
   ; 08833920 02 00      sh      a1,0x2(v1)=>str14_dat[2734]
   ;          65 a4
   .org 0x08833920
        sh a1, 0x1c(v1); was 0x2
   
   ; NOTE: needs to be edited if message changes
   ; Rune Bottle "Can't hold anymore", hardcoded offset to item num
   ; 08833944 24 00      _sh     a1,0x24(v1)=>str14_dat[2788]
   ;          65 a4
   .org 0x08833944
        sh a1, 0x2a(v1) ; was 0x24

   ; NOTE: needs to be edited if message changes
   ; "has been lit/extinguished", hardcoded offset to item num
   ; 08833cd8 02 00      _sh     s4,0x2(v0)=>str14_dat[2814]
   ;          54 a4
   ; .org 0x08833cd8
   ;      sh s4, 0x8(v0) ; was 0x2

   ; FUN_0883d03c - recipe list
   ; pos x
   ; 0883d198 2c 00      li      a1,0x2c
   ;          05 24
   .org 0x0883d198
        li a1, 0x1c ; was 0x2c

   ; 0883d15c 2c 00      li      a1,0x2c
   ;          05 24
   .org 0x0883d15c
        li a1, 0x1c ; was 0x2c

   ; 0883d120 2c 00      li      a1,0x2c
   ;          05 24
   .org 0x0883d120
        li a1, 0x1c ; was 0x2c

   ; cursor pos
   .org 0x089bd694
        .db 0x1c ; was 0x2c

   ; world map item description window height
   ; 08943228 44 00      li      v0,0x44
   ;          02 24
   .org 0x08943228
        li v0, 0x54 ; was 0x44

; move down to 0xe0 where image icon is written to
.org 0x089cc2ba
	.byte 0xe0		; chg from 0, y pos in image
; change where image is read from
.org 0x08841810
	li t2, 0xe0		; chg from 0, y pos in image 

; NOTE: may need to be updated if you add extra accents that require custom sorting
; sort_code_dat -  look-up table for sorting kana
.org 0x08bb874c
    .area 256
        .incbin "item-sort-lut.bin"
    .endarea

   ; FVE is different
   ; main artes menu - number of columns (divide by 3)
   ; 08831944 03 00      li      v0,0x3
   ;          02 24
   ; 08831948 1a 00      div     s0,v0
   ;          02 02
   ; 0883194c c2 2f      srl     a1,s0,0x1f
   ;          10 00
   ; 08831950 21 20      move    a0,s3
   ;          60 02
   ; 08831954 55 55      lui     v0,0x5555
   ;          02 3c
   ; 08831958 56 55      ori     v1,v0,0x5556
   ;          43 34
   ; 0883195c 10 30      mfhi    a2
   ;          00 00
   ; 08831960 18 00      mult    v1,s0
   ;          70 00
   ; 08831964 2a 00      lh      v0,local_6 (sp)
   ;          a2 87
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
   ; 08831984 10 18      mfhi    v1
   ;          00 00
   .org 0x08831944
        li v0, 0x2 ; was 0x3
   .org 0x08831954
        nop
        nop
   .org 0x08831960
        nop
   ; replaced multiply by 0x58
   .org 0x08831968
        li s2, 0x88
        mult a2, s2
        nop
        mflo v1
        nop
   .org 0x08831984
        sra v1, s0, 1

   ; FUN_08834900 - Key Items label
   ; 08834924 e0 00      li      a1,0xe0
   ;          05 24
   ; 08834928 10 00      li      a2,0x10
   ;          06 24
   ; 0883492C 85 07      jal     draw_menu_str                     undefined draw_menu_st
   ;          21 0e
   .org 0x08834924
        li a1, 0xf0 ; was 0xe0

   ; 089bd020 - Key Items menu - cursor x position
   .org 0x089bd020
        .db 0xf0 ; was 0xe0
