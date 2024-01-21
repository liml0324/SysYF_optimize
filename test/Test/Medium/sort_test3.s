    .arch armv8 
    .text 
    .globl QuickSort
    .p2align 2
    .type QuickSort, %function
QuickSort:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #52
    cmp r0, r1
    ldr r2, =0
    ldrlt r2, =1
    cmp r0, r1
    blt bb0_0
    b bb0_1
bb0_0:
    add r6, r0, #0
    ldr r7, Addr0_0
    ldr r8, =4
    mul r9, r6, r8
    add r2, r7, r9
    ldr r3, [r2]
    Mov r4, r1
    Mov r5, r0
    b bb0_2
bb0_1:
    b bb0_21
bb0_2:
    cmp r5, r4
    ldr r8, =0
    ldrlt r8, =1
    cmp r5, r4
    blt bb0_3
    b bb0_4
bb0_3:
    Mov r8, r4
    b bb0_5
bb0_4:
    add r6, r5, #0
    ldr r9, Addr0_0
    ldr r7, =4
    mul r2, r6, r7
    add r8, r9, r2
    str r3, [r8]
    sub r7, r5, #1
    STM SP, {r0, r1, r3}
    ldr r0, [sp]
    mov r1, r7
    bl QuickSort
    LDMIB SP, {r1, r3}
    mov r6, r0
    ldr r0, [SP]
    add r2, r5, #1
    STM SP, {r1, r2, r3}
    ldr r0, [sp, #4]
    ldr r1, [sp]
    bl QuickSort
    LDM SP, {r1, r2, r3}
    mov r9, r0
    b bb0_1
bb0_5:
    cmp r5, r8
    ldr r7, =0
    ldrlt r7, =1
    cmp r5, r8
    blt bb0_6
    b bb0_7
bb0_6:
    b litpool0_0
    .pool
litpool0_0:
    add r2, r8, #0
    ldr r6, Addr0_0
    ldr r7, =4
    mul r9, r2, r7
    add r4, r6, r9
    ldr r7, [r4]
    sub r2, r3, #1
    cmp r7, r2
    ldr r9, =0
    ldrgt r9, =1
    cmp r7, r2
    bgt bb0_8
    b bb0_9
bb0_7:
    cmp r5, r8
    ldr r2, =0
    ldrlt r2, =1
    cmp r5, r8
    blt bb0_11
    Mov r6, r5
    b bb0_12
bb0_8:
    sub r6, r8, #1
    b bb0_10
bb0_9:
    b bb0_7
bb0_10:
    Mov r8, r6
    b bb0_5
bb0_11:
    add r6, r5, #0
    ldr r2, Addr0_0
    ldr r4, =4
    mul r9, r6, r4
    add r7, r2, r9
    add r4, r8, #0
    ldr r6, Addr0_0
    ldr r9, =4
    mul r2, r4, r9
    str r0, [sp, #20]
    add r0, r6, r2
    str r0, [sp, #12]
    ldr r0, [sp, #12]
    ldr r9, [r0]
    str r9, [r7]
    add r4, r5, #1
    ldr r0, [sp, #20]
    Mov r6, r4
    b bb0_12
bb0_12:
    Mov r9, r6
    b bb0_13
bb0_13:
    b litpool0_1
    .pool
litpool0_1:
    cmp r9, r8
    ldr r4, =0
    ldrlt r4, =1
    cmp r9, r8
    blt bb0_14
    b bb0_15
bb0_14:
    add r4, r9, #0
    ldr r6, Addr0_0
    ldr r2, =4
    mul r7, r4, r2
    str r0, [sp, #20]
    add r0, r6, r7
    str r0, [sp, #8]
    ldr r0, [sp, #8]
    ldr r2, [r0]
    cmp r2, r3
    ldr r4, =0
    ldrlt r4, =1
    cmp r2, r3
    ldr r0, [sp, #20]
    blt bb0_16
    b bb0_17
bb0_15:
    cmp r9, r8
    ldr r7, =0
    ldrlt r7, =1
    cmp r9, r8
    blt bb0_19
    Mov r2, r8
    b bb0_20
bb0_16:
    add r7, r9, #1
    b bb0_18
bb0_17:
    b bb0_15
bb0_18:
    Mov r9, r7
    b bb0_13
bb0_19:
    add r6, r8, #0
    ldr r4, Addr0_0
    ldr r7, =4
    mul r2, r6, r7
    str r0, [sp, #20]
    add r0, r4, r2
    str r0, [sp, #16]
    add r7, r9, #0
    ldr r6, Addr0_0
    ldr r2, =4
    mul r4, r7, r2
    add r0, r6, r4
    str r0, [sp, #4]
    ldr r0, [sp, #4]
    ldr r2, [r0]
    ldr r0, [sp, #16]
    str r2, [r0]
    sub r7, r8, #1
    ldr r0, [sp, #20]
    Mov r2, r7
    b bb0_20
bb0_20:
    b litpool0_2
    .pool
litpool0_2:
    Mov r4, r2
    Mov r5, r9
    b bb0_2
bb0_21:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr0_0:
    .long ..a

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =10
    push {r1}
    ldr r1, Addr1_0
    str r0, [r1]
    pop {r1}
    ldr r1, =0
    add r2, r1, #0
    ldr r3, Addr1_1
    ldr r4, =4
    mul r5, r2, r4
    add r6, r3, r5
    ldr r7, =4
    str r7, [r6]
    ldr r8, =0
    add r9, r8, #1
    ldr r0, Addr1_1
    ldr r1, =4
    mul r2, r9, r1
    add r4, r0, r2
    ldr r3, =3
    str r3, [r4]
    ldr r5, =0
    add r6, r5, #2
    ldr r7, Addr1_1
    ldr r8, =4
    mul r9, r6, r8
    add r1, r7, r9
    ldr r0, =9
    str r0, [r1]
    ldr r2, =0
    add r4, r2, #3
    ldr r3, Addr1_1
    ldr r5, =4
    mul r6, r4, r5
    add r8, r3, r6
    ldr r9, =2
    str r9, [r8]
    ldr r7, =0
    add r1, r7, #4
    ldr r0, Addr1_1
    ldr r2, =4
    mul r5, r1, r2
    add r4, r0, r5
    ldr r6, =0
    str r6, [r4]
    ldr r3, =0
    add r8, r3, #5
    ldr r9, Addr1_1
    ldr r7, =4
    mul r2, r8, r7
    add r1, r9, r2
    ldr r0, =1
    str r0, [r1]
    ldr r5, =0
    add r4, r5, #6
    ldr r6, Addr1_1
    ldr r3, =4
    mul r8, r4, r3
    add r7, r6, r8
    ldr r9, =6
    str r9, [r7]
    ldr r2, =0
    add r1, r2, #7
    ldr r0, Addr1_1
    ldr r5, =4
    mul r4, r1, r5
    add r3, r0, r4
    ldr r6, =5
    str r6, [r3]
    ldr r8, =0
    add r7, r8, #8
    ldr r9, Addr1_1
    ldr r2, =4
    mul r1, r7, r2
    add r5, r9, r1
    ldr r0, =7
    str r0, [r5]
    ldr r4, =0
    add r3, r4, #9
    ldr r6, Addr1_1
    ldr r8, =4
    mul r7, r3, r8
    add r2, r6, r7
    ldr r9, =8
    str r9, [r2]
    STM SP, {r1}
    ldr r0, =0
    ldr r1, =9
    bl QuickSort
    LDM SP, {r1}
    mov r1, r0
    Mov r5, r1
    b bb1_0
bb1_0:
    ldr r0, Addr1_0
    ldr r0, [r0]
    cmp r5, r0
    ldr r4, =0
    ldrlt r4, =1
    cmp r5, r0
    blt bb1_1
    b bb1_2
bb1_1:
    add r3, r5, #0
    ldr r8, Addr1_1
    ldr r6, =4
    mul r7, r3, r6
    add r2, r8, r7
    ldr r9, [r2]
    mov r0, r9
    bl put_int
    ldr r0, =10
    bl put_char
    add r1, r5, #1
    Mov r5, r1
    b bb1_0
bb1_2:
    b bb1_3
bb1_3:
    b litpool1_0
    .pool
litpool1_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..n
Addr1_1:
    .long ..a

    .type ..n, %object
    .bss
    .globl ..n
    .p2align 2
..n:
    .long 0
    .size ..n, 4

    .type ..a, %object
    .comm ..a, 40, 4

