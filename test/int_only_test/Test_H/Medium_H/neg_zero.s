    .arch armv8 
    .text 
    .globl inc
    .p2align 2
    .type inc, %function
inc:
    push {lr}
    sub sp, sp, #20
    add r1, r0, #1
    b bb0_0
bb0_0:
    mov r0, r1
    add sp, sp, #20
    pop {lr}
    bx lr
    .pool

    .globl zero
    .p2align 2
    .type zero, %function
zero:
    push {lr}
    sub sp, sp, #16
    b bb1_0
bb1_0:
    ldr r0, =0
    add sp, sp, #16
    pop {lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl zero
    rsb r1, r0, #0
    ldr r2, =0
    cmp r1, r2
    ldr r3, =0
    ldrne r3, =1
    ldr r4, =0
    cmp r1, r4
    bne bb2_0
    b bb2_1
bb2_0:
    bl zero
    mov r8, r0
    Mov r7, r8
    b bb2_2
bb2_1:
    bl zero
    mov r5, r0
    mov r0, r5
    bl inc
    mov r6, r0
    Mov r7, r6
    b bb2_2
bb2_2:
    mov r0, r7
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r11, lr}
    bx lr
    .pool

