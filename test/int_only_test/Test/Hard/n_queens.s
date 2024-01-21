    .arch armv8 
    .text 
    .globl printans
    .p2align 2
    .type printans, %function
printans:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, Addr0_1
    ldr r0, [r0]
    add r1, r0, #1
    push {r0}
    ldr r0, Addr0_1
    str r1, [r0]
    pop {r0}
    Ldr r2, =1
    b bb0_0
bb0_0:
    ldr r3, Addr0_2
    ldr r3, [r3]
    cmp r2, r3
    ldr r4, =0
    ldrle r4, =1
    cmp r2, r3
    ble bb0_1
    b bb0_2
bb0_1:
    add r5, r2, #0
    ldr r6, Addr0_0
    ldr r7, =4
    mul r8, r5, r7
    add r9, r6, r8
    ldr r0, [r9]
    STM SP, {r0, r2}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r0, r2}
    ldr r1, Addr0_2
    ldr r1, [r1]
    cmp r2, r1
    ldr r3, =0
    ldreq r3, =1
    cmp r2, r1
    beq bb0_3
    b bb0_4
bb0_2:
    b bb0_6
bb0_3:
    ldr r0, =10
    bl put_char
    b bb0_6
bb0_4:
    STM SP, {r2}
    ldr r0, =32
    bl put_char
    LDM sp, {r2}
    b bb0_5
bb0_5:
    b litpool0_0
    .pool
litpool0_0:
    add r4, r2, #1
    Mov r2, r4
    b bb0_0
bb0_6:
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr0_0:
    .long ..ans
Addr0_1:
    .long ..sum
Addr0_2:
    .long ..n

    .globl f
    .p2align 2
    .type f, %function
f:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #40
    Ldr r1, =1
    b bb1_0
bb1_0:
    ldr r2, Addr1_1
    ldr r2, [r2]
    cmp r1, r2
    ldr r3, =0
    ldrle r3, =1
    cmp r1, r2
    ble bb1_1
    b bb1_2
bb1_1:
    add r4, r1, #0
    ldr r5, Addr1_2
    ldr r6, =4
    mul r7, r4, r6
    add r8, r5, r7
    ldr r9, [r8]
    ldr r2, =1
    cmp r9, r2
    ldr r3, =0
    ldrne r3, =1
    ldr r6, =1
    cmp r9, r6
    bne bb1_3
    b bb1_4
bb1_2:
    b bb1_11
bb1_3:
    add r5, r0, r1
    add r7, r5, #0
    ldr r8, Addr1_3
    ldr r2, =4
    mul r9, r7, r2
    add r3, r8, r9
    ldr r6, [r3]
    ldr r4, =0
    cmp r6, r4
    ldr r5, =0
    ldreq r5, =1
    ldr r7, =0
    cmp r6, r7
    beq bb1_5
    b bb1_6
bb1_4:
    add r4, r1, #1
    Mov r1, r4
    b bb1_0
bb1_5:
    ldr r2, Addr1_1
    ldr r2, [r2]
    add r8, r2, r0
    sub r9, r8, r1
    add r3, r9, #0
    ldr r4, Addr1_4
    ldr r6, =4
    mul r5, r3, r6
    add r7, r4, r5
    ldr r2, [r7]
    ldr r8, =0
    cmp r2, r8
    ldr r9, =0
    ldreq r9, =1
    ldr r3, =0
    cmp r2, r3
    beq bb1_7
    b bb1_8
bb1_6:
    b litpool1_0
    .pool
litpool1_0:
    b bb1_4
bb1_7:
    add r6, r0, #0
    ldr r4, Addr1_0
    ldr r5, =4
    mul r7, r6, r5
    add r8, r4, r7
    str r1, [r8]
    ldr r2, Addr1_1
    ldr r2, [r2]
    cmp r0, r2
    ldr r9, =0
    ldreq r9, =1
    cmp r0, r2
    beq bb1_9
    b bb1_10
bb1_8:
    b bb1_6
bb1_9:
    STM SP, {r0, r1}
    bl printans
    LDM sp, {r0, r1}
    b bb1_10
bb1_10:
    add r3, r1, #0
    ldr r6, Addr1_2
    ldr r5, =4
    mul r4, r3, r5
    add r7, r6, r4
    ldr r8, =1
    str r8, [r7]
    add r2, r0, r1
    add r9, r2, #0
    ldr r3, Addr1_3
    ldr r5, =4
    mul r6, r9, r5
    add r4, r3, r6
    ldr r7, =1
    str r7, [r4]
    ldr r8, Addr1_1
    ldr r8, [r8]
    add r2, r8, r0
    sub r5, r2, r1
    add r9, r5, #0
    ldr r6, Addr1_4
    ldr r3, =4
    mul r4, r9, r3
    add r7, r6, r4
    ldr r8, =1
    str r8, [r7]
    add r2, r0, #1
    STM SP, {r0, r1, r2}
    ldr r0, [sp, #8]
    bl f
    LDM sp, {r0, r1, r2}
    add r5, r1, #0
    ldr r3, Addr1_2
    ldr r9, =4
    mul r4, r5, r9
    add r6, r3, r4
    ldr r7, =0
    str r7, [r6]
    add r8, r0, r1
    add r2, r8, #0
    ldr r9, Addr1_3
    ldr r5, =4
    mul r4, r2, r5
    add r3, r9, r4
    ldr r6, =0
    str r6, [r3]
    ldr r7, Addr1_1
    ldr r7, [r7]
    add r8, r7, r0
    sub r5, r8, r1
    add r2, r5, #0
    ldr r4, Addr1_4
    ldr r9, =4
    mul r3, r2, r9
    add r6, r4, r3
    ldr r7, =0
    str r7, [r6]
    b bb1_8
bb1_11:
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..ans
Addr1_1:
    .long ..n
Addr1_2:
    .long ..row
Addr1_3:
    .long ..line1
Addr1_4:
    .long ..line2

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl get_int
    Mov r1, r0
    b bb2_0
bb2_0:
    ldr r2, =0
    cmp r1, r2
    ldr r3, =0
    ldrgt r3, =1
    ldr r4, =0
    cmp r1, r4
    bgt bb2_1
    b bb2_2
bb2_1:
    b litpool2_0
    .pool
litpool2_0:
    STM SP, {r1}
    bl get_int
    LDM SP, {r1}
    mov r6, r0
    push {r0}
    ldr r0, Addr2_1
    str r6, [r0]
    pop {r0}
    STM SP, {r1}
    ldr r0, =1
    bl f
    LDM sp, {r1}
    sub r7, r1, #1
    Mov r1, r7
    b bb2_0
bb2_2:
    ldr r5, Addr2_0
    ldr r5, [r5]
    b bb2_3
bb2_3:
    mov r0, r5
    mov sp, r11
    pop {r4, r5, r6, r7, r11, lr}
    bx lr
    .pool
Addr2_0:
    .long ..sum
Addr2_1:
    .long ..n

    .type ..ans, %object
    .comm ..ans, 200, 4

    .type ..sum, %object
    .bss
    .globl ..sum
    .p2align 2
..sum:
    .long 0
    .size ..sum, 4

    .type ..n, %object
    .bss
    .globl ..n
    .p2align 2
..n:
    .long 0
    .size ..n, 4

    .type ..row, %object
    .comm ..row, 200, 4

    .type ..line1, %object
    .comm ..line1, 200, 4

    .type ..line2, %object
    .comm ..line2, 400, 4

