    .arch armv8 
    .text 
    .globl read_program
    .p2align 2
    .type read_program, %function
read_program:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl get_int
    Ldr r1, =0
    b bb0_0
bb0_0:
    cmp r1, r0
    ldr r2, =0
    ldrlt r2, =1
    cmp r1, r0
    blt bb0_1
    b bb0_2
bb0_1:
    add r9, r1, #0
    ldr r2, Addr0_0
    ldr r3, =4
    mul r5, r9, r3
    add r4, r2, r5
    STM SP, {r0, r1}
    bl get_char
    LDMIB SP, {r1}
    mov r6, r0
    ldr r0, [SP]
    str r6, [r4]
    add r7, r1, #1
    Mov r1, r7
    b bb0_0
bb0_2:
    add r3, r1, #0
    ldr r4, Addr0_0
    ldr r5, =4
    mul r6, r3, r5
    add r7, r4, r6
    ldr r8, =0
    str r8, [r7]
    b bb0_3
bb0_3:
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr0_0:
    .long ..program

    .globl interpret
    .p2align 2
    .type interpret, %function
interpret:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #44
    Ldr r1, =0
    b bb1_0
bb1_0:
    add r3, r1, #0
    add r4, r0, #0
    ldr r5, =4
    mul r6, r3, r5
    add r7, r4, r6
    ldr r8, [r7]
    ldr r9, =0
    cmp r8, r9
    ldr r5, =0
    ldrne r5, =1
    ldr r3, =0
    cmp r8, r3
    bne bb1_1
    b bb1_2
bb1_1:
    add r6, r1, #0
    add r4, r0, #0
    ldr r7, =4
    mul r9, r6, r7
    add r8, r4, r9
    ldr r5, [r8]
    ldr r3, =62
    cmp r5, r3
    ldr r7, =0
    ldreq r7, =1
    ldr r6, =62
    cmp r5, r6
    beq bb1_3
    b bb1_4
bb1_2:
    b litpool1_0
    .pool
litpool1_0:
    b bb1_32
bb1_3:
    ldr r8, Addr1_1
    ldr r8, [r8]
    add r6, r8, #1
    push {r0}
    ldr r0, Addr1_1
    str r6, [r0]
    pop {r0}
    Mov r4, r5
    Mov r8, r2
    Mov r9, r1
    b bb1_5
bb1_4:
    ldr r9, =60
    cmp r5, r9
    ldr r4, =0
    ldreq r4, =1
    ldr r8, =60
    cmp r5, r8
    beq bb1_6
    b bb1_7
bb1_5:
    add r3, r9, #1
    Mov r1, r3
    Mov r2, r8
    b bb1_0
bb1_6:
    ldr r3, Addr1_1
    ldr r3, [r3]
    sub r7, r3, #1
    push {r0}
    ldr r0, Addr1_1
    str r7, [r0]
    pop {r0}
    Mov r3, r1
    Mov r6, r5
    Mov r7, r2
    b bb1_8
bb1_7:
    ldr r3, =43
    cmp r5, r3
    ldr r6, =0
    ldreq r6, =1
    ldr r7, =43
    cmp r5, r7
    beq bb1_9
    b bb1_10
bb1_8:
    Mov r4, r6
    Mov r8, r7
    Mov r9, r3
    b bb1_5
bb1_9:
    ldr r8, Addr1_1
    ldr r8, [r8]
    add r7, r8, #0
    ldr r3, Addr1_0
    ldr r9, =4
    mul r6, r7, r9
    add r4, r3, r6
    ldr r8, Addr1_1
    ldr r8, [r8]
    add r9, r8, #0
    ldr r7, Addr1_0
    ldr r6, =4
    mul r3, r9, r6
    add r8, r7, r3
    ldr r6, [r8]
    add r9, r6, #1
    str r9, [r4]
    Mov r4, r5
    Mov r8, r2
    Mov r9, r1
    b bb1_11
bb1_10:
    b litpool1_1
    .pool
litpool1_1:
    ldr r9, =45
    cmp r5, r9
    ldr r8, =0
    ldreq r8, =1
    ldr r4, =45
    cmp r5, r4
    beq bb1_12
    b bb1_13
bb1_11:
    Mov r3, r9
    Mov r6, r4
    Mov r7, r8
    b bb1_8
bb1_12:
    ldr r3, Addr1_1
    ldr r3, [r3]
    add r7, r3, #0
    ldr r8, Addr1_0
    ldr r4, =4
    mul r9, r7, r4
    add r6, r8, r9
    ldr r3, Addr1_1
    ldr r3, [r3]
    add r4, r3, #0
    ldr r7, Addr1_0
    ldr r9, =4
    mul r8, r4, r9
    add r3, r7, r8
    ldr r9, [r3]
    sub r4, r9, #1
    str r4, [r6]
    Mov r3, r1
    Mov r6, r5
    Mov r7, r2
    b bb1_14
bb1_13:
    ldr r3, =46
    cmp r5, r3
    ldr r7, =0
    ldreq r7, =1
    ldr r6, =46
    cmp r5, r6
    beq bb1_15
    b bb1_16
bb1_14:
    Mov r4, r6
    Mov r8, r7
    Mov r9, r3
    b bb1_11
bb1_15:
    ldr r6, Addr1_1
    ldr r6, [r6]
    add r7, r6, #0
    ldr r4, Addr1_0
    ldr r3, =4
    mul r8, r7, r3
    add r9, r4, r8
    ldr r6, [r9]
    STM SP, {r0, r1, r2}
    mov r0, r6
    bl put_char
    LDM sp, {r0, r1, r2}
    Mov r4, r5
    Mov r8, r2
    Mov r9, r1
    b bb1_17
bb1_16:
    ldr r9, =44
    cmp r5, r9
    ldr r4, =0
    ldreq r4, =1
    ldr r8, =44
    cmp r5, r8
    beq bb1_18
    b bb1_19
bb1_17:
    b litpool1_2
    .pool
litpool1_2:
    Mov r3, r9
    Mov r6, r4
    Mov r7, r8
    b bb1_14
bb1_18:
    ldr r9, Addr1_1
    ldr r9, [r9]
    add r7, r9, #0
    ldr r3, Addr1_0
    ldr r6, =4
    mul r4, r7, r6
    add r8, r3, r4
    STM SP, {r0, r1, r2}
    bl get_char
    LDMIB SP, {r1, r2}
    mov r9, r0
    ldr r0, [SP]
    str r9, [r8]
    Mov r3, r1
    Mov r6, r5
    Mov r7, r2
    b bb1_20
bb1_19:
    ldr r3, =93
    cmp r5, r3
    ldr r6, =0
    ldreq r6, =1
    ldr r7, =93
    cmp r5, r7
    beq bb1_23
    Mov r4, r5
    Mov r8, r2
    Mov r9, r1
    b bb1_22
bb1_20:
    Mov r4, r6
    Mov r8, r7
    Mov r9, r3
    b bb1_17
bb1_21:
    Ldr r3, =1
    Mov r8, r5
    Mov r9, r1
    b bb1_24
bb1_22:
    Mov r3, r9
    Mov r6, r4
    Mov r7, r8
    b bb1_20
bb1_23:
    ldr r7, Addr1_1
    ldr r7, [r7]
    add r6, r7, #0
    ldr r9, Addr1_0
    ldr r8, =4
    mul r4, r6, r8
    add r3, r9, r4
    ldr r7, [r3]
    ldr r8, =0
    cmp r7, r8
    ldr r6, =0
    ldrne r6, =1
    ldr r4, =0
    cmp r7, r4
    bne bb1_21
    Mov r4, r5
    Mov r8, r2
    Mov r9, r1
    b bb1_22
bb1_24:
    b litpool1_3
    .pool
litpool1_3:
    ldr r4, =0
    cmp r3, r4
    ldr r7, =0
    ldrgt r7, =1
    ldr r6, =0
    cmp r3, r6
    bgt bb1_25
    b bb1_26
bb1_25:
    sub r4, r9, #1
    add r6, r4, #0
    add r7, r0, #0
    ldr r8, =4
    mul r9, r6, r8
    str r0, [sp, #20]
    add r0, r7, r9
    str r0, [sp, #36]
    ldr r0, [sp, #36]
    ldr r8, [r0]
    ldr r6, =91
    cmp r8, r6
    ldr r9, =0
    ldreq r9, =1
    ldr r7, =91
    cmp r8, r7
    ldr r0, [sp, #20]
    beq bb1_27
    b bb1_28
bb1_26:
    Mov r4, r8
    Mov r8, r3
    b bb1_22
bb1_27:
    sub r6, r3, #1
    Mov r9, r6
    b bb1_29
bb1_28:
    ldr r6, =93
    cmp r8, r6
    ldr r9, =0
    ldreq r9, =1
    ldr r7, =93
    cmp r8, r7
    beq bb1_30
    Mov r6, r3
    b bb1_31
bb1_29:
    Mov r3, r9
    Mov r9, r4
    b bb1_24
bb1_30:
    b litpool1_4
    .pool
litpool1_4:
    add r7, r3, #1
    Mov r6, r7
    b bb1_31
bb1_31:
    Mov r9, r6
    b bb1_29
bb1_32:
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..tape
Addr1_1:
    .long ..ptr

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    bl read_program
    ldr r0, Addr2_0
    ldr r1, =0
    ldr r2, =4
    mul r3, r1, r2
    add r4, r0, r3
    mov r0, r4
    bl interpret
    b bb2_0
bb2_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r11, lr}
    bx lr
    .pool
Addr2_0:
    .long ..program

    .type ..TAPE_LEN, %object
    .section .rodata,"a", %progbits
    .globl ..TAPE_LEN
    .p2align 2
..TAPE_LEN:
    .long 65536
    .size ..TAPE_LEN, 4

    .type ..BUFFER_LEN, %object
    .section .rodata,"a", %progbits
    .globl ..BUFFER_LEN
    .p2align 2
..BUFFER_LEN:
    .long 32768
    .size ..BUFFER_LEN, 4

    .type ..tape, %object
    .comm ..tape, 262144, 4

    .type ..program, %object
    .comm ..program, 131072, 4

    .type ..ptr, %object
    .bss
    .globl ..ptr
    .p2align 2
..ptr:
    .long 0
    .size ..ptr, 4

