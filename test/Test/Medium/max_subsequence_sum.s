    .arch armv8 
    .text 
    .globl maxSubArray
    .p2align 2
    .type maxSubArray, %function
maxSubArray:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldreq r2, =1
    ldr r3, =0
    cmp r0, r3
    beq bb0_0
    b bb0_1
bb0_0:
    Ldr r1, =0
    b bb0_11
bb0_1:
    ldr r4, =1
    cmp r0, r4
    ldr r5, =0
    ldreq r5, =1
    ldr r6, =1
    cmp r0, r6
    beq bb0_2
    b bb0_3
bb0_2:
    ldr r7, =0
    add r1, r7, #0
    ldr r9, Addr0_0
    ldr r4, =4
    mul r8, r1, r4
    add r3, r9, r8
    ldr r2, [r3]
    Mov r1, r2
    b bb0_11
bb0_3:
    ldr r7, =0
    add r8, r7, #0
    ldr r9, Addr0_0
    ldr r1, =4
    mul r2, r8, r1
    add r3, r9, r2
    ldr r4, [r3]
    Mov r5, r4
    Ldr r6, =1
    Mov r7, r4
    b bb0_4
bb0_4:
    cmp r6, r0
    ldr r8, =0
    ldrlt r8, =1
    cmp r6, r0
    blt bb0_5
    b bb0_6
bb0_5:
    ldr r4, =0
    cmp r7, r4
    ldr r8, =0
    ldrlt r8, =1
    ldr r1, =0
    cmp r7, r1
    blt bb0_7
    Mov r9, r7
    b bb0_8
bb0_6:
    b litpool0_0
    .pool
litpool0_0:
    Mov r1, r5
    Mov r2, r5
    Mov r3, r7
    Mov r9, r6
    b bb0_11
bb0_7:
    Ldr r9, =0
    b bb0_8
bb0_8:
    add r2, r6, #0
    ldr r3, Addr0_0
    ldr r4, =4
    mul r8, r2, r4
    add r7, r3, r8
    ldr r1, [r7]
    add r2, r9, r1
    cmp r5, r2
    ldr r4, =0
    ldrlt r4, =1
    cmp r5, r2
    blt bb0_9
    Mov r3, r5
    b bb0_10
bb0_9:
    Mov r3, r2
    b bb0_10
bb0_10:
    add r8, r6, #1
    Mov r5, r3
    Mov r6, r8
    Mov r7, r2
    b bb0_4
bb0_11:
    mov r0, r1
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr0_0:
    .long ..nums

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =0
    add r1, r0, #0
    ldr r2, Addr1_0
    ldr r3, =4
    mul r4, r1, r3
    add r5, r2, r4
    ldr r6, =-4
    str r6, [r5]
    ldr r7, =0
    add r8, r7, #1
    ldr r9, Addr1_0
    ldr r0, =4
    mul r1, r8, r0
    add r3, r9, r1
    ldr r4, =3
    str r4, [r3]
    ldr r2, =0
    add r5, r2, #2
    ldr r6, Addr1_0
    ldr r7, =4
    mul r0, r5, r7
    add r8, r6, r0
    ldr r1, =9
    str r1, [r8]
    ldr r9, =0
    add r3, r9, #3
    ldr r4, Addr1_0
    ldr r2, =4
    mul r7, r3, r2
    add r5, r4, r7
    ldr r0, =-2
    str r0, [r5]
    ldr r6, =0
    add r8, r6, #4
    ldr r1, Addr1_0
    ldr r9, =4
    mul r2, r8, r9
    add r3, r1, r2
    ldr r7, =0
    str r7, [r3]
    ldr r4, =0
    add r5, r4, #5
    ldr r0, Addr1_0
    ldr r6, =4
    mul r8, r5, r6
    add r9, r0, r8
    ldr r1, =1
    str r1, [r9]
    ldr r2, =0
    add r3, r2, #6
    ldr r7, Addr1_0
    ldr r4, =4
    mul r5, r3, r4
    add r6, r7, r5
    ldr r0, =-6
    str r0, [r6]
    ldr r8, =0
    add r9, r8, #7
    ldr r1, Addr1_0
    ldr r2, =4
    mul r3, r9, r2
    add r4, r1, r3
    ldr r7, =5
    str r7, [r4]
    ldr r5, =0
    add r6, r5, #8
    ldr r0, Addr1_0
    ldr r8, =4
    mul r9, r6, r8
    add r2, r0, r9
    ldr r1, =7
    str r1, [r2]
    ldr r3, =0
    add r4, r3, #9
    ldr r7, Addr1_0
    ldr r5, =4
    mul r6, r4, r5
    add r8, r7, r6
    ldr r0, =8
    str r0, [r8]
    ldr r0, =10
    bl maxSubArray
    mov r9, r0
    b bb1_0
bb1_0:
    mov r0, r9
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..nums

    .type ..nums, %object
    .comm ..nums, 40, 4

