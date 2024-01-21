    .arch armv8 
    .text 
    .globl whileIf
    .p2align 2
    .type whileIf, %function
whileIf:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    Ldr r0, =0
    Ldr r1, =0
    b bb0_0
bb0_0:
    ldr r2, =100
    cmp r1, r2
    ldr r3, =0
    ldrlt r3, =1
    ldr r4, =100
    cmp r1, r4
    blt bb0_1
    b bb0_2
bb0_1:
    ldr r5, =5
    cmp r1, r5
    ldr r6, =0
    ldreq r6, =1
    ldr r7, =5
    cmp r1, r7
    beq bb0_3
    b bb0_4
bb0_2:
    b bb0_9
bb0_3:
    Ldr r5, =25
    b bb0_5
bb0_4:
    ldr r8, =10
    cmp r1, r8
    ldr r9, =0
    ldreq r9, =1
    ldr r2, =10
    cmp r1, r2
    beq bb0_6
    b bb0_7
bb0_5:
    add r7, r1, #1
    Mov r0, r5
    Mov r1, r7
    b bb0_0
bb0_6:
    Ldr r0, =42
    b bb0_8
bb0_7:
    b litpool0_0
    .pool
litpool0_0:
    ldr r4, =2
    mul r3, r1, r4
    Mov r0, r3
    b bb0_8
bb0_8:
    Mov r5, r0
    b bb0_5
bb0_9:
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
    bl whileIf
    b bb1_0
bb1_0:
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

