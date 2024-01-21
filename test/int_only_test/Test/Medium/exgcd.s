    .arch armv8 
    .text 
    .globl exgcd
    .p2align 2
    .type exgcd, %function
exgcd:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #44
    ldr r2, =0
    cmp r1, r2
    ldr r3, =0
    ldreq r3, =1
    ldr r4, =0
    cmp r1, r4
    beq bb0_0
    b bb0_1
bb0_0:
    ldr r1, Addr0_0
    ldr r3, =0
    ldr r7, =4
    mul r6, r3, r7
    add r4, r1, r6
    ldr r5, =1
    str r5, [r4]
    ldr r2, Addr0_1
    ldr r8, =0
    ldr r9, =4
    mul r3, r8, r9
    add r7, r2, r3
    ldr r1, =0
    str r1, [r7]
    Mov r9, r0
    b bb0_2
bb0_1:
    sdiv r5, r0, r1
    mul r6, r5, r1
    sub r7, r0, r6
    STM SP, {r0, r1}
    ldr r0, [sp, #4]
    mov r1, r7
    bl exgcd
    LDMIB SP, {r1}
    mov r8, r0
    ldr r0, [SP]
    ldr r9, Addr0_0
    ldr r2, =0
    ldr r4, =4
    mul r3, r2, r4
    add r5, r9, r3
    ldr r6, [r5]
    ldr r7, Addr0_0
    ldr r2, =0
    ldr r4, =4
    mul r9, r2, r4
    add r3, r7, r9
    ldr r5, Addr0_1
    ldr r2, =0
    ldr r4, =4
    mul r7, r2, r4
    add r9, r5, r7
    ldr r2, [r9]
    str r2, [r3]
    ldr r4, Addr0_1
    ldr r5, =0
    ldr r7, =4
    mul r9, r5, r7
    add r2, r4, r9
    sdiv r3, r0, r1
    ldr r5, Addr0_1
    ldr r7, =0
    ldr r4, =4
    mul r9, r7, r4
    add r1, r5, r9
    ldr r7, [r1]
    mul r4, r3, r7
    sub r5, r6, r4
    str r5, [r2]
    Mov r9, r8
    b bb0_2
bb0_2:
    mov r0, r9
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr0_0:
    .long ..x
Addr0_1:
    .long ..y

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    ldr r0, =7
    ldr r1, =15
    bl exgcd
    ldr r1, Addr1_0
    ldr r2, =0
    ldr r3, =4
    mul r4, r2, r3
    add r5, r1, r4
    ldr r6, Addr1_0
    ldr r7, =0
    ldr r8, =4
    mul r9, r7, r8
    add r2, r6, r9
    ldr r3, [r2]
    ldr r4, =15
    sdiv r1, r3, r4
    ldr r7, =15
    mul r8, r1, r7
    sub r9, r3, r8
    add r6, r9, #15
    ldr r2, =15
    sdiv r4, r6, r2
    ldr r1, =15
    mul r7, r4, r1
    sub r3, r6, r7
    str r3, [r5]
    ldr r8, Addr1_0
    ldr r9, =0
    ldr r2, =4
    mul r4, r9, r2
    add r1, r8, r4
    ldr r6, [r1]
    STM SP, {r0}
    mov r0, r6
    bl put_int
    LDM sp, {r0}
    b bb1_0
bb1_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..x

    .type ..x, %object
    .data
    .globl ..x
    .p2align 2
..x:
    .long 
    .size ..x, 4

    .type ..y, %object
    .data
    .globl ..y
    .p2align 2
..y:
    .long 
    .size ..y, 4

