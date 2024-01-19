    .arch armv8 
    .text 
    .globl inc_a
    .p2align 2
    .type inc_a, %function
inc_a:
    push {lr}
    sub sp, sp, #16
    ldr r0, Addr0_0
    ldr r0, [r0]
    add r1, r0, #1
    push {r0}
    ldr r0, Addr0_0
    str r1, [r0]
    pop {r0}
    ldr r2, Addr0_0
    ldr r2, [r2]
    sub r3, r2, #1
    b bb0_0
bb0_0:
    mov r0, r3
    add sp, sp, #16
    pop {lr}
    bx lr
    .pool
Addr0_0:
    .long ..a

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl inc_a
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldrne r2, =1
    ldr r3, =0
    cmp r0, r3
    bne bb1_0
    b bb1_1
bb1_0:
    b bb1_1
bb1_1:
    ldr r4, Addr1_0
    ldr r4, [r4]
    b bb1_2
bb1_2:
    mov r0, r4
    mov sp, r11
    pop {r4, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..a

    .type ..a, %object
    .bss
    .globl ..a
    .p2align 2
..a:
    .long 0
    .size ..a, 4

