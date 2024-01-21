    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, lr}
    sub sp, sp, #16
    Ldr r0, =10
    b bb0_0
bb0_0:
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldrgt r2, =1
    ldr r3, =0
    cmp r0, r3
    bgt bb0_1
    b bb0_2
bb0_1:
    ldr r5, =5
    cmp r0, r5
    ldr r6, =0
    ldrgt r6, =1
    ldr r7, =5
    cmp r0, r7
    bgt bb0_3
    b bb0_4
bb0_2:
    Mov r4, r0
    b bb0_5
bb0_3:
    sub r8, r0, #1
    Mov r0, r8
    b bb0_0
bb0_4:
    Mov r4, r0
    b bb0_5
bb0_5:
    mov r0, r4
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, lr}
    bx lr
    .pool

