    .arch armv8 
    .text 
    .globl my_sum
    .p2align 2
    .type my_sum, %function
my_sum:
    push {r4, lr}
    sub sp, sp, #24
    add r2, r0, #5
    sub r3, r2, r1
    push {r0}
    ldr r0, Addr0_0
    str r3, [r0]
    pop {r0}
    ldr r4, Addr0_0
    ldr r4, [r4]
    b bb0_0
bb0_0:
    mov r0, r4
    add sp, sp, #24
    pop {r4, lr}
    bx lr
    .pool
Addr0_0:
    .long ..b

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    ldr r0, =3
    ldr r1, =3
    bl my_sum
    ldr r1, Addr1_0
    ldr r1, [r1]
    STM SP, {r0, r1, r2}
    ldr r0, =7
    ldr r1, [sp, #4]
    bl my_sum
    LDMIB SP, {r1, r2}
    mov r2, r0
    ldr r0, [SP]
    ldr r3, Addr1_0
    ldr r3, [r3]
    b bb1_0
bb1_0:
    mov r0, r3
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..b

    .type ..a, %object
    .section .rodata,"a", %progbits
    .globl ..a
    .p2align 2
..a:
    .long 5
    .size ..a, 4

    .type ..b, %object
    .bss
    .globl ..b
    .p2align 2
..b:
    .long 0
    .size ..b, 4

