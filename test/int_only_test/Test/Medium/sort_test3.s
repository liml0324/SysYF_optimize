    .arch armv8 
    .text 
    .globl QuickSort
    .p2align 2
    .type QuickSort, %function
QuickSort:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #60
    cmp r0, r1
    ldr r2, =0
    ldrlt r2, =1
    cmp r0, r1
    blt bb0_0
    b bb0_1
bb0_0:
    add r3, r0, #0
    ldr r4, Addr0_0
    ldr r5, =4
    mul r6, r3, r5
    add r7, r4, r6
    ldr r8, [r7]
    Mov r2, r0
    Mov r9, r1
    b bb0_2
bb0_1:
    b bb0_19
bb0_2:
    cmp r2, r9
    ldr r5, =0
    ldrlt r5, =1
    cmp r2, r9
    blt bb0_3
    b bb0_4
bb0_3:
    Mov r5, r9
    b bb0_5
bb0_4:
    add r3, r2, #0
    ldr r6, Addr0_0
    ldr r4, =4
    mul r7, r3, r4
    add r5, r6, r7
    str r8, [r5]
    sub r4, r2, #1
    STM SP, {r0, r1, r2, r3}
    ldr r0, [sp]
    mov r1, r4
    bl QuickSort
    LDMIB SP, {r1, r2, r3}
    mov r3, r0
    ldr r0, [SP]
    add r7, r2, #1
    STM SP, {r1, r2, r3}
    mov r0, r7
    ldr r1, [sp]
    bl QuickSort
    LDM SP, {r1, r2, r3}
    mov r6, r0
    b bb0_1
bb0_5:
    cmp r2, r5
    ldr r4, =0
    ldrlt r4, =1
    cmp r2, r5
    blt bb0_6
    b bb0_7
bb0_6:
    b litpool0_0
    .pool
litpool0_0:
    add r7, r5, #0
    ldr r3, Addr0_0
    ldr r4, =4
    mul r6, r7, r4
    add r9, r3, r6
    ldr r4, [r9]
    sub r7, r8, #1
    cmp r4, r7
    ldr r6, =0
    ldrgt r6, =1
    cmp r4, r7
    bgt bb0_8
    b bb0_9
bb0_7:
    cmp r2, r5
    ldr r7, =0
    ldrlt r7, =1
    cmp r2, r5
    blt bb0_10
    Mov r3, r2
    b bb0_11
bb0_8:
    sub r3, r5, #1
    Mov r5, r3
    b bb0_5
bb0_9:
    b bb0_7
bb0_10:
    add r3, r2, #0
    ldr r7, Addr0_0
    ldr r9, =4
    mul r6, r3, r9
    add r4, r7, r6
    add r9, r5, #0
    ldr r3, Addr0_0
    ldr r6, =4
    mul r7, r9, r6
    str r0, [sp, #20]
    add r0, r3, r7
    str r0, [sp, #40]
    ldr r0, [sp, #40]
    ldr r6, [r0]
    str r6, [r4]
    add r9, r2, #1
    ldr r0, [sp, #20]
    Mov r3, r9
    b bb0_11
bb0_11:
    Mov r6, r3
    b bb0_12
bb0_12:
    cmp r6, r5
    ldr r9, =0
    ldrlt r9, =1
    cmp r6, r5
    blt bb0_13
    b bb0_14
bb0_13:
    b litpool0_1
    .pool
litpool0_1:
    add r9, r6, #0
    ldr r3, Addr0_0
    ldr r7, =4
    mul r4, r9, r7
    str r0, [sp, #20]
    add r0, r3, r4
    str r0, [sp, #48]
    ldr r0, [sp, #48]
    ldr r7, [r0]
    cmp r7, r8
    ldr r9, =0
    ldrlt r9, =1
    cmp r7, r8
    ldr r0, [sp, #20]
    blt bb0_15
    b bb0_16
bb0_14:
    cmp r6, r5
    ldr r4, =0
    ldrlt r4, =1
    cmp r6, r5
    blt bb0_17
    Mov r7, r5
    b bb0_18
bb0_15:
    add r4, r6, #1
    Mov r6, r4
    b bb0_12
bb0_16:
    b bb0_14
bb0_17:
    add r3, r5, #0
    ldr r9, Addr0_0
    ldr r4, =4
    mul r7, r3, r4
    str r0, [sp, #20]
    add r0, r9, r7
    str r0, [sp, #36]
    add r4, r6, #0
    ldr r3, Addr0_0
    ldr r7, =4
    mul r9, r4, r7
    add r0, r3, r9
    str r0, [sp, #44]
    ldr r0, [sp, #44]
    ldr r7, [r0]
    ldr r0, [sp, #36]
    str r7, [r0]
    sub r4, r5, #1
    ldr r0, [sp, #20]
    Mov r7, r4
    b bb0_18
bb0_18:
    Mov r2, r6
    Mov r9, r7
    b bb0_2
bb0_19:
    b litpool0_2
    .pool
litpool0_2:
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
    ldr r1, Addr1_1
    ldr r2, =0
    ldr r3, =4
    mul r4, r2, r3
    add r5, r1, r4
    ldr r6, =4
    str r6, [r5]
    ldr r7, Addr1_1
    ldr r8, =1
    ldr r9, =4
    mul r0, r8, r9
    add r2, r7, r0
    ldr r3, =3
    str r3, [r2]
    ldr r1, Addr1_1
    ldr r4, =2
    ldr r5, =4
    mul r6, r4, r5
    add r8, r1, r6
    ldr r9, =9
    str r9, [r8]
    ldr r7, Addr1_1
    ldr r0, =3
    ldr r2, =4
    mul r3, r0, r2
    add r4, r7, r3
    ldr r5, =2
    str r5, [r4]
    ldr r6, Addr1_1
    ldr r1, =4
    ldr r8, =4
    mul r9, r1, r8
    add r0, r6, r9
    ldr r2, =0
    str r2, [r0]
    ldr r3, Addr1_1
    ldr r7, =5
    ldr r4, =4
    mul r5, r7, r4
    add r1, r3, r5
    ldr r8, =1
    str r8, [r1]
    ldr r6, Addr1_1
    ldr r9, =6
    ldr r0, =4
    mul r2, r9, r0
    add r7, r6, r2
    ldr r4, =6
    str r4, [r7]
    ldr r3, Addr1_1
    ldr r5, =7
    ldr r1, =4
    mul r8, r5, r1
    add r9, r3, r8
    ldr r0, =5
    str r0, [r9]
    ldr r6, Addr1_1
    ldr r2, =8
    ldr r7, =4
    mul r4, r2, r7
    add r5, r6, r4
    ldr r1, =7
    str r1, [r5]
    ldr r3, Addr1_1
    ldr r8, =9
    ldr r9, =4
    mul r0, r8, r9
    add r2, r3, r0
    ldr r7, =8
    str r7, [r2]
    ldr r0, =0
    ldr r1, =9
    bl QuickSort
    mov r6, r0
    Mov r4, r6
    b bb1_0
bb1_0:
    ldr r5, Addr1_0
    ldr r5, [r5]
    cmp r4, r5
    ldr r1, =0
    ldrlt r1, =1
    cmp r4, r5
    blt bb1_1
    b bb1_2
bb1_1:
    add r8, r4, #0
    ldr r9, Addr1_1
    ldr r3, =4
    mul r0, r8, r3
    add r2, r9, r0
    ldr r7, [r2]
    mov r0, r7
    bl put_int
    ldr r0, =10
    bl put_char
    add r6, r4, #1
    Mov r4, r6
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

