    .arch armv8 
    .text 
    .globl bubblesort
    .p2align 2
    .type bubblesort, %function
bubblesort:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    Ldr r1, =0
    Ldr r2, =0
    b bb0_0
bb0_0:
    ldr r3, Addr0_0
    ldr r3, [r3]
    sub r4, r3, #1
    cmp r2, r4
    ldr r5, =0
    ldrlt r5, =1
    cmp r2, r4
    blt bb0_1
    b bb0_2
bb0_1:
    Ldr r6, =0
    b bb0_3
bb0_2:
    b bb0_8
bb0_3:
    ldr r7, Addr0_0
    ldr r7, [r7]
    sub r8, r7, r2
    sub r9, r8, #1
    cmp r6, r9
    ldr r3, =0
    ldrlt r3, =1
    cmp r6, r9
    blt bb0_4
    b bb0_5
bb0_4:
    add r1, r6, #0
    add r4, r0, #0
    ldr r7, =4
    mul r8, r1, r7
    add r9, r4, r8
    ldr r3, [r9]
    add r5, r6, #1
    add r1, r5, #0
    add r7, r0, #0
    ldr r4, =4
    mul r8, r1, r4
    add r9, r7, r8
    ldr r5, [r9]
    cmp r3, r5
    ldr r1, =0
    ldrgt r1, =1
    cmp r3, r5
    bgt bb0_6
    b bb0_7
bb0_5:
    add r5, r2, #1
    Mov r1, r6
    Mov r2, r5
    b bb0_0
bb0_6:
    add r7, r6, #1
    add r8, r7, #0
    add r9, r0, #0
    ldr r3, =4
    mul r5, r8, r3
    add r1, r9, r5
    ldr r4, [r1]
    add r7, r6, #1
    add r8, r7, #0
    add r3, r0, #0
    ldr r9, =4
    mul r5, r8, r9
    add r1, r3, r5
    add r7, r6, #0
    add r8, r0, #0
    ldr r9, =4
    mul r3, r7, r9
    add r5, r8, r3
    ldr r7, [r5]
    str r7, [r1]
    add r9, r6, #0
    add r8, r0, #0
    ldr r3, =4
    mul r5, r9, r3
    add r7, r8, r5
    str r4, [r7]
    b bb0_7
bb0_7:
    b litpool0_0
    .pool
litpool0_0:
    add r4, r6, #1
    Mov r6, r4
    b bb0_3
bb0_8:
    ldr r0, =0
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr0_0:
    .long ..n

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #116
    ldr r0, =10
    push {r1}
    ldr r1, Addr1_0
    str r0, [r1]
    pop {r1}
    ldr r1, =0
    add r2, r1, #0
    add r3, sp, #44
    ldr r4, =4
    mul r5, r2, r4
    add r6, r3, r5
    ldr r7, =4
    str r7, [r6]
    ldr r8, =0
    add r9, r8, #1
    add r0, sp, #44
    ldr r1, =4
    mul r2, r9, r1
    add r4, r0, r2
    ldr r3, =3
    str r3, [r4]
    ldr r5, =0
    add r6, r5, #2
    add r7, sp, #44
    ldr r8, =4
    mul r9, r6, r8
    add r1, r7, r9
    ldr r0, =9
    str r0, [r1]
    ldr r2, =0
    add r4, r2, #3
    add r3, sp, #44
    ldr r5, =4
    mul r8, r4, r5
    add r6, r3, r8
    ldr r9, =2
    str r9, [r6]
    ldr r7, =0
    add r1, r7, #4
    add r0, sp, #44
    ldr r2, =4
    mul r5, r1, r2
    add r4, r0, r5
    ldr r8, =0
    str r8, [r4]
    ldr r3, =0
    add r6, r3, #5
    add r9, sp, #44
    ldr r7, =4
    mul r1, r6, r7
    add r2, r9, r1
    ldr r0, =1
    str r0, [r2]
    ldr r5, =0
    add r4, r5, #6
    add r8, sp, #44
    ldr r3, =4
    mul r6, r4, r3
    add r7, r8, r6
    ldr r9, =6
    str r9, [r7]
    ldr r1, =0
    add r2, r1, #7
    add r0, sp, #44
    ldr r5, =4
    mul r4, r2, r5
    add r3, r0, r4
    ldr r8, =5
    str r8, [r3]
    ldr r6, =0
    add r7, r6, #8
    add r9, sp, #44
    ldr r1, =4
    mul r2, r7, r1
    add r5, r9, r2
    ldr r0, =7
    str r0, [r5]
    ldr r4, =0
    add r3, r4, #9
    add r8, sp, #44
    ldr r6, =4
    mul r7, r3, r6
    add r1, r8, r7
    ldr r9, =8
    str r9, [r1]
    add r2, sp, #44
    ldr r5, =0
    ldr r0, =4
    mul r4, r5, r0
    add r3, r2, r4
    STM SP, {r3}
    ldr r0, [sp]
    bl bubblesort
    LDM SP, {r3}
    mov r6, r0
    Mov r8, r6
    b bb1_0
bb1_0:
    ldr r7, Addr1_0
    ldr r7, [r7]
    cmp r8, r7
    ldr r1, =0
    ldrlt r1, =1
    cmp r8, r7
    blt bb1_1
    b bb1_2
bb1_1:
    add r9, r8, #0
    add r5, sp, #44
    ldr r0, =4
    mul r2, r9, r0
    add r4, r5, r2
    ldr r3, [r4]
    STM SP, {r3}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r3}
    ldr r0, =10
    bl put_char
    add r6, r8, #1
    Mov r8, r6
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

    .type ..n, %object
    .bss
    .globl ..n
    .p2align 2
..n:
    .long 0
    .size ..n, 4

