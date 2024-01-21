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
    sub sp, sp, #36
    Ldr r0, =0
    b bb1_0
bb1_0:
    add r2, r0, #0
    ldr r3, Addr1_1
    ldr r4, =4
    mul r5, r2, r4
    add r6, r3, r5
    ldr r7, [r6]
    ldr r8, =0
    cmp r7, r8
    ldr r9, =0
    ldrne r9, =1
    ldr r4, =0
    cmp r7, r4
    bne bb1_1
    b bb1_2
bb1_1:
    add r2, r0, #0
    ldr r5, Addr1_1
    ldr r3, =4
    mul r6, r2, r3
    add r8, r5, r6
    ldr r4, [r8]
    ldr r7, =62
    cmp r4, r7
    ldr r9, =0
    ldreq r9, =1
    ldr r2, =62
    cmp r4, r2
    beq bb1_3
    b bb1_4
bb1_2:
    b litpool1_0
    .pool
litpool1_0:
    b bb1_33
bb1_3:
    ldr r6, Addr1_2
    ldr r6, [r6]
    add r3, r6, #1
    push {r0}
    ldr r0, Addr1_2
    str r3, [r0]
    pop {r0}
    Mov r3, r0
    Mov r5, r4
    Mov r9, r1
    b bb1_5
bb1_4:
    ldr r3, =60
    cmp r4, r3
    ldr r5, =0
    ldreq r5, =1
    ldr r6, =60
    cmp r4, r6
    beq bb1_6
    b bb1_7
bb1_5:
    add r8, r3, #1
    Mov r0, r8
    Mov r1, r9
    b bb1_0
bb1_6:
    ldr r8, Addr1_2
    ldr r8, [r8]
    sub r9, r8, #1
    push {r0}
    ldr r0, Addr1_2
    str r9, [r0]
    pop {r0}
    Mov r2, r4
    Mov r6, r1
    Mov r7, r0
    b bb1_8
bb1_7:
    ldr r8, =43
    cmp r4, r8
    ldr r7, =0
    ldreq r7, =1
    ldr r9, =43
    cmp r4, r9
    beq bb1_9
    b bb1_10
bb1_8:
    Mov r3, r7
    Mov r5, r2
    Mov r9, r6
    b bb1_5
bb1_9:
    ldr r8, Addr1_2
    ldr r8, [r8]
    add r7, r8, #0
    ldr r3, Addr1_0
    ldr r6, =4
    mul r9, r7, r6
    add r5, r3, r9
    ldr r2, Addr1_2
    ldr r2, [r2]
    add r8, r2, #0
    ldr r6, Addr1_0
    ldr r7, =4
    mul r9, r8, r7
    add r3, r6, r9
    ldr r2, [r3]
    add r7, r2, #1
    str r7, [r5]
    Mov r5, r1
    Mov r8, r4
    Mov r9, r0
    b bb1_11
bb1_10:
    b litpool1_1
    .pool
litpool1_1:
    ldr r2, =45
    cmp r4, r2
    ldr r3, =0
    ldreq r3, =1
    ldr r6, =45
    cmp r4, r6
    beq bb1_12
    b bb1_13
bb1_11:
    Mov r2, r8
    Mov r6, r5
    Mov r7, r9
    b bb1_8
bb1_12:
    ldr r8, Addr1_2
    ldr r8, [r8]
    add r2, r8, #0
    ldr r6, Addr1_0
    ldr r3, =4
    mul r7, r2, r3
    add r5, r6, r7
    ldr r9, Addr1_2
    ldr r9, [r9]
    add r8, r9, #0
    ldr r3, Addr1_0
    ldr r2, =4
    mul r7, r8, r2
    add r6, r3, r7
    ldr r9, [r6]
    sub r2, r9, #1
    str r2, [r5]
    Mov r2, r1
    Mov r3, r4
    Mov r6, r0
    b bb1_14
bb1_13:
    ldr r5, =46
    cmp r4, r5
    ldr r8, =0
    ldreq r8, =1
    ldr r9, =46
    cmp r4, r9
    beq bb1_15
    b bb1_16
bb1_14:
    Mov r5, r2
    Mov r8, r3
    Mov r9, r6
    b bb1_11
bb1_15:
    ldr r8, Addr1_2
    ldr r8, [r8]
    add r6, r8, #0
    ldr r7, Addr1_0
    ldr r2, =4
    mul r3, r6, r2
    add r5, r7, r3
    ldr r9, [r5]
    STM SP, {r0, r1}
    mov r0, r9
    bl put_char
    LDM sp, {r0, r1}
    Mov r5, r0
    Mov r7, r4
    Mov r8, r1
    b bb1_17
bb1_16:
    ldr r7, =44
    cmp r4, r7
    ldr r2, =0
    ldreq r2, =1
    ldr r6, =44
    cmp r4, r6
    beq bb1_18
    b bb1_19
bb1_17:
    b litpool1_2
    .pool
litpool1_2:
    Mov r2, r8
    Mov r3, r7
    Mov r6, r5
    b bb1_14
bb1_18:
    ldr r8, Addr1_2
    ldr r8, [r8]
    add r7, r8, #0
    ldr r3, Addr1_0
    ldr r6, =4
    mul r2, r7, r6
    add r5, r3, r2
    STM SP, {r0, r1}
    bl get_char
    LDMIB SP, {r1}
    mov r9, r0
    ldr r0, [SP]
    str r9, [r5]
    Mov r2, r0
    Mov r3, r1
    Mov r9, r4
    b bb1_20
bb1_19:
    ldr r3, =93
    cmp r4, r3
    ldr r5, =0
    ldreq r5, =1
    ldr r9, =93
    cmp r4, r9
    beq bb1_21
    Mov r6, r4
    Mov r7, r1
    Mov r8, r0
    b bb1_22
bb1_20:
    Mov r5, r2
    Mov r7, r9
    Mov r8, r3
    b bb1_17
bb1_21:
    ldr r7, Addr1_2
    ldr r7, [r7]
    add r6, r7, #0
    ldr r2, Addr1_0
    ldr r3, =4
    mul r9, r6, r3
    add r5, r2, r9
    ldr r8, [r5]
    ldr r7, =0
    cmp r8, r7
    ldr r3, =0
    ldrne r3, =1
    ldr r6, =0
    cmp r8, r6
    bne bb1_23
    Mov r2, r1
    Mov r5, r4
    Mov r9, r0
    b bb1_24
bb1_22:
    Mov r2, r8
    Mov r3, r7
    Mov r9, r6
    b bb1_20
bb1_23:
    Ldr r6, =1
    Mov r7, r0
    Mov r8, r4
    b bb1_25
bb1_24:
    b litpool1_3
    .pool
litpool1_3:
    Mov r6, r5
    Mov r7, r2
    Mov r8, r9
    b bb1_22
bb1_25:
    ldr r3, =0
    cmp r6, r3
    ldr r9, =0
    ldrgt r9, =1
    ldr r2, =0
    cmp r6, r2
    bgt bb1_26
    b bb1_27
bb1_26:
    sub r5, r7, #1
    add r3, r5, #0
    ldr r2, Addr1_1
    ldr r9, =4
    mul r8, r3, r9
    add r7, r2, r8
    ldr r9, [r7]
    ldr r3, =91
    cmp r9, r3
    ldr r8, =0
    ldreq r8, =1
    ldr r2, =91
    cmp r9, r2
    beq bb1_28
    b bb1_29
bb1_27:
    Mov r2, r6
    Mov r5, r8
    Mov r9, r7
    b bb1_24
bb1_28:
    sub r2, r6, #1
    Mov r7, r2
    b bb1_30
bb1_29:
    ldr r7, =93
    cmp r9, r7
    ldr r3, =0
    ldreq r3, =1
    ldr r2, =93
    cmp r9, r2
    beq bb1_31
    Mov r8, r6
    b bb1_32
bb1_30:
    Mov r6, r7
    Mov r7, r5
    Mov r8, r9
    b bb1_25
bb1_31:
    b litpool1_4
    .pool
litpool1_4:
    add r3, r6, #1
    Mov r8, r3
    b bb1_32
bb1_32:
    Mov r7, r8
    b bb1_30
bb1_33:
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..tape
Addr1_1:
    .long ..program
Addr1_2:
    .long ..ptr

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r11, lr}
    mov r11, sp
    sub sp, sp, #36
    bl read_program
    bl interpret
    b bb2_0
bb2_0:
    ldr r0, =0
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

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

