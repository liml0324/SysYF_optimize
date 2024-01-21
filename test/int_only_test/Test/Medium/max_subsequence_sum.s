    .arch armv8 
    .text 
    .globl maxSubArray
    .p2align 2
    .type maxSubArray, %function
maxSubArray:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #20
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldreq r2, =1
    ldr r3, =0
    cmp r0, r3
    beq bb0_0
    b bb0_1
bb0_0:
    Ldr r9, =0
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
    ldr r5, Addr0_0
    ldr r2, =0
    ldr r3, =4
    mul r7, r2, r3
    add r1, r5, r7
    ldr r9, [r1]
    b bb0_11
bb0_3:
    ldr r7, Addr0_0
    ldr r8, =0
    ldr r9, =4
    mul r1, r8, r9
    add r2, r7, r1
    ldr r3, [r2]
    Ldr r4, =1
    Mov r5, r3
    Mov r6, r3
    b bb0_4
bb0_4:
    cmp r4, r0
    ldr r8, =0
    ldrlt r8, =1
    cmp r4, r0
    blt bb0_5
    b bb0_6
bb0_5:
    ldr r7, =0
    cmp r5, r7
    ldr r1, =0
    ldrlt r1, =1
    ldr r2, =0
    cmp r5, r2
    blt bb0_7
    Mov r3, r5
    b bb0_8
bb0_6:
    b litpool0_0
    .pool
litpool0_0:
    Mov r9, r6
    b bb0_11
bb0_7:
    Ldr r3, =0
    b bb0_8
bb0_8:
    add r8, r4, #0
    ldr r9, Addr0_0
    ldr r7, =4
    mul r1, r8, r7
    add r5, r9, r1
    ldr r2, [r5]
    add r8, r3, r2
    cmp r6, r8
    ldr r7, =0
    ldrlt r7, =1
    cmp r6, r8
    blt bb0_9
    Mov r9, r6
    b bb0_10
bb0_9:
    Mov r9, r8
    b bb0_10
bb0_10:
    add r1, r4, #1
    Mov r4, r1
    Mov r5, r8
    Mov r6, r9
    b bb0_4
bb0_11:
    mov r0, r9
    add sp, sp, #20
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
    ldr r0, Addr1_0
    ldr r1, =0
    ldr r2, =4
    mul r3, r1, r2
    add r4, r0, r3
    ldr r5, =-4
    str r5, [r4]
    ldr r6, Addr1_0
    ldr r7, =1
    ldr r8, =4
    mul r9, r7, r8
    add r1, r6, r9
    ldr r2, =3
    str r2, [r1]
    ldr r3, Addr1_0
    ldr r0, =2
    ldr r4, =4
    mul r5, r0, r4
    add r7, r3, r5
    ldr r8, =9
    str r8, [r7]
    ldr r9, Addr1_0
    ldr r6, =3
    ldr r1, =4
    mul r2, r6, r1
    add r0, r9, r2
    ldr r4, =-2
    str r4, [r0]
    ldr r5, Addr1_0
    ldr r3, =4
    ldr r7, =4
    mul r8, r3, r7
    add r6, r5, r8
    ldr r1, =0
    str r1, [r6]
    ldr r2, Addr1_0
    ldr r9, =5
    ldr r0, =4
    mul r4, r9, r0
    add r3, r2, r4
    ldr r7, =1
    str r7, [r3]
    ldr r5, Addr1_0
    ldr r8, =6
    ldr r6, =4
    mul r1, r8, r6
    add r9, r5, r1
    ldr r0, =-6
    str r0, [r9]
    ldr r2, Addr1_0
    ldr r4, =7
    ldr r3, =4
    mul r7, r4, r3
    add r8, r2, r7
    ldr r6, =5
    str r6, [r8]
    ldr r5, Addr1_0
    ldr r1, =8
    ldr r9, =4
    mul r0, r1, r9
    add r4, r5, r0
    ldr r3, =7
    str r3, [r4]
    ldr r2, Addr1_0
    ldr r7, =9
    ldr r8, =4
    mul r6, r7, r8
    add r1, r2, r6
    ldr r9, =8
    str r9, [r1]
    ldr r0, =10
    bl maxSubArray
    mov r5, r0
    b bb1_0
bb1_0:
    mov r0, r5
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..nums

    .type ..nums, %object
    .comm ..nums, 40, 4

