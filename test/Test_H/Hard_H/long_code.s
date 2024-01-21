    .arch armv8 
    .text 
    .globl bubblesort
    .p2align 2
    .type bubblesort, %function
bubblesort:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    Ldr r1, =0
    b bb0_0
bb0_0:
    ldr r2, Addr0_0
    ldr r2, [r2]
    sub r3, r2, #1
    cmp r1, r3
    ldr r4, =0
    ldrlt r4, =1
    cmp r1, r3
    blt bb0_1
    b bb0_2
bb0_1:
    Ldr r5, =0
    b bb0_3
bb0_2:
    b bb0_8
bb0_3:
    ldr r6, Addr0_0
    ldr r6, [r6]
    sub r7, r6, r1
    sub r8, r7, #1
    cmp r5, r8
    ldr r9, =0
    ldrlt r9, =1
    cmp r5, r8
    blt bb0_4
    b bb0_5
bb0_4:
    add r4, r5, #0
    add r3, r0, #0
    ldr r6, =4
    mul r7, r4, r6
    add r8, r3, r7
    ldr r9, [r8]
    add r2, r5, #1
    add r4, r2, #0
    add r6, r0, #0
    ldr r3, =4
    mul r7, r4, r3
    add r8, r6, r7
    ldr r2, [r8]
    cmp r9, r2
    ldr r4, =0
    ldrgt r4, =1
    cmp r9, r2
    bgt bb0_6
    b bb0_7
bb0_5:
    add r2, r1, #1
    Mov r1, r2
    b bb0_0
bb0_6:
    add r6, r5, #1
    add r7, r6, #0
    add r8, r0, #0
    ldr r9, =4
    mul r2, r7, r9
    add r4, r8, r2
    ldr r3, [r4]
    add r6, r5, #1
    add r7, r6, #0
    add r9, r0, #0
    ldr r8, =4
    mul r2, r7, r8
    add r4, r9, r2
    add r6, r5, #0
    add r7, r0, #0
    ldr r8, =4
    mul r9, r6, r8
    add r2, r7, r9
    ldr r6, [r2]
    str r6, [r4]
    add r8, r5, #0
    add r7, r0, #0
    ldr r9, =4
    mul r2, r8, r9
    add r6, r7, r2
    str r3, [r6]
    b bb0_7
bb0_7:
    b litpool0_0
    .pool
litpool0_0:
    add r3, r5, #1
    Mov r5, r3
    b bb0_3
bb0_8:
    ldr r0, =0
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr0_0:
    .long ..n

    .globl insertsort
    .p2align 2
    .type insertsort, %function
insertsort:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    Ldr r1, =1
    b bb1_0
bb1_0:
    ldr r2, Addr1_0
    ldr r2, [r2]
    cmp r1, r2
    ldr r3, =0
    ldrlt r3, =1
    cmp r1, r2
    blt bb1_1
    b bb1_2
bb1_1:
    add r4, r1, #0
    add r5, r0, #0
    ldr r6, =4
    mul r7, r4, r6
    add r8, r5, r7
    ldr r9, [r8]
    sub r2, r1, #1
    Mov r3, r2
    b bb1_3
bb1_2:
    b bb1_7
bb1_3:
    ldr r4, =-1
    cmp r3, r4
    ldr r6, =0
    ldrgt r6, =1
    ldr r5, =-1
    cmp r3, r5
    bgt bb1_6
    b bb1_5
bb1_4:
    add r2, r3, #1
    add r4, r2, #0
    add r6, r0, #0
    ldr r5, =4
    mul r7, r4, r5
    add r8, r6, r7
    add r2, r3, #0
    add r4, r0, #0
    ldr r5, =4
    mul r6, r2, r5
    add r7, r4, r6
    ldr r2, [r7]
    str r2, [r8]
    sub r5, r3, #1
    Mov r3, r5
    b bb1_3
bb1_5:
    add r7, r3, #1
    add r8, r7, #0
    add r2, r0, #0
    ldr r4, =4
    mul r6, r8, r4
    add r5, r2, r6
    str r9, [r5]
    add r7, r1, #1
    Mov r1, r7
    b bb1_0
bb1_6:
    b litpool1_0
    .pool
litpool1_0:
    add r8, r3, #0
    add r4, r0, #0
    ldr r2, =4
    mul r6, r8, r2
    add r5, r4, r6
    ldr r7, [r5]
    cmp r9, r7
    ldr r8, =0
    ldrlt r8, =1
    cmp r9, r7
    blt bb1_4
    b bb1_5
bb1_7:
    ldr r0, =0
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr1_0:
    .long ..n

    .globl QuickSort
    .p2align 2
    .type QuickSort, %function
QuickSort:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #92
    cmp r1, r2
    ldr r3, =0
    ldrlt r3, =1
    cmp r1, r2
    blt bb2_0
    b bb2_1
bb2_0:
    add r4, r1, #0
    add r5, r0, #0
    ldr r6, =4
    mul r7, r4, r6
    add r8, r5, r7
    ldr r9, [r8]
    Mov r3, r2
    Mov r6, r1
    b bb2_2
bb2_1:
    b bb2_17
bb2_2:
    cmp r6, r3
    ldr r4, =0
    ldrlt r4, =1
    cmp r6, r3
    blt bb2_3
    b bb2_4
bb2_3:
    Mov r7, r3
    b bb2_5
bb2_4:
    add r7, r6, #0
    add r5, r0, #0
    ldr r8, =4
    mul r4, r7, r8
    str r0, [sp, #20]
    add r0, r5, r4
    str r0, [sp, #8]
    ldr r0, [sp, #8]
    str r9, [r0]
    sub r8, r6, #1
    ldr r0, [sp, #20]
    add r7, r0, #0
    ldr r4, =0
    ldr r5, =4
    str r0, [sp, #20]
    mul r0, r4, r5
    str r0, [sp, #24]
    ldr r0, [sp, #24]
    add r0, r7, r0
    str r0, [sp, #20]
    STM SP, {r0, r1, r2, r3}
    ldr r0, [sp, #20]
    ldr r1, [sp, #4]
    mov r2, r8
    bl QuickSort
    LDMIB SP, {r1, r2, r3}
    mov r4, r0
    ldr r0, [SP]
    add r5, r6, #1
    ldr r0, [sp, #20]
    add r7, r0, #0
    ldr r8, =0
    str r0, [sp, #20]
    ldr r0, =4
    str r0, [sp, #60]
    ldr r0, [sp, #60]
    mul r0, r8, r0
    str r0, [sp, #16]
    ldr r0, [sp, #16]
    add r0, r7, r0
    str r0, [sp, #12]
    STM SP, {r2, r3}
    ldr r0, [sp, #12]
    mov r1, r5
    ldr r2, [sp]
    bl QuickSort
    LDM SP, {r2, r3}
    mov r8, r0
    ldr r0, [sp, #20]
    b bb2_1
bb2_5:
    b litpool2_0
    .pool
litpool2_0:
    cmp r6, r7
    ldr r5, =0
    ldrlt r5, =1
    cmp r6, r7
    blt bb2_8
    b bb2_7
bb2_6:
    sub r8, r7, #1
    Mov r7, r8
    b bb2_5
bb2_7:
    cmp r6, r7
    ldr r4, =0
    ldrlt r4, =1
    cmp r6, r7
    blt bb2_9
    Mov r8, r6
    b bb2_10
bb2_8:
    add r4, r7, #0
    add r8, r0, #0
    ldr r5, =4
    mul r3, r4, r5
    str r0, [sp, #20]
    add r0, r8, r3
    str r0, [sp, #36]
    ldr r0, [sp, #36]
    ldr r5, [r0]
    sub r4, r9, #1
    cmp r5, r4
    ldr r3, =0
    ldrgt r3, =1
    cmp r5, r4
    ldr r0, [sp, #20]
    bgt bb2_6
    b bb2_7
bb2_9:
    add r8, r6, #0
    add r4, r0, #0
    ldr r3, =4
    mul r5, r8, r3
    str r0, [sp, #20]
    add r0, r4, r5
    str r0, [sp, #32]
    add r3, r7, #0
    ldr r0, [sp, #20]
    add r8, r0, #0
    ldr r5, =4
    mul r4, r3, r5
    str r0, [sp, #20]
    add r0, r8, r4
    str r0, [sp, #28]
    ldr r0, [sp, #28]
    ldr r5, [r0]
    ldr r0, [sp, #32]
    str r5, [r0]
    add r3, r6, #1
    ldr r0, [sp, #20]
    Mov r8, r3
    b bb2_10
bb2_10:
    Mov r3, r8
    b bb2_11
bb2_11:
    cmp r3, r7
    ldr r5, =0
    ldrlt r5, =1
    cmp r3, r7
    blt bb2_14
    b bb2_13
bb2_12:
    b litpool2_1
    .pool
litpool2_1:
    add r5, r3, #1
    Mov r3, r5
    b bb2_11
bb2_13:
    cmp r3, r7
    ldr r4, =0
    ldrlt r4, =1
    cmp r3, r7
    blt bb2_15
    Mov r8, r7
    b bb2_16
bb2_14:
    add r8, r3, #0
    add r5, r0, #0
    ldr r4, =4
    str r0, [sp, #20]
    mul r0, r8, r4
    str r0, [sp, #4]
    ldr r0, [sp, #4]
    add r0, r5, r0
    str r0, [sp, #44]
    ldr r0, [sp, #44]
    ldr r4, [r0]
    cmp r4, r9
    ldr r8, =0
    ldrlt r8, =1
    cmp r4, r9
    ldr r0, [sp, #20]
    blt bb2_12
    b bb2_13
bb2_15:
    add r5, r7, #0
    add r4, r0, #0
    ldr r8, =4
    str r0, [sp, #20]
    mul r0, r5, r8
    str r0, [sp, #40]
    ldr r0, [sp, #40]
    add r0, r4, r0
    str r0, [sp, #48]
    add r5, r3, #0
    ldr r0, [sp, #20]
    add r8, r0, #0
    ldr r4, =4
    str r0, [sp, #20]
    mul r0, r5, r4
    str r0, [sp, #56]
    ldr r0, [sp, #56]
    add r0, r8, r0
    str r0, [sp, #52]
    ldr r0, [sp, #52]
    ldr r5, [r0]
    ldr r0, [sp, #48]
    str r5, [r0]
    sub r4, r7, #1
    ldr r0, [sp, #20]
    Mov r8, r4
    b bb2_16
bb2_16:
    Mov r6, r3
    Mov r3, r8
    b bb2_2
bb2_17:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

    .globl getMid
    .p2align 2
    .type getMid, %function
getMid:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    ldr r1, Addr3_0
    ldr r1, [r1]
    ldr r2, =2
    sdiv r3, r1, r2
    ldr r4, =2
    mul r5, r3, r4
    sub r6, r1, r5
    ldr r7, =0
    cmp r6, r7
    ldr r8, =0
    ldreq r8, =1
    ldr r9, =0
    cmp r6, r9
    beq bb3_0
    b bb3_1
bb3_0:
    ldr r3, Addr3_0
    ldr r3, [r3]
    ldr r4, =2
    sdiv r5, r3, r4
    add r7, r5, #0
    add r1, r0, #0
    ldr r6, =4
    mul r9, r7, r6
    add r8, r1, r9
    ldr r2, [r8]
    sub r4, r5, #1
    add r3, r4, #0
    add r7, r0, #0
    ldr r6, =4
    mul r1, r3, r6
    add r9, r7, r1
    ldr r8, [r9]
    add r5, r2, r8
    ldr r4, =2
    sdiv r0, r5, r4
    Mov r2, r0
    b bb3_2
bb3_1:
    b litpool3_0
    .pool
litpool3_0:
    ldr r2, Addr3_0
    ldr r2, [r2]
    ldr r3, =2
    sdiv r4, r2, r3
    add r5, r4, #0
    add r1, r0, #0
    ldr r7, =4
    mul r6, r5, r7
    add r9, r1, r6
    ldr r8, [r9]
    Mov r2, r8
    b bb3_2
bb3_2:
    mov r0, r2
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr3_0:
    .long ..n

    .globl getMost
    .p2align 2
    .type getMost, %function
getMost:
    push {r4, r5, r6, r7, r8, r9, lr}
    ldr lr, =8028
    sub sp, sp, lr
    Ldr r1, =0
    b bb4_0
bb4_0:
    ldr r2, =1000
    cmp r1, r2
    ldr r3, =0
    ldrlt r3, =1
    ldr r4, =1000
    cmp r1, r4
    blt bb4_1
    b bb4_2
bb4_1:
    add r3, r1, #0
    ldr r6, =4004
    add r6, sp, r6
    ldr r5, =4
    mul r8, r3, r5
    add r9, r6, r8
    ldr r2, =0
    str r2, [r9]
    add r4, r1, #1
    Mov r1, r4
    b bb4_0
bb4_2:
    Ldr r6, =0
    Ldr r7, =0
    b bb4_3
bb4_3:
    ldr r8, Addr4_0
    ldr r8, [r8]
    cmp r7, r8
    ldr r9, =0
    ldrlt r9, =1
    cmp r7, r8
    blt bb4_4
    b bb4_5
bb4_4:
    add r2, r7, #0
    add r4, r0, #0
    ldr r3, =4
    mul r8, r2, r3
    add r9, r4, r8
    ldr r2, [r9]
    add r3, r2, #0
    ldr r4, =4004
    add r4, sp, r4
    ldr r8, =4
    mul r9, r3, r8
    str r0, [sp]
    add r0, r4, r9
    ldr lr, =8004
    add lr, lr, sp
    str r0, [lr]
    add r3, r2, #0
    ldr r8, =4004
    add r8, sp, r8
    ldr r4, =4
    mul r9, r3, r4
    add r0, r8, r9
    ldr lr, =8008
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =8008
    add lr, lr, sp
    ldr r0, [lr]
    ldr r3, [r0]
    add r4, r3, #1
    ldr lr, =8004
    add lr, lr, sp
    ldr r0, [lr]
    str r4, [r0]
    add r8, r2, #0
    ldr r9, =4004
    add r9, sp, r9
    ldr r3, =4
    mul r4, r8, r3
    add r0, r9, r4
    ldr lr, =8012
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =8012
    add lr, lr, sp
    ldr r0, [lr]
    ldr r8, [r0]
    cmp r8, r6
    ldr r3, =0
    ldrgt r3, =1
    cmp r8, r6
    ldr r0, [sp]
    bgt bb4_6
    Mov r4, r6
    Mov r9, r5
    b bb4_7
bb4_5:
    b litpool4_0
    .pool
litpool4_0:
    b bb4_8
bb4_6:
    add r3, r2, #0
    ldr r5, =4004
    add r5, sp, r5
    ldr r6, =4
    mul r8, r3, r6
    add r9, r5, r8
    ldr r4, [r9]
    Mov r9, r2
    b bb4_7
bb4_7:
    add r8, r7, #1
    Mov r5, r9
    Mov r6, r4
    Mov r7, r8
    b bb4_3
bb4_8:
    mov r0, r5
    ldr lr, =8028
    add sp, sp, lr
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr4_0:
    .long ..n

    .globl revert
    .p2align 2
    .type revert, %function
revert:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    Ldr r1, =0
    Ldr r2, =0
    b bb5_0
bb5_0:
    cmp r2, r1
    ldr r3, =0
    ldrlt r3, =1
    cmp r2, r1
    blt bb5_1
    b bb5_2
bb5_1:
    add r4, r2, #0
    add r5, r0, #0
    ldr r6, =4
    mul r7, r4, r6
    add r8, r5, r7
    ldr r9, [r8]
    add r3, r2, #0
    add r4, r0, #0
    ldr r6, =4
    mul r5, r3, r6
    add r7, r4, r5
    add r8, r1, #0
    add r3, r0, #0
    ldr r6, =4
    mul r4, r8, r6
    add r5, r3, r4
    ldr r8, [r5]
    str r8, [r7]
    add r6, r1, #0
    add r3, r0, #0
    ldr r4, =4
    mul r5, r6, r4
    add r8, r3, r5
    str r9, [r8]
    add r7, r2, #1
    sub r6, r1, #1
    Mov r1, r6
    Mov r2, r7
    b bb5_0
bb5_2:
    b bb5_3
bb5_3:
    ldr r0, =0
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl arrCopy
    .p2align 2
    .type arrCopy, %function
arrCopy:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    Ldr r2, =0
    b bb6_0
bb6_0:
    b litpool6_0
    .pool
litpool6_0:
    ldr r3, Addr6_0
    ldr r3, [r3]
    cmp r2, r3
    ldr r4, =0
    ldrlt r4, =1
    cmp r2, r3
    blt bb6_1
    b bb6_2
bb6_1:
    add r5, r2, #0
    add r6, r1, #0
    ldr r7, =4
    mul r8, r5, r7
    add r9, r6, r8
    add r4, r2, #0
    add r3, r0, #0
    ldr r5, =4
    mul r7, r4, r5
    add r6, r3, r7
    ldr r8, [r6]
    str r8, [r9]
    add r4, r2, #1
    Mov r2, r4
    b bb6_0
bb6_2:
    b bb6_3
bb6_3:
    ldr r0, =0
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr6_0:
    .long ..n

    .globl calSum
    .p2align 2
    .type calSum, %function
calSum:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    Ldr r2, =0
    Ldr r3, =0
    b bb7_0
bb7_0:
    ldr r4, Addr7_0
    ldr r4, [r4]
    cmp r2, r4
    ldr r5, =0
    ldrlt r5, =1
    cmp r2, r4
    blt bb7_1
    b bb7_2
bb7_1:
    add r6, r2, #0
    add r7, r0, #0
    ldr r8, =4
    mul r9, r6, r8
    add r4, r7, r9
    ldr r5, [r4]
    add r6, r3, r5
    sdiv r8, r2, r1
    mul r7, r8, r1
    sub r9, r2, r7
    sub r4, r1, #1
    cmp r9, r4
    ldr r5, =0
    ldrne r5, =1
    cmp r9, r4
    bne bb7_3
    b bb7_4
bb7_2:
    b bb7_6
bb7_3:
    b litpool7_0
    .pool
litpool7_0:
    add r7, r2, #0
    add r8, r0, #0
    ldr r4, =4
    mul r5, r7, r4
    add r3, r8, r5
    ldr r9, =0
    str r9, [r3]
    Mov r9, r6
    b bb7_5
bb7_4:
    add r3, r2, #0
    add r8, r0, #0
    ldr r7, =4
    mul r4, r3, r7
    add r5, r8, r4
    str r6, [r5]
    Ldr r9, =0
    b bb7_5
bb7_5:
    add r3, r2, #1
    Mov r2, r3
    Mov r3, r9
    b bb7_0
bb7_6:
    ldr r0, =0
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr7_0:
    .long ..n

    .globl avgPooling
    .p2align 2
    .type avgPooling, %function
avgPooling:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #36
    Ldr r3, =0
    Ldr r4, =0
    b bb8_0
bb8_0:
    ldr r5, Addr8_0
    ldr r5, [r5]
    cmp r3, r5
    ldr r6, =0
    ldrlt r6, =1
    cmp r3, r5
    blt bb8_1
    b bb8_2
bb8_1:
    sub r7, r1, #1
    cmp r3, r7
    ldr r9, =0
    ldrlt r9, =1
    cmp r3, r7
    blt bb8_3
    b bb8_4
bb8_2:
    ldr r7, Addr8_0
    ldr r7, [r7]
    sub r8, r7, r1
    add r9, r8, #1
    Mov r5, r9
    b bb8_9
bb8_3:
    b litpool8_0
    .pool
litpool8_0:
    add r8, r3, #0
    add r6, r0, #0
    ldr r7, =4
    mul r5, r8, r7
    add r9, r6, r5
    ldr r8, [r9]
    add r7, r4, r8
    Mov r5, r2
    Mov r6, r7
    b bb8_5
bb8_4:
    sub r6, r1, #1
    cmp r3, r6
    ldr r5, =0
    ldreq r5, =1
    cmp r3, r6
    beq bb8_6
    b bb8_7
bb8_5:
    add r7, r3, #1
    Mov r2, r5
    Mov r3, r7
    Mov r4, r6
    b bb8_0
bb8_6:
    add r8, r0, #0
    ldr r9, =0
    ldr r7, =4
    mul r5, r9, r7
    add r6, r8, r5
    ldr r9, [r6]
    add r7, r0, #0
    ldr r5, =0
    ldr r8, =4
    mul r6, r5, r8
    str r0, [sp]
    add r0, r7, r6
    str r0, [sp, #16]
    sdiv r5, r4, r1
    ldr r0, [sp, #16]
    str r5, [r0]
    ldr r0, [sp]
    Mov r8, r9
    Mov r9, r4
    b bb8_8
bb8_7:
    add r8, r3, #0
    add r7, r0, #0
    ldr r9, =4
    mul r6, r8, r9
    add r5, r7, r6
    ldr r9, [r5]
    add r8, r4, r9
    sub r6, r8, r2
    sub r7, r3, r1
    add r5, r7, #1
    add r9, r5, #0
    add r8, r0, #0
    ldr r7, =4
    mul r5, r9, r7
    str r0, [sp]
    add r0, r8, r5
    str r0, [sp, #4]
    ldr r0, [sp, #4]
    ldr r7, [r0]
    sub r9, r3, r1
    add r5, r9, #1
    add r8, r5, #0
    ldr r0, [sp]
    add r9, r0, #0
    ldr r5, =4
    str r0, [sp]
    mul r0, r8, r5
    str r0, [sp, #8]
    ldr r0, [sp, #8]
    add r0, r9, r0
    str r0, [sp, #12]
    sdiv r5, r6, r1
    ldr r0, [sp, #12]
    str r5, [r0]
    ldr r0, [sp]
    Mov r8, r7
    Mov r9, r6
    b bb8_8
bb8_8:
    Mov r5, r8
    Mov r6, r9
    b bb8_5
bb8_9:
    ldr r6, Addr8_0
    ldr r6, [r6]
    cmp r5, r6
    ldr r7, =0
    ldrlt r7, =1
    cmp r5, r6
    blt bb8_10
    b bb8_11
bb8_10:
    b litpool8_1
    .pool
litpool8_1:
    add r8, r5, #0
    add r9, r0, #0
    ldr r6, =4
    mul r7, r8, r6
    str r0, [sp]
    add r0, r9, r7
    str r0, [sp, #20]
    ldr r6, =0
    ldr r0, [sp, #20]
    str r6, [r0]
    add r8, r5, #1
    ldr r0, [sp]
    Mov r5, r8
    b bb8_9
bb8_11:
    b bb8_12
bb8_12:
    ldr r0, =0
    add sp, sp, #36
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr8_0:
    .long ..n

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    ldr lr, =584
    sub sp, sp, lr
    ldr r0, =32
    push {r1}
    ldr lr, =Addr9_0
    ldr r1, [lr]
    str r0, [r1]
    pop {r1}
    ldr r1, =260
    add r1, sp, r1
    ldr r2, =0
    ldr r3, =4
    mul r4, r2, r3
    add r5, r1, r4
    ldr r6, =7
    str r6, [r5]
    ldr r7, =260
    add r7, sp, r7
    ldr r8, =1
    ldr r9, =4
    mul r0, r8, r9
    add r2, r7, r0
    ldr r3, =23
    str r3, [r2]
    ldr r4, =260
    add r4, sp, r4
    ldr r1, =2
    ldr r5, =4
    mul r6, r1, r5
    add r8, r4, r6
    ldr r9, =89
    str r9, [r8]
    ldr r0, =260
    add r0, sp, r0
    ldr r7, =3
    ldr r2, =4
    mul r3, r7, r2
    add r1, r0, r3
    ldr r5, =26
    str r5, [r1]
    ldr r6, =260
    add r6, sp, r6
    ldr r4, =4
    ldr r8, =4
    mul r9, r4, r8
    add r7, r6, r9
    ldr r2, =282
    str r2, [r7]
    ldr r0, =260
    add r0, sp, r0
    ldr r3, =5
    ldr r1, =4
    mul r5, r3, r1
    add r4, r0, r5
    ldr r8, =254
    str r8, [r4]
    ldr r6, =260
    add r6, sp, r6
    ldr r9, =6
    ldr r7, =4
    mul r2, r9, r7
    add r3, r6, r2
    ldr r1, =27
    str r1, [r3]
    ldr r0, =260
    add r0, sp, r0
    ldr r5, =7
    ldr r4, =4
    mul r8, r5, r4
    add r9, r0, r8
    ldr r7, =5
    str r7, [r9]
    ldr r6, =260
    add r6, sp, r6
    ldr r2, =8
    ldr r3, =4
    mul r1, r2, r3
    add r5, r6, r1
    ldr r4, =83
    str r4, [r5]
    ldr r0, =260
    add r0, sp, r0
    ldr r8, =9
    ldr r9, =4
    mul r7, r8, r9
    add r2, r0, r7
    ldr r3, =273
    str r3, [r2]
    ldr r6, =260
    add r6, sp, r6
    ldr r1, =10
    ldr r5, =4
    mul r4, r1, r5
    add r8, r6, r4
    ldr r9, =574
    str r9, [r8]
    ldr r0, =260
    add r0, sp, r0
    ldr r7, =11
    ldr r2, =4
    mul r3, r7, r2
    add r1, r0, r3
    ldr r5, =905
    str r5, [r1]
    ldr r6, =260
    add r6, sp, r6
    ldr r4, =12
    ldr r8, =4
    mul r9, r4, r8
    add r7, r6, r9
    ldr r2, =354
    str r2, [r7]
    ldr r3, =260
    add r3, sp, r3
    ldr r0, =13
    ldr r1, =4
    mul r5, r0, r1
    add r4, r3, r5
    ldr r8, =657
    str r8, [r4]
    ldr r9, =260
    add r9, sp, r9
    ldr r6, =14
    ldr r7, =4
    mul r2, r6, r7
    add r0, r9, r2
    ldr r1, =935
    str r1, [r0]
    ldr r5, =260
    add r5, sp, r5
    ldr r3, =15
    ldr r4, =4
    mul r8, r3, r4
    add r6, r5, r8
    ldr r7, =264
    str r7, [r6]
    ldr r2, =260
    add r2, sp, r2
    ldr r9, =16
    ldr r0, =4
    mul r1, r9, r0
    add r3, r2, r1
    ldr r4, =639
    str r4, [r3]
    ldr r8, =260
    add r8, sp, r8
    ldr r5, =17
    ldr r6, =4
    mul r7, r5, r6
    add r9, r8, r7
    ldr r0, =459
    str r0, [r9]
    ldr r1, =260
    add r1, sp, r1
    ldr r2, =18
    ldr r3, =4
    mul r4, r2, r3
    add r5, r1, r4
    ldr r6, =29
    str r6, [r5]
    ldr r7, =260
    add r7, sp, r7
    ldr r8, =19
    ldr r9, =4
    mul r0, r8, r9
    add r2, r7, r0
    ldr r3, =68
    str r3, [r2]
    ldr r4, =260
    add r4, sp, r4
    ldr r1, =20
    ldr r5, =4
    mul r6, r1, r5
    add r8, r4, r6
    ldr r9, =929
    str r9, [r8]
    ldr r0, =260
    add r0, sp, r0
    ldr r7, =21
    ldr r2, =4
    mul r3, r7, r2
    add r1, r0, r3
    ldr r5, =756
    str r5, [r1]
    ldr r6, =260
    add r6, sp, r6
    ldr r4, =22
    ldr r8, =4
    mul r9, r4, r8
    add r7, r6, r9
    ldr r2, =452
    str r2, [r7]
    ldr r3, =260
    add r3, sp, r3
    ldr r0, =23
    ldr r1, =4
    mul r5, r0, r1
    add r4, r3, r5
    ldr r8, =279
    str r8, [r4]
    ldr r9, =260
    add r9, sp, r9
    ldr r6, =24
    ldr r7, =4
    mul r2, r6, r7
    add r0, r9, r2
    ldr r1, =58
    str r1, [r0]
    ldr r5, =260
    add r5, sp, r5
    ldr r3, =25
    ldr r4, =4
    mul r8, r3, r4
    add r6, r5, r8
    ldr r7, =87
    str r7, [r6]
    ldr r2, =260
    add r2, sp, r2
    ldr r9, =26
    ldr r0, =4
    mul r1, r9, r0
    add r3, r2, r1
    ldr r4, =96
    str r4, [r3]
    ldr r8, =260
    add r8, sp, r8
    ldr r5, =27
    ldr r6, =4
    mul r7, r5, r6
    add r9, r8, r7
    ldr r0, =36
    str r0, [r9]
    ldr r1, =260
    add r1, sp, r1
    ldr r2, =28
    ldr r3, =4
    mul r4, r2, r3
    add r5, r1, r4
    ldr r6, =39
    str r6, [r5]
    ldr r7, =260
    add r7, sp, r7
    ldr r8, =29
    ldr r9, =4
    mul r0, r8, r9
    add r2, r7, r0
    ldr r3, =28
    str r3, [r2]
    ldr r4, =260
    add r4, sp, r4
    ldr r1, =30
    ldr r5, =4
    mul r6, r1, r5
    add r8, r4, r6
    ldr r9, =1
    str r9, [r8]
    ldr r0, =260
    add r0, sp, r0
    ldr r7, =31
    ldr r2, =4
    mul r3, r7, r2
    add r1, r0, r3
    ldr r5, =290
    str r5, [r1]
    ldr r6, =260
    add r6, sp, r6
    ldr r4, =0
    ldr r8, =4
    mul r9, r4, r8
    add r7, r6, r9
    ldr r2, =388
    add r2, sp, r2
    ldr r3, =0
    ldr r0, =4
    mul r1, r3, r0
    add r5, r2, r1
    mov r0, r7
    mov r1, r5
    bl arrCopy
    mov r4, r0
    ldr r8, =388
    add r8, sp, r8
    ldr r9, =0
    ldr r6, =4
    mul r3, r9, r6
    add r0, r8, r3
    STM SP, {r0, r1}
    ldr r0, [sp]
    bl revert
    LDMIB SP, {r1}
    mov r1, r0
    ldr r0, [SP]
    Ldr r2, =0
    b bb9_0
bb9_0:
    ldr r7, =32
    cmp r2, r7
    ldr r5, =0
    ldrlt r5, =1
    ldr r9, =32
    cmp r2, r9
    blt bb9_1
    b bb9_2
bb9_1:
    b litpool9_0
    .pool
litpool9_0:
    add r3, r2, #0
    ldr r0, =388
    add r0, sp, r0
    ldr r6, =4
    mul r8, r3, r6
    add r1, r0, r8
    ldr r4, [r1]
    STM SP, {r2}
    mov r0, r4
    bl put_int
    LDM sp, {r2}
    add r9, r2, #1
    Mov r2, r9
    b bb9_0
bb9_2:
    ldr r6, =388
    add r6, sp, r6
    ldr r3, =0
    ldr r8, =4
    mul r0, r3, r8
    add r4, r6, r0
    STM SP, {r1}
    mov r0, r4
    bl bubblesort
    LDM SP, {r1}
    mov r1, r0
    Ldr r7, =0
    b bb9_3
bb9_3:
    ldr r9, =32
    cmp r7, r9
    ldr r5, =0
    ldrlt r5, =1
    ldr r3, =32
    cmp r7, r3
    blt bb9_4
    b bb9_5
bb9_4:
    add r6, r7, #0
    ldr r1, =388
    add r1, sp, r1
    ldr r0, =4
    mul r8, r6, r0
    add r4, r1, r8
    ldr r9, [r4]
    mov r0, r9
    bl put_int
    add r5, r7, #1
    Mov r7, r5
    b bb9_3
bb9_5:
    ldr r8, =388
    add r8, sp, r8
    ldr r0, =0
    ldr r6, =4
    mul r4, r0, r6
    add r1, r8, r4
    STM SP, {r1}
    ldr r0, [sp]
    bl getMid
    LDM SP, {r1}
    mov r9, r0
    mov r0, r9
    bl put_int
    ldr r3, =388
    add r3, sp, r3
    ldr r5, =0
    ldr r0, =4
    mul r6, r5, r0
    add r8, r3, r6
    mov r0, r8
    bl getMost
    mov r4, r0
    mov r0, r4
    bl put_int
    ldr r1, =260
    add r1, sp, r1
    ldr r9, =0
    ldr r5, =4
    mul r0, r9, r5
    add r3, r1, r0
    ldr r6, =388
    add r6, sp, r6
    ldr r8, =0
    ldr r4, =4
    mul r9, r8, r4
    add r5, r6, r9
    STM SP, {r1, r3}
    ldr r0, [sp, #4]
    mov r1, r5
    bl arrCopy
    LDM SP, {r1, r3}
    mov r1, r0
    ldr r0, =388
    add r0, sp, r0
    ldr r8, =0
    ldr r4, =4
    mul r6, r8, r4
    add r9, r0, r6
    STM SP, {r1, r3}
    mov r0, r9
    bl bubblesort
    LDM SP, {r1, r3}
    mov r3, r0
    Ldr r5, =0
    b bb9_6
bb9_6:
    ldr r8, =32
    cmp r5, r8
    ldr r4, =0
    ldrlt r4, =1
    ldr r0, =32
    cmp r5, r0
    blt bb9_7
    b bb9_8
bb9_7:
    b litpool9_1
    .pool
litpool9_1:
    add r6, r5, #0
    ldr r0, =388
    add r0, sp, r0
    ldr r1, =4
    mul r8, r6, r1
    add r4, r0, r8
    ldr r9, [r4]
    mov r0, r9
    bl put_int
    add r3, r5, #1
    Mov r5, r3
    b bb9_6
bb9_8:
    ldr r6, =260
    add r6, sp, r6
    ldr r9, =0
    ldr r1, =4
    mul r3, r9, r1
    add r8, r6, r3
    ldr r4, =388
    add r4, sp, r4
    ldr r0, =0
    ldr r9, =4
    mul r1, r0, r9
    add r6, r4, r1
    STM SP, {r3}
    mov r0, r8
    mov r1, r6
    bl arrCopy
    LDM SP, {r3}
    mov r3, r0
    ldr r0, =388
    add r0, sp, r0
    ldr r9, =0
    ldr r4, =4
    mul r1, r9, r4
    add r8, r0, r1
    STM SP, {r3}
    mov r0, r8
    bl insertsort
    LDM SP, {r3}
    mov r6, r0
    Ldr r9, =0
    b bb9_9
bb9_9:
    ldr r4, =32
    cmp r9, r4
    ldr r0, =0
    ldrlt r0, =1
    ldr r1, =32
    cmp r9, r1
    blt bb9_10
    b bb9_11
bb9_10:
    add r3, r9, #0
    ldr r0, =388
    add r0, sp, r0
    ldr r6, =4
    mul r1, r3, r6
    add r8, r0, r1
    ldr r4, [r8]
    mov r0, r4
    bl put_int
    add r3, r9, #1
    Mov r9, r3
    b bb9_9
bb9_11:
    ldr r8, =260
    add r8, sp, r8
    ldr r3, =0
    ldr r6, =4
    mul r4, r3, r6
    add r0, r8, r4
    ldr r1, =388
    add r1, sp, r1
    ldr r3, =0
    ldr r6, =4
    mul r8, r3, r6
    add r4, r1, r8
    STM SP, {r0, r3}
    ldr r0, [sp]
    mov r1, r4
    bl arrCopy
    LDMIB SP, {r3}
    mov r3, r0
    ldr r0, [SP]
    ldr r6, =388
    add r6, sp, r6
    ldr r1, =0
    ldr r8, =4
    mul r0, r1, r8
    add r4, r6, r0
    STM SP, {r1, r3}
    mov r0, r4
    ldr r1, =0
    ldr r2, =31
    bl QuickSort
    LDM SP, {r1, r3}
    mov r1, r0
    Ldr r8, =0
    b bb9_12
bb9_12:
    b litpool9_2
    .pool
litpool9_2:
    ldr r6, =32
    cmp r8, r6
    ldr r0, =0
    ldrlt r0, =1
    ldr r4, =32
    cmp r8, r4
    blt bb9_13
    b bb9_14
bb9_13:
    add r1, r8, #0
    ldr r3, =388
    add r3, sp, r3
    ldr r4, =4
    mul r0, r1, r4
    add r6, r3, r0
    ldr r1, [r6]
    STM SP, {r1}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r1}
    add r4, r8, #1
    Mov r8, r4
    b bb9_12
bb9_14:
    ldr r3, =260
    add r3, sp, r3
    ldr r1, =0
    ldr r6, =4
    mul r0, r1, r6
    add r4, r3, r0
    ldr r1, =388
    add r1, sp, r1
    ldr r6, =0
    ldr r3, =4
    mul r0, r6, r3
    str r2, [sp, #20]
    add r2, r1, r0
    str r2, [sp, #516]
    mov r0, r4
    ldr r1, [sp, #516]
    bl arrCopy
    mov r6, r0
    ldr r3, =388
    add r3, sp, r3
    ldr r1, =0
    ldr r0, =4
    mul r4, r1, r0
    add r2, r3, r4
    str r2, [sp, #520]
    STM SP, {r1}
    ldr r0, [sp, #520]
    ldr r1, =4
    bl calSum
    LDM SP, {r1}
    mov r1, r0
    ldr r2, [sp, #20]
    Ldr r0, =0
    b bb9_15
bb9_15:
    ldr r3, =32
    cmp r0, r3
    ldr r4, =0
    ldrlt r4, =1
    ldr r6, =32
    cmp r0, r6
    blt bb9_16
    b bb9_17
bb9_16:
    add r4, r0, #0
    ldr r1, =388
    add r1, sp, r1
    ldr r6, =4
    mul r3, r4, r6
    str r0, [sp, #20]
    add r0, r1, r3
    str r0, [sp, #524]
    ldr r0, [sp, #524]
    ldr r4, [r0]
    STM SP, {r0}
    mov r0, r4
    bl put_int
    LDM sp, {r0}
    ldr r0, [sp, #20]
    add r6, r0, #1
    Mov r0, r6
    b bb9_15
bb9_17:
    ldr r1, =260
    add r1, sp, r1
    ldr r3, =0
    ldr r4, =4
    mul r6, r3, r4
    str r0, [sp, #20]
    add r0, r1, r6
    str r0, [sp, #528]
    ldr r3, =388
    add r3, sp, r3
    ldr r4, =0
    ldr r1, =4
    mul r6, r4, r1
    add r0, r3, r6
    str r0, [sp, #532]
    ldr r0, [sp, #528]
    ldr r1, [sp, #532]
    bl arrCopy
    mov r4, r0
    ldr r1, =388
    add r1, sp, r1
    ldr r3, =0
    ldr r6, =4
    mul r0, r3, r6
    str r0, [sp, #536]
    ldr r0, [sp, #536]
    add r0, r1, r0
    str r0, [sp, #540]
    STM SP, {r3}
    ldr r0, [sp, #540]
    ldr r1, =3
    bl avgPooling
    LDM SP, {r3}
    mov r3, r0
    ldr r0, [sp, #20]
    Ldr r6, =0
    b bb9_18
bb9_18:
    b litpool9_3
    .pool
litpool9_3:
    ldr r1, =32
    cmp r6, r1
    ldr r4, =0
    ldrlt r4, =1
    ldr r3, =32
    cmp r6, r3
    blt bb9_19
    b bb9_20
bb9_19:
    add r1, r6, #0
    ldr r4, =388
    add r4, sp, r4
    ldr r3, =4
    str r0, [sp, #20]
    mul r0, r1, r3
    str r0, [sp, #544]
    ldr r0, [sp, #544]
    add r0, r4, r0
    str r0, [sp, #548]
    ldr r0, [sp, #548]
    ldr r1, [r0]
    STM SP, {r1}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r1}
    add r3, r6, #1
    ldr r0, [sp, #20]
    Mov r6, r3
    b bb9_18
bb9_20:
    b bb9_21
bb9_21:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr9_0:
    .long ..n

    .type ..n, %object
    .bss
    .globl ..n
    .p2align 2
..n:
    .long 0
    .size ..n, 4

