    .arch armv8 
    .text 
    .globl insertsort
    .p2align 2
    .type insertsort, %function
insertsort:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    Ldr r2, =1
    b bb0_0
bb0_0:
    ldr r3, Addr0_0
    ldr r3, [r3]
    cmp r2, r3
    ldr r4, =0
    ldrlt r4, =1
    cmp r2, r3
    blt bb0_1
    b bb0_2
bb0_1:
    add r5, r2, #0
    ldr r6, Addr0_1
    ldr r7, =4
    mul r8, r5, r7
    add r9, r6, r8
    ldr r0, [r9]
    sub r1, r2, #1
    Mov r3, r1
    b bb0_3
bb0_2:
    b bb0_9
bb0_3:
    ldr r4, =-1
    cmp r3, r4
    ldr r5, =0
    ldrgt r5, =1
    ldr r7, =-1
    cmp r3, r7
    bgt bb0_4
    b bb0_5
bb0_4:
    add r6, r3, #0
    ldr r8, Addr0_1
    ldr r1, =4
    mul r9, r6, r1
    add r4, r8, r9
    ldr r5, [r4]
    cmp r0, r5
    ldr r7, =0
    ldrlt r7, =1
    cmp r0, r5
    blt bb0_6
    b bb0_7
bb0_5:
    add r6, r3, #1
    add r8, r6, #0
    ldr r9, Addr0_1
    ldr r1, =4
    mul r4, r8, r1
    add r5, r9, r4
    str r0, [r5]
    add r7, r2, #1
    Mov r1, r0
    Mov r0, r3
    Mov r2, r7
    b bb0_0
bb0_6:
    add r6, r3, #1
    add r1, r6, #0
    ldr r8, Addr0_1
    ldr r9, =4
    mul r4, r1, r9
    add r5, r8, r4
    add r7, r3, #0
    ldr r6, Addr0_1
    ldr r1, =4
    mul r9, r7, r1
    add r8, r6, r9
    ldr r4, [r8]
    str r4, [r5]
    sub r7, r3, #1
    b bb0_8
bb0_7:
    b litpool0_0
    .pool
litpool0_0:
    b bb0_5
bb0_8:
    Mov r3, r7
    b bb0_3
bb0_9:
    ldr r0, =0
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr0_0:
    .long ..n
Addr0_1:
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
    bl insertsort
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

