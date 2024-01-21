    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {lr}
    sub sp, sp, #16
    b bb0_0
bb0_0:
    ldr r0, =21
    add sp, sp, #16
    pop {lr}
    bx lr
    .pool

