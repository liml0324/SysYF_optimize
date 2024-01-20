    .arch armv8 
    .text 
    .globl fsqrt
    .p2align 2
    .type fsqrt, %function
fsqrt:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    ldr r1, =2
    sdiv r2, r0, r1
    Mov r3, r2
    Ldr r4, =0
    b bb0_0
bb0_0:
    sub r5, r4, r3
    ldr r6, =0
    cmp r5, r6
    ldr r7, =0
    ldrne r7, =1
    ldr r8, =0
    cmp r5, r8
    bne bb0_1
    b bb0_2
bb0_1:
    sdiv r9, r0, r3
    add r1, r3, r9
    ldr r2, =2
    sdiv r4, r1, r2
    Mov r10, r4
    Mov r4, r3
    Mov r3, r10
    b bb0_0
bb0_2:
    b bb0_3
bb0_3:
    mov r0, r3
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    ldr r0, =400
    bl fsqrt
    STM SP, {r0}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r0}
    ldr r0, =10
    bl put_char
    b bb1_0
bb1_0:
    ldr r0, =0
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

