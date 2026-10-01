.definelabel malloc,0x0880a150
.definelabel memcpy,0x0880aabc
.definelabel map_buf_old,0x09d11630
.definelabel map_index,0x09ce9620

   ; sc_station - base address for map buf
   ; 0890d9dc d1 09      lui     v0,0x9d1
   ;          02 3c
   ; 0890d9e0 21 18      addu    v1,v1,a0
   ;          64 00
   ; 0890d9e4 30 16      addiu   v0,v0,0x1630
   ;          42 24
   ; 0890d9e8 00 1c      sll     v1,v1,0x10
   ;          03 00
   ; 0890d9ec a0 ea      jal     ns_sce_init                       undefined ns_sce_init()
   ;          24 0e
   ; 0890d9f0 21 88      _addu   s1,v0,v1
   ;          43 00
   .orga 0x480C34 :: nop :: nop ; reloc kill
   .orga 0x480C3C :: nop :: nop ; reloc kill
   .org 0x0890d9dc
        jal map_load_ptr
        addu v1, v1, a0
        nop

    .org 0x0890d9f0
        move s1, v0     ; replace addition

   ; sc_reading
   ; 0890d818 40 10      sll     v0,v1,0x1
   ;          03 00
   ; 0890d81c 21 10      addu    v0,v0,v1
   ;          43 00
   ; 0890d820 00 1c      sll     v1,v0,0x10
   ;          02 00
   ; 0890d824 d1 09      lui     v0,0x9d1
   ;          02 3c
   ; 0890d828 30 16      addiu   v0,v0,0x1630
   ;          42 24
   ; 0890d82c 21 20      addu    a0,a0,s1
   ;          91 00
   ; 0890d830 21 28      addu    a1,v0,v1
   ;          43 00
   .orga 0x480B1C :: nop :: nop ; reloc kill
   .orga 0x480B24 :: nop :: nop ; reloc kill
   .org 0x0890d824
        jal map_load_ptr
        nop

    .org 0x0890d830
        move a1, v0     ; replace addition

   ; 0890d86c 40 10      sll     v0,v1,0x1
   ;          03 00
   ; 0890d870 21 10      addu    v0,v0,v1
   ;          43 00
   ; 0890d874 00 1c      sll     v1,v0,0x10
   ;          02 00
   ; 0890d878 d1 09      lui     v0,0x9d1
   ;          02 3c
   ; 0890d87c 30 16      addiu   v0,v0,0x1630
   ;          42 24
   ; 0890d880 21 28      addu    a1,v0,v1
   ;          43 00
   .orga 0x480B64 :: nop :: nop ; reloc kill
   .orga 0x480B6C :: nop :: nop ; reloc kill
   .org 0x0890d878
        jal map_load_ptr
        nop

        move a1, v0     ; replace addition

   ; nmap_init - malloc_heap size
   ; 089405a4 03 00      lui     a0,0x3
   ;          04 3c
   ; .org 0x089405a4
   ;      lui a0, 0x6

   ; main
   ; 0882e10c 97 08      lui     a0,0x897
   ;          04 3c
   ; 0882e110 83 08      lui     a1,0x883
   ;          05 3c
   .orga 0x43177C :: nop :: nop ; reloc kill
   .orga 0x431784 :: nop :: nop ; reloc kill
   .org 0x0882e10c
        j map_buf_malloc
        nop


