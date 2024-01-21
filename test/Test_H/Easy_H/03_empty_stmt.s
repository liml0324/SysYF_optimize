    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {lr}
    sub sp, sp, #16
    ldr r0, =10
    ldr r1, =2
    mul r2, r0, r1
    add r3, r2, #1
    b bb0_0
bb0_0:
    mov r0, r3
    add sp, sp, #16
    pop {lr}
    bx lr
    .pool

