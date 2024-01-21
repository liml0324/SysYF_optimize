    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    ldr r0, =0
    push {r1}
    ldr r1, Addr0_1
    str r0, [r1]
    pop {r1}
    ldr r1, =3
    push {r0}
    ldr r0, Addr0_0
    str r1, [r0]
    pop {r0}
    b bb0_0
bb0_0:
    ldr r2, Addr0_0
    ldr r2, [r2]
    ldr r3, =0
    cmp r2, r3
    ldr r4, =0
    ldrgt r4, =1
    ldr r5, =0
    cmp r2, r5
    bgt bb0_1
    b bb0_2
bb0_1:
    ldr r7, Addr0_1
    ldr r7, [r7]
    ldr r8, Addr0_0
    ldr r8, [r8]
    add r9, r7, r8
    push {r0}
    ldr r0, Addr0_1
    str r9, [r0]
    pop {r0}
    ldr r0, Addr0_0
    ldr r0, [r0]
    sub r1, r0, #1
    push {r0}
    ldr r0, Addr0_0
    str r1, [r0]
    pop {r0}
    b bb0_0
bb0_2:
    ldr r6, Addr0_1
    ldr r6, [r6]
    b bb0_3
bb0_3:
    mov r0, r6
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

