    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    b bb0_0
bb0_0:
    ldr r0, Addr0_1
    ldr r0, [r0]
    ldr r1, Addr0_1
    ldr r1, [r1]
    add r2, r1, #0
    ldr r3, Addr0_0
    ldr r4, =4
    mul r5, r2, r4
    add r6, r3, r5
    ldr r7, [r6]
    cmp r0, r7
    ldr r8, =0
    ldrlt r8, =1
    cmp r0, r7
    blt bb0_1
    b bb0_2
bb0_1:
    ldr r9, Addr0_1
    ldr r9, [r9]
    add r1, r9, #0
    ldr r4, Addr0_0
    ldr r2, =4
    mul r5, r1, r2
    add r3, r4, r5
    ldr r6, [r3]
    push {r0}
    ldr r0, Addr0_1
    str r6, [r0]
    pop {r0}
    ldr r0, Addr0_1
    ldr r0, [r0]
    ldr r7, Addr0_1
    ldr r7, [r7]
    add r8, r7, #0
    ldr r9, Addr0_0
    ldr r1, =4
    mul r2, r8, r1
    add r4, r9, r2
    ldr r5, [r4]
    add r3, r0, r5
    sub r6, r3, #1
    add r7, r6, #0
    ldr r8, Addr0_0
    ldr r1, =4
    mul r9, r7, r1
    add r2, r8, r9
    ldr r4, [r2]
    ldr r0, Addr0_1
    ldr r0, [r0]
    add r5, r0, #0
    ldr r3, Addr0_0
    ldr r6, =4
    mul r7, r5, r6
    add r1, r3, r7
    ldr r8, [r1]
    VCVT.F32.S32 r8, r8
    fsub r2, r9, #1
    VCVT.F32.S32 r4, r4
    fcmp r0, r2
    ldr r5, =0
    ldrgt r5, =1
    fcmp r0, r2
    bgt bb0_3
    b bb0_4
bb0_2:
    b bb0_5
bb0_3:
    b bb0_0
bb0_4:
    b bb0_0
bb0_5:
    b litpool0_0
    .pool
litpool0_0:
    ldr r0, =0
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

