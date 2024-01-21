    .arch armv8 
    .text 
    .globl exgcd
    .p2align 2
    .type exgcd, %function
exgcd:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r2, =0
    cmp r1, r2
    ldr r3, =0
    ldreq r3, =1
    ldr r4, =0
    cmp r1, r4
    beq bb0_0
    b bb0_1
bb0_0:
    ldr r4, =0
    add r3, r4, #0
    ldr r9, Addr0_0
    ldr r7, =4
    mul r2, r3, r7
    add r5, r9, r2
    ldr r6, =1
    str r6, [r5]
    ldr r8, =0
    add r1, r8, #0
    ldr r4, Addr0_1
    ldr r7, =4
    mul r3, r1, r7
    add r9, r4, r3
    ldr r2, =0
    str r2, [r9]
    Mov r1, r0
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
    ldr r9, =0
    add r2, r9, #0
    ldr r4, Addr0_0
    ldr r3, =4
    mul r5, r2, r3
    add r6, r4, r5
    ldr r7, [r6]
    ldr r9, =0
    add r2, r9, #0
    ldr r3, Addr0_0
    ldr r4, =4
    mul r5, r2, r4
    add r6, r3, r5
    ldr r9, =0
    add r2, r9, #0
    ldr r4, Addr0_1
    ldr r3, =4
    mul r5, r2, r3
    add r9, r4, r5
    ldr r2, [r9]
    str r2, [r6]
    ldr r3, =0
    add r4, r3, #0
    ldr r5, Addr0_1
    ldr r9, =4
    mul r2, r4, r9
    add r6, r5, r2
    sdiv r3, r0, r1
    ldr r4, =0
    add r9, r4, #0
    ldr r5, Addr0_1
    ldr r2, =4
    mul r1, r9, r2
    add r4, r5, r1
    ldr r9, [r4]
    mul r2, r3, r9
    sub r5, r7, r2
    str r5, [r6]
    Mov r1, r8
    b bb0_2
bb0_2:
    mov r0, r1
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
    ldr r1, =0
    add r2, r1, #0
    ldr r3, Addr1_0
    ldr r4, =4
    mul r5, r2, r4
    add r6, r3, r5
    ldr r7, =0
    add r8, r7, #0
    ldr r9, Addr1_0
    ldr r1, =4
    mul r4, r8, r1
    add r2, r9, r4
    ldr r5, [r2]
    ldr r3, =15
    sdiv r7, r5, r3
    ldr r1, =15
    mul r8, r7, r1
    sub r4, r5, r8
    add r9, r4, #15
    ldr r2, =15
    sdiv r3, r9, r2
    ldr r7, =15
    mul r1, r3, r7
    sub r5, r9, r1
    str r5, [r6]
    ldr r8, =0
    add r4, r8, #0
    ldr r2, Addr1_0
    ldr r3, =4
    mul r7, r4, r3
    add r9, r2, r7
    ldr r1, [r9]
    STM SP, {r0, r1}
    ldr r0, [sp, #4]
    bl put_int
    LDM sp, {r0, r1}
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

