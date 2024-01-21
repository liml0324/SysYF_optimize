    .arch armv8 
    .text 
    .globl climbStairs
    .p2align 2
    .type climbStairs, %function
climbStairs:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #60
    ldr r1, =4
    cmp r0, r1
    ldr r2, =0
    ldrlt r2, =1
    ldr r3, =4
    cmp r0, r3
    blt bb0_0
    b bb0_1
bb0_0:
    Mov r6, r0
    b bb0_5
bb0_1:
    add r4, sp, #16
    ldr r5, =0
    ldr r6, =4
    mul r7, r5, r6
    add r8, r4, r7
    ldr r9, =0
    str r9, [r8]
    add r1, sp, #16
    ldr r2, =1
    ldr r3, =4
    mul r5, r2, r3
    add r6, r1, r5
    ldr r4, =1
    str r4, [r6]
    add r7, sp, #16
    ldr r8, =2
    ldr r9, =4
    mul r2, r8, r9
    add r3, r7, r2
    ldr r1, =2
    str r1, [r3]
    Ldr r5, =3
    b bb0_2
bb0_2:
    add r6, r0, #1
    cmp r5, r6
    ldr r4, =0
    ldrlt r4, =1
    cmp r5, r6
    blt bb0_3
    b bb0_4
bb0_3:
    add r4, r5, #0
    add r8, sp, #16
    ldr r7, =4
    mul r9, r4, r7
    add r2, r8, r9
    sub r3, r5, #1
    add r1, r3, #0
    add r6, sp, #16
    ldr r4, =4
    mul r7, r1, r4
    add r8, r6, r7
    ldr r9, [r8]
    sub r3, r5, #2
    add r1, r3, #0
    add r4, sp, #16
    ldr r6, =4
    mul r7, r1, r6
    add r8, r4, r7
    ldr r3, [r8]
    add r1, r9, r3
    str r1, [r2]
    add r6, r5, #1
    Mov r5, r6
    b bb0_2
bb0_4:
    add r8, r0, #0
    add r9, sp, #16
    ldr r7, =4
    mul r2, r8, r7
    add r3, r9, r2
    ldr r1, [r3]
    Mov r6, r1
    b bb0_5
bb0_5:
    mov r0, r6
    add sp, sp, #60
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
    ldr r0, =5
    bl climbStairs
    b bb1_0
bb1_0:
    b litpool1_0
    .pool
litpool1_0:
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

