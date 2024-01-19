    .arch armv8 
    .text 
    .globl enc
    .p2align 2
    .type enc, %function
enc:
    push {r4, r5, r6, lr}
    sub sp, sp, #16
    ldr r1, =25
    cmp r0, r1
    ldr r2, =0
    ldrgt r2, =1
    ldr r3, =25
    cmp r0, r3
    bgt bb0_0
    b bb0_1
bb0_0:
    add r6, r0, #60
    Mov r5, r6
    b bb0_2
bb0_1:
    sub r4, r0, #15
    Mov r5, r4
    b bb0_2
bb0_2:
    b bb0_3
bb0_3:
    mov r0, r5
    add sp, sp, #16
    pop {r4, r5, r6, lr}
    bx lr
    .pool

    .globl dec
    .p2align 2
    .type dec, %function
dec:
    push {r4, r5, r6, lr}
    sub sp, sp, #16
    ldr r1, =85
    cmp r0, r1
    ldr r2, =0
    ldrgt r2, =1
    ldr r3, =85
    cmp r0, r3
    bgt bb1_0
    b bb1_1
bb1_0:
    sub r6, r0, #59
    Mov r5, r6
    b bb1_2
bb1_1:
    add r4, r0, #14
    Mov r5, r4
    b bb1_2
bb1_2:
    b litpool1_0
    .pool
litpool1_0:
    b bb1_3
bb1_3:
    mov r0, r5
    add sp, sp, #16
    pop {r4, r5, r6, lr}
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
    bl enc
    STM SP, {r0, r1}
    ldr r0, [sp]
    bl dec
    LDMIB SP, {r1}
    mov r1, r0
    ldr r0, [SP]
    STM SP, {r1}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r1}
    ldr r0, =10
    bl put_char
    b bb2_0
bb2_0:
    ldr r0, =0
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

