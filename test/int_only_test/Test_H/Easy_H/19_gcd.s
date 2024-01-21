    .arch armv8 
    .text 
    .globl gcd
    .p2align 2
    .type gcd, %function
gcd:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #24
    cmp r0, r1
    ldr r2, =0
    ldrlt r2, =1
    cmp r0, r1
    blt bb0_0
    Mov r4, r1
    Mov r5, r0
    b bb0_1
bb0_0:
    Mov r4, r0
    Mov r5, r1
    b bb0_1
bb0_1:
    sdiv r6, r5, r4
    mul r7, r6, r4
    sub r8, r5, r7
    Mov r2, r4
    Mov r9, r8
    b bb0_2
bb0_2:
    ldr r6, =0
    cmp r9, r6
    ldr r7, =0
    ldrne r7, =1
    ldr r3, =0
    cmp r9, r3
    bne bb0_3
    b bb0_4
bb0_3:
    sdiv r5, r2, r9
    mul r8, r5, r9
    sub r6, r2, r8
    Mov r2, r9
    Mov r9, r6
    b bb0_2
bb0_4:
    b bb0_5
bb0_5:
    mov r0, r2
    add sp, sp, #24
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl get_int
    STM SP, {r0, r1}
    bl get_int
    LDMIB SP, {r1}
    mov r1, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2}
    ldr r0, [sp]
    ldr r1, [sp, #4]
    bl gcd
    LDMIB SP, {r1, r2}
    mov r2, r0
    ldr r0, [SP]
    b bb1_0
bb1_0:
    mov r0, r2
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

    .type ..n, %object
    .bss
    .globl ..n
    .p2align 2
..n:
    .long 0
    .size ..n, 4

