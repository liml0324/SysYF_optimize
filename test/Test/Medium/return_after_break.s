    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    Ldr r0, =0
    b bb0_0
bb0_0:
    ldr r1, Addr0_1
    ldr r1, [r1]
    ldr r2, Addr0_1
    ldr r2, [r2]
    add r3, r2, #0
    ldr r4, Addr0_0
    ldr r5, =4
    mul r6, r3, r5
    add r7, r4, r6
    ldr r8, [r7]
    cmp r1, r8
    ldr r9, =0
    ldrlt r9, =1
    cmp r1, r8
    blt bb0_1
    b bb0_2
bb0_1:
    ldr r2, Addr0_1
    ldr r2, [r2]
    add r5, r2, #0
    ldr r3, Addr0_0
    ldr r6, =4
    mul r4, r5, r6
    add r7, r3, r4
    ldr r1, [r7]
    push {r0}
    ldr r0, Addr0_1
    str r1, [r0]
    pop {r0}
    ldr r8, Addr0_1
    ldr r8, [r8]
    ldr r9, Addr0_1
    ldr r9, [r9]
    add r2, r9, #0
    ldr r5, Addr0_0
    ldr r6, =4
    mul r3, r2, r6
    add r4, r5, r3
    ldr r7, [r4]
    add r1, r8, r7
    sub r9, r1, #1
    add r2, r9, #0
    ldr r6, Addr0_0
    ldr r5, =4
    mul r3, r2, r5
    add r4, r6, r3
    ldr r8, [r4]
    ldr r7, Addr0_1
    ldr r7, [r7]
    add r1, r7, #0
    ldr r9, Addr0_0
    ldr r2, =4
    mul r5, r1, r2
    add r6, r9, r5
    ldr r3, [r6]
    fcmp r1, r7
    bgt bb0_3
    b bb0_4
bb0_2:
    b bb0_6
bb0_3:
    add r9, r0, #0
    ldr r5, Addr0_0
    ldr r6, =4
    mul r3, r9, r6
    add r4, r5, r3
    ldr r8, [r4]
    add r7, r8, #1
    b bb0_5
bb0_4:
    b bb0_2
bb0_5:
    b litpool0_0
    .pool
litpool0_0:
    Mov r0, r7
    b bb0_0
bb0_6:
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr0_0:
    .long ..arr
Addr0_1:
    .long ..a

    .type ..arr, %object
    .section .rodata,"a", %progbits
    .globl ..arr
    .p2align 2
..arr:
    .long 
    .long 
    .long 
    .long 
    .long 
    .size ..arr, 20

    .type ..a, %object
    .bss
    .globl ..a
    .p2align 2
..a:
    .long 0
    .size ..a, 4

