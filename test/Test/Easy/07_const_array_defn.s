    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {lr}
    sub sp, sp, #16
    ldr r0, Addr0_0
    ldr r0, [r0]
    b bb0_0
bb0_0:
    mov r0, r2
    add sp, sp, #16
    pop {lr}
    bx lr
    .pool
Addr0_0:
    .long ..c

    .type ..a, %object
    .section .rodata,"a", %progbits
    .globl ..a
    .p2align 2
..a:
    .long 
    .long 
    .long 
    .long 
    .long 
    .size ..a, 20

    .type ..b, %object
    .section .rodata,"a", %progbits
    .globl ..b
    .p2align 2
..b:
    .long 3
    .size ..b, 4

    .type ..c, %object
    .data
    .globl ..c
    .p2align 2
..c:
    .long 4.000000
    .size ..c, 4

