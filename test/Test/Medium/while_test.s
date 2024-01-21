    .arch armv8 
    .text 
    .globl FourWhile
    .p2align 2
    .type FourWhile, %function
FourWhile:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    Ldr r0, =10
    Ldr r1, =7
    Ldr r2, =6
    Ldr r3, =5
    b bb0_0
bb0_0:
    ldr r4, =20
    cmp r3, r4
    ldr r5, =0
    ldrlt r5, =1
    ldr r6, =20
    cmp r3, r6
    blt bb0_1
    b bb0_2
bb0_1:
    add r4, r3, #3
    Mov r5, r1
    Mov r6, r0
    Mov r7, r2
    b bb0_3
bb0_2:
    add r7, r2, r0
    add r8, r3, r7
    add r9, r8, r1
    b bb0_12
bb0_3:
    ldr r8, =10
    cmp r7, r8
    ldr r9, =0
    ldrlt r9, =1
    ldr r3, =10
    cmp r7, r3
    blt bb0_4
    b bb0_5
bb0_4:
    add r1, r7, #1
    Mov r2, r6
    Mov r8, r5
    b bb0_6
bb0_5:
    sub r0, r7, #2
    Mov r1, r5
    Mov r2, r0
    Mov r0, r6
    Mov r3, r4
    b bb0_0
bb0_6:
    ldr r9, =7
    cmp r8, r9
    ldr r3, =0
    ldreq r3, =1
    ldr r0, =7
    cmp r8, r0
    beq bb0_7
    b bb0_8
bb0_7:
    b litpool0_0
    .pool
litpool0_0:
    sub r6, r8, #1
    Mov r5, r2
    b bb0_9
bb0_8:
    add r7, r8, #1
    Mov r5, r7
    Mov r6, r2
    Mov r7, r1
    b bb0_3
bb0_9:
    ldr r9, =20
    cmp r5, r9
    ldr r3, =0
    ldrlt r3, =1
    ldr r0, =20
    cmp r5, r0
    blt bb0_10
    b bb0_11
bb0_10:
    add r8, r5, #3
    Mov r5, r8
    b bb0_9
bb0_11:
    sub r7, r5, #1
    Mov r2, r7
    Mov r8, r6
    b bb0_6
bb0_12:
    mov r0, r9
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
    bl FourWhile
    b bb1_0
bb1_0:
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

