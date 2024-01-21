    .arch armv8 
    .text 
    .globl inc_a
    .p2align 2
    .type inc_a, %function
inc_a:
    push {lr}
    sub sp, sp, #16
    ldr r0, Addr0_0
    ldr r0, [r0]
    add r1, r0, #2
    push {r0}
    ldr r0, Addr0_0
    str r1, [r0]
    pop {r0}
    ldr r2, Addr0_0
    ldr r2, [r2]
    sub r3, r2, #2
    b bb0_0
bb0_0:
    mov r0, r3
    add sp, sp, #16
    pop {lr}
    bx lr
    .pool
Addr0_0:
    .long ..a

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl inc_a
    ldr r1, Addr1_0
    ldr r1, [r1]
    sub r2, r0, r1
    ldr r3, Addr1_0
    ldr r3, [r3]
    STM SP, {r2, r3}
    bl inc_a
    LDM SP, {r2, r3}
    mov r4, r0
    sub r5, r3, r4
    cmp r2, r5
    ldr r6, =0
    ldrgt r6, =1
    cmp r2, r5
    bgt bb1_0
    b bb1_1
bb1_0:
    ldr r9, Addr1_0
    ldr r9, [r9]
    Mov r8, r9
    b bb1_2
bb1_1:
    bl inc_a
    mov r7, r0
    Mov r8, r7
    b bb1_2
bb1_2:
    mov r0, r8
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..a

    .type ..a, %object
    .data
    .globl ..a
    .p2align 2
..a:
    .long 1
    .size ..a, 4

