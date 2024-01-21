    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    Ldr r0, =0
    Ldr r1, =0
    b bb0_0
bb0_0:
    ldr r2, =6
    cmp r1, r2
    ldr r3, =0
    ldrlt r3, =1
    ldr r4, =6
    cmp r1, r4
    blt bb0_1
    b bb0_2
bb0_1:
    add r5, r1, #0
    ldr r6, Addr0_0
    ldr r7, =4
    mul r8, r5, r7
    add r9, r6, r8
    ldr r2, [r9]
    add r4, r0, r2
    add r3, r1, #1
    Mov r0, r4
    Mov r1, r3
    b bb0_0
bb0_2:
    b bb0_3
bb0_3:
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr0_0:
    .long ..arr

    .type ..N, %object
    .section .rodata,"a", %progbits
    .globl ..N
    .p2align 2
..N:
    .long -1
    .size ..N, 4

    .type ..arr, %object
    .data
    .globl ..arr
    .p2align 2
..arr:
    .long 
    .long 
    .long 
    .long 
    .long 
    .long 
    .size ..arr, 24

