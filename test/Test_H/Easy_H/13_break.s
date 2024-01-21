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
    Mov r4, r0
    b bb0_2
bb0_1:
    sub r5, r0, #1
    ldr r6, =5
    cmp r5, r6
    ldr r7, =0
    ldreq r7, =1
    ldr r8, =5
    cmp r5, r8
    beq bb0_3
    b bb0_4
bb0_2:
    b bb0_5
bb0_3:
    Mov r4, r5
    b bb0_2
bb0_4:
    Mov r0, r5
    b bb0_0
bb0_5:
    mov r0, r4
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, lr}
    bx lr
    .pool

