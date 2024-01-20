    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    ldr lr, =436
    sub sp, sp, lr
    Ldr r0, =0
    b bb0_0
bb0_0:
    STM SP, {r0, r1}
    bl get_int
    LDMIB SP, {r1}
    mov r1, r0
    ldr r0, [SP]
    ldr r2, =0
    cmp r1, r2
    ldr r3, =0
    ldrne r3, =1
    ldr r4, =0
    cmp r1, r4
    bne bb0_1
    b bb0_2
bb0_1:
    add r4, r0, #0
    add r3, sp, #4
    ldr r1, =4
    mul r7, r4, r1
    add r2, r3, r7
    STM SP, {r0, r2}
    bl get_int
    LDMIB SP, {r2}
    mov r8, r0
    ldr r0, [SP]
    str r8, [r2]
    add r5, r0, #1
    Mov r0, r5
    b bb0_0
bb0_2:
    Ldr r5, =0
    Mov r6, r0
    b bb0_3
bb0_3:
    ldr r7, =0
    cmp r6, r7
    ldr r8, =0
    ldrne r8, =1
    ldr r9, =0
    cmp r6, r9
    bne bb0_4
    b bb0_5
bb0_4:
    sub r9, r6, #1
    add r4, r9, #0
    add r1, sp, #4
    ldr r3, =4
    mul r7, r4, r3
    add r2, r1, r7
    ldr r8, [r2]
    add r6, r5, r8
    Mov r5, r6
    Mov r6, r9
    b bb0_3
bb0_5:
    ldr r4, =79
    sdiv r1, r5, r4
    ldr r3, =79
    mul r7, r1, r3
    sub r8, r5, r7
    b bb0_6
bb0_6:
    b litpool0_0
    .pool
litpool0_0:
    mov r0, r8
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

