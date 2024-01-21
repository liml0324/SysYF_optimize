    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, lr}
    sub sp, sp, #16
    ldr r0, =10
    push {r1}
    ldr r1, Addr0_0
    str r0, [r1]
    pop {r1}
    ldr r1, Addr0_0
    ldr r1, [r1]
    ldr r2, =0
    cmp r1, r2
    ldr r3, =0
    ldrgt r3, =1
    ldr r4, =0
    cmp r1, r4
    bgt bb0_0
    b bb0_1
bb0_0:
    Ldr r5, =1
    b bb0_2
bb0_1:
    Ldr r5, =0
    b bb0_2
bb0_2:
    mov r0, r5
    add sp, sp, #16
    pop {r4, r5, lr}
    bx lr
    .pool
Addr0_0:
    .long ..a

    .type ..a, %object
    .bss
    .globl ..a
    .p2align 2
..a:
    .long 0
    .size ..a, 4

