    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, lr}
    sub sp, sp, #16
    ldr r0, =0
    add r1, r0, #0
    ldr r2, Addr0_0
    ldr r3, =4
    mul r4, r1, r3
    add r5, r2, r4
    ldr r6, =1
    str r6, [r5]
    b bb0_0
bb0_0:
    ldr r0, =0
    add sp, sp, #16
    pop {r4, r5, r6, lr}
    bx lr
    .pool
Addr0_0:
    .long ..a

    .type ..a, %object
    .comm ..a, 40, 4

