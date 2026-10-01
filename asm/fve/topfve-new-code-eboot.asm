map_buf_len equ 0x35000
discard_ptr equ 0x08bd935c

   ; reclaim space previously used by item descriptions
   .org 0x08972090
   .area 0x08974000-.
        discard_msg_stub:
           ; load msg pointer
           lhu a2, discard_ptr
           ; add to block start
           discard_msg_ptr:
           lui v1,hi(0x08bd9478) ; str14_dat
           addiu v1, v1, lo(0x08bd9478) ; str14_dat
           addu a2, v1, a2
           jal discardMsg
           nop
           j 0x08840274
           nop

        map_buf_ptr:
            .dw 0

        map_buf_malloc:
            addiu sp, sp, -0x10
            sw ra, 0xc(sp)
            sw a0, 0x8(sp)
            sw a1, 0x4(sp)

            la a0, map_buf_len

            jal malloc
            nop

            bnez v0, @@malloc_valid
            nop

            la v0, map_buf_old

            @@malloc_valid:
            la t0, map_buf_ptr
            sw v0, 0(t0)

            lw ra, 0xc(sp)
            lw a0, 0x8(sp)
            lw a1, 0x4(sp)
            addiu sp, sp, 0x10

            ; copied from old code
            lui     a0,0x897
            lui     a1,0x883

            j 0x0882e114
            nop

        npc_name_fix:
            addiu sp, sp, -0x10
            sw ra, 0xc(sp)

            li t1, 0
            la v0, party_data+0x500 ; current party

            @@back:
            lh v1, 0(v0)

            ; not Rody or Rhea, skip
            sltiu t2, v1, 7
            bne t2, zero, @@skip
            nop

            ; save this for later
            sw v0, 0x8(sp)

            ; patch name in party data
            li v0, 0xa0
            mult v1, v0
            mflo a0
            la v0, 0x0905d934-0xa0 ; party_data+((index-1)*0xA0)+0xC
            addu a0, a0, v0

            ; get pointer
            la v0, str08_ptr-2
            sll v1, v1, 1
            addu v0, v0, v1
            lhu v0, 0(v0)

            ; block pointer, patched by menu insertor
            @@npc_name_fix_ptr:
            la a1, 0xdeadbeef

            jal strcpy
            addu a1, a1, v0

            lw v0, 0x8(sp)

            @@skip:
            addiu v0, v0, 2

            ; party is only 6 entries
            sltiu t2, t1, 6
            bne t2, zero, @@back
            addiu t1, t1, 1

            lw ra, 0xc(sp)
            jr ra
            addiu sp, sp, 0x10

        utility_lang_stub:
            ; copied from original code
            sw s1, 0x8(sp)

            li s1, 1
            lui v0,hi(0x09cb360c) ; msg.message_lang
            sw s1,lo(0x09cb360c)(v0) ; msg.message_lang

            jr ra
            move s1, a0

        utility_lang_stub2:
            ; copied from original code
            sw s1, 0x4(sp)

            li s1, -1
            lui v0,hi(0x09cb360c) ; msg.message_lang
            sw s1,lo(0x09cb360c)(v0) ; msg.message_lang

            jr ra
            move s1, a0

        utility_lang_stub3:
            li a0, 1
            lui v0,hi(0x09cb3864) ; save_param.message_lang

            jr ra
            sw a0,lo(0x09cb3864)(v0) ; save_param.message_lang

    .endarea

