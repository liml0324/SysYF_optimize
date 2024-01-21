    .arch armv8 
    .text 
    .globl climbStairs
    .p2align 2
    .type climbStairs, %function
climbStairs:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #56
    ldr r1, =4
    cmp r0, r1
    ldr r2, =0
    ldrlt r2, =1
    ldr r3, =4
    cmp r0, r3
    blt bb0_0
    b bb0_1
bb0_0:
    Mov r8, r0
    b bb0_5
bb0_1:
    ldr r4, =0
    add r5, r4, #0
    add r6, sp, #4
    ldr r7, =4
    mul r8, r5, r7
    add r9, r6, r8
    ldr r1, =0
    str r1, [r9]
    ldr r2, =0
    add r3, r2, #1
    add r4, sp, #4
    ldr r5, =4
    mul r7, r3, r5
    add r6, r4, r7
    ldr r8, =1
    str r8, [r6]
    ldr r9, =0
    add r1, r9, #2
    add r2, sp, #4
    ldr r3, =4
    mul r5, r1, r3
    add r4, r2, r5
    ldr r7, =2
    str r7, [r4]
    Ldr r6, =3
    b bb0_2
bb0_2:
    add r8, r0, #1
    cmp r6, r8
    ldr r9, =0
    ldrlt r9, =1
    cmp r6, r8
    blt bb0_3
    b bb0_4
bb0_3:
    add r1, r6, #0
    add r2, sp, #4
    ldr r3, =4
    mul r5, r1, r3
    add r4, r2, r5
    sub r7, r6, #1
    add r8, r7, #0
    add r9, sp, #4
    ldr r1, =4
    mul r3, r8, r1
    add r2, r9, r3
    ldr r5, [r2]
    sub r7, r6, #2
    add r8, r7, #0
    add r1, sp, #4
    ldr r9, =4
    mul r3, r8, r9
    add r2, r1, r3
    ldr r7, [r2]
    add r8, r5, r7
    str r8, [r4]
    add r9, r6, #1
    Mov r6, r9
    b bb0_2
bb0_4:
    add r1, r0, #0
    add r3, sp, #4
    ldr r2, =4
    mul r5, r1, r2
    add r4, r3, r5
    ldr r7, [r4]
    Mov r8, r7
    Mov r9, r6
    b bb0_5
bb0_5:
    b litpool0_0
    .pool
litpool0_0:
    mov r0, r8
    add sp, sp, #56
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
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

