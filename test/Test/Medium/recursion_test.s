    .arch armv8 
    .text 
    .globl fact
    .p2align 2
    .type fact, %function
fact:
    push {r4, r5, r6, r7, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldreq r2, =1
    ldr r3, =0
    cmp r0, r3
    beq bb0_0
    b bb0_1
bb0_0:
    Ldr r7, =1
    b bb0_2
bb0_1:
    sub r4, r0, #1
    STM SP, {r0}
    mov r0, r4
    bl fact
    mov r5, r0
    ldr r0, [SP]
    mul r6, r0, r5
    Mov r7, r6
    b bb0_2
bb0_2:
    mov r0, r7
    mov sp, r11
    pop {r4, r5, r6, r7, r11, lr}
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
    ldr r0, =4
    bl fact
    b bb1_0
bb1_0:
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

