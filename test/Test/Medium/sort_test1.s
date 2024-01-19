    .arch armv8 
    .text 
    .globl bubblesort
    .p2align 2
    .type bubblesort, %function
bubblesort:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    Ldr r0, =0
    b bb0_0
bb0_0:
    ldr r1, Addr0_0
    ldr r1, [r1]
    sub r2, r1, #1
    cmp r0, r2
    ldr r3, =0
    ldrlt r3, =1
    cmp r0, r2
    blt bb0_1
    b bb0_2
bb0_1:
    Ldr r4, =0
    b bb0_3
bb0_2:
    b bb0_8
bb0_3:
    ldr r5, Addr0_0
    ldr r5, [r5]
    sub r6, r5, r0
    sub r7, r6, #1
    cmp r4, r7
    ldr r8, =0
    ldrlt r8, =1
    cmp r4, r7
    blt bb0_4
    b bb0_5
bb0_4:
    add r1, r4, #0
    ldr r2, Addr0_1
    ldr r3, =4
    mul r5, r1, r3
    add r6, r2, r5
    ldr r7, [r6]
    add r8, r4, #1
    add r9, r8, #0
    ldr r1, Addr0_1
    ldr r3, =4
    mul r2, r9, r3
    add r5, r1, r2
    ldr r6, [r5]
    cmp r7, r6
    ldr r8, =0
    ldrgt r8, =1
    cmp r7, r6
    bgt bb0_6
    b bb0_7
bb0_5:
    add r9, r0, #1
    Mov r0, r9
    b bb0_0
bb0_6:
    add r3, r4, #1
    add r1, r3, #0
    ldr r2, Addr0_1
    ldr r5, =4
    mul r7, r1, r5
    add r6, r2, r7
    ldr r8, [r6]
    add r9, r4, #1
    add r3, r9, #0
    ldr r1, Addr0_1
    ldr r5, =4
    mul r2, r3, r5
    add r7, r1, r2
    add r6, r4, #0
    ldr r9, Addr0_1
    ldr r3, =4
    mul r5, r6, r3
    add r1, r9, r5
    ldr r2, [r1]
    str r2, [r7]
    add r6, r4, #0
    ldr r3, Addr0_1
    ldr r9, =4
    mul r5, r6, r9
    add r1, r3, r5
    str r8, [r1]
    b bb0_7
bb0_7:
    b litpool0_0
    .pool
litpool0_0:
    add r9, r4, #1
    Mov r4, r9
    b bb0_3
bb0_8:
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
    bl bubblesort
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

