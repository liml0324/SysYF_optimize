    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    ldr r0, =10
    push {r1}
    ldr r1, Addr0_0
    str r0, [r1]
    pop {r1}
    ldr r1, =5
    push {r0}
    ldr r0, Addr0_1
    str r1, [r0]
    pop {r0}
    ldr r2, Addr0_0
    ldr r2, [r2]
    ldr r3, =2
    mul r4, r2, r3
    ldr r5, Addr0_1
    ldr r5, [r5]
    VCVT.F32.S32 r5, r5
    vmul r7, r6, #1.100000
    VCVT.F32.S32 r4, r4
    vadd r9, r8, r7
    vadd r0, r9, #3.600000
    VCVT.S32.F32 r0, r0
    b bb0_0
bb0_0:
    mov r0, r1
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr0_0:
    .long ..a
Addr0_1:
    .long ..b

    .type ..a, %object
    .bss
    .globl ..a
    .p2align 2
..a:
    .long 0
    .size ..a, 4

    .type ..b, %object
    .bss
    .globl ..b
    .p2align 2
..b:
    .long 0
    .size ..b, 4

