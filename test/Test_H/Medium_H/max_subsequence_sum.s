    .arch armv8 
    .text 
    .globl maxSubArray
    .p2align 2
    .type maxSubArray, %function
maxSubArray:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    ldr r2, =0
    cmp r1, r2
    ldr r3, =0
    ldreq r3, =1
    ldr r4, =0
    cmp r1, r4
    beq bb0_0
    b bb0_1
bb0_0:
    Ldr r8, =0
    b bb0_11
bb0_1:
    ldr r5, =1
    cmp r1, r5
    ldr r6, =0
    ldreq r6, =1
    ldr r7, =1
    cmp r1, r7
    beq bb0_2
    b bb0_3
bb0_2:
    add r8, r0, #0
    ldr r2, =0
    ldr r3, =4
    mul r5, r2, r3
    add r9, r8, r5
    ldr r4, [r9]
    Mov r8, r4
    b bb0_11
bb0_3:
    add r8, r0, #0
    ldr r9, =0
    ldr r2, =4
    mul r3, r9, r2
    add r4, r8, r3
    ldr r5, [r4]
    Ldr r6, =1
    Mov r7, r5
    Mov r9, r5
    b bb0_4
bb0_4:
    cmp r6, r1
    ldr r2, =0
    ldrlt r2, =1
    cmp r6, r1
    blt bb0_5
    b bb0_6
bb0_5:
    ldr r3, =0
    cmp r9, r3
    ldr r4, =0
    ldrlt r4, =1
    ldr r5, =0
    cmp r9, r5
    blt bb0_7
    Mov r2, r9
    b bb0_8
bb0_6:
    b litpool0_0
    .pool
litpool0_0:
    Mov r8, r7
    b bb0_11
bb0_7:
    Ldr r2, =0
    b bb0_8
bb0_8:
    add r8, r6, #0
    add r3, r0, #0
    ldr r4, =4
    mul r9, r8, r4
    add r5, r3, r9
    ldr r8, [r5]
    add r4, r2, r8
    cmp r7, r4
    ldr r3, =0
    ldrlt r3, =1
    cmp r7, r4
    blt bb0_9
    Mov r9, r7
    b bb0_10
bb0_9:
    Mov r9, r4
    b bb0_10
bb0_10:
    add r5, r6, #1
    Mov r6, r5
    Mov r7, r9
    Mov r9, r4
    b bb0_4
bb0_11:
    mov r0, r8
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #76
    add r0, sp, #4
    ldr r1, =0
    ldr r2, =4
    mul r3, r1, r2
    add r4, r0, r3
    ldr r5, =-4
    str r5, [r4]
    add r6, sp, #4
    ldr r7, =1
    ldr r8, =4
    mul r9, r7, r8
    add r1, r6, r9
    ldr r2, =3
    str r2, [r1]
    add r3, sp, #4
    ldr r0, =2
    ldr r4, =4
    mul r5, r0, r4
    add r7, r3, r5
    ldr r8, =9
    str r8, [r7]
    add r9, sp, #4
    ldr r6, =3
    ldr r1, =4
    mul r2, r6, r1
    add r0, r9, r2
    ldr r4, =-2
    str r4, [r0]
    add r5, sp, #4
    ldr r3, =4
    ldr r7, =4
    mul r8, r3, r7
    add r6, r5, r8
    ldr r1, =0
    str r1, [r6]
    add r9, sp, #4
    ldr r2, =5
    ldr r0, =4
    mul r4, r2, r0
    add r3, r9, r4
    ldr r7, =1
    str r7, [r3]
    add r5, sp, #4
    ldr r8, =6
    ldr r6, =4
    mul r1, r8, r6
    add r2, r5, r1
    ldr r0, =-6
    str r0, [r2]
    add r9, sp, #4
    ldr r4, =7
    ldr r3, =4
    mul r7, r4, r3
    add r8, r9, r7
    ldr r6, =5
    str r6, [r8]
    add r5, sp, #4
    ldr r1, =8
    ldr r2, =4
    mul r0, r1, r2
    add r4, r5, r0
    ldr r3, =7
    str r3, [r4]
    add r9, sp, #4
    ldr r7, =9
    ldr r8, =4
    mul r6, r7, r8
    add r1, r9, r6
    ldr r2, =8
    str r2, [r1]
    add r5, sp, #4
    ldr r0, =0
    ldr r4, =4
    mul r3, r0, r4
    add r7, r5, r3
    mov r0, r7
    ldr r1, =10
    bl maxSubArray
    mov r8, r0
    b bb1_0
bb1_0:
    mov r0, r8
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

