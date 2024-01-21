    .arch armv8 
    .text 
    .globl f
    .p2align 2
    .type f, %function
f:
    push {lr}
    sub sp, sp, #24
    mul r2, r0, r1
    b bb0_0
bb0_0:
    mov r0, r2
    add sp, sp, #24
    pop {lr}
    bx lr
    .pool

    .globl g
    .p2align 2
    .type g, %function
g:
    push {r4, r5, lr}
    sub sp, sp, #24
    sdiv r3, r0, r1
    mul r4, r3, r1
    sub r5, r0, r4
    b bb1_0
bb1_0:
    mov r0, r5
    add sp, sp, #24
    pop {r4, r5, lr}
    bx lr
    .pool

    .globl h
    .p2align 2
    .type h, %function
h:
    push {r4, r5, r6, r11, lr}
    mov r11, sp
    sub sp, sp, #44
    STM SP, {r0, r1, r2}
    ldr r0, [sp]
    ldr r1, [sp, #4]
    bl g
    LDMIB SP, {r1, r2}
    mov r2, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2, r3}
    ldr r0, =2
    ldr r1, [sp, #8]
    bl f
    LDMIB SP, {r1, r2, r3}
    mov r3, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r3}
    ldr r0, [sp]
    ldr r1, [sp, #4]
    bl f
    LDMIB SP, {r1, r3}
    mov r4, r0
    ldr r0, [SP]
    STM SP, {r3}
    mov r0, r4
    ldr r1, =4
    bl g
    LDM SP, {r3}
    mov r5, r0
    STM SP, {r3}
    ldr r0, [sp]
    mov r1, r5
    bl f
    LDM SP, {r3}
    mov r6, r0
    b bb2_0
bb2_0:
    mov r0, r6
    mov sp, r11
    pop {r4, r5, r6, r11, lr}
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
    ldr r0, =11
    ldr r1, =3
    bl h
    STM SP, {r0}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r0}
    b bb3_0
bb3_0:
    ldr r0, =0
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

