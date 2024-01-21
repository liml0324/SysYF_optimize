    .arch armv8 
    .text 
    .globl select_sort
    .p2align 2
    .type select_sort, %function
select_sort:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #32
    Ldr r2, =0
    Ldr r3, =0
    Ldr r4, =0
    b bb0_0
bb0_0:
    sub r5, r1, #1
    cmp r4, r5
    ldr r6, =0
    ldrlt r6, =1
    cmp r4, r5
    blt bb0_1
    b bb0_2
bb0_1:
    add r7, r4, #1
    Mov r8, r4
    Mov r9, r7
    b bb0_3
bb0_2:
    b bb0_10
bb0_3:
    cmp r9, r1
    ldr r5, =0
    ldrlt r5, =1
    cmp r9, r1
    blt bb0_4
    b bb0_5
bb0_4:
    add r7, r8, #0
    add r2, r0, #0
    ldr r6, =4
    mul r5, r7, r6
    add r3, r2, r5
    ldr r7, [r3]
    add r6, r9, #0
    add r2, r0, #0
    ldr r5, =4
    mul r3, r6, r5
    str r0, [sp]
    add r0, r2, r3
    str r0, [sp, #12]
    ldr r0, [sp, #12]
    ldr r6, [r0]
    cmp r7, r6
    ldr r5, =0
    ldrgt r5, =1
    cmp r7, r6
    ldr r0, [sp]
    bgt bb0_6
    Mov r2, r8
    b bb0_7
bb0_5:
    cmp r8, r4
    ldr r6, =0
    ldrne r6, =1
    cmp r8, r4
    bne bb0_8
    b bb0_9
bb0_6:
    Mov r2, r9
    b bb0_7
bb0_7:
    b litpool0_0
    .pool
litpool0_0:
    add r3, r9, #1
    Mov r8, r2
    Mov r9, r3
    b bb0_3
bb0_8:
    add r3, r8, #0
    add r7, r0, #0
    ldr r5, =4
    mul r6, r3, r5
    add r2, r7, r6
    ldr r3, [r2]
    add r5, r8, #0
    add r7, r0, #0
    ldr r6, =4
    mul r2, r5, r6
    str r0, [sp]
    add r0, r7, r2
    str r0, [sp, #16]
    add r5, r4, #0
    ldr r0, [sp]
    add r6, r0, #0
    ldr r7, =4
    mul r2, r5, r7
    str r0, [sp]
    add r0, r6, r2
    str r0, [sp, #4]
    ldr r0, [sp, #4]
    ldr r5, [r0]
    ldr r0, [sp, #16]
    str r5, [r0]
    add r7, r4, #0
    ldr r0, [sp]
    add r6, r0, #0
    ldr r2, =4
    mul r5, r7, r2
    str r0, [sp]
    add r0, r6, r5
    str r0, [sp, #8]
    ldr r0, [sp, #8]
    str r3, [r0]
    ldr r0, [sp]
    b bb0_9
bb0_9:
    add r2, r4, #1
    Mov r3, r9
    Mov r4, r2
    Mov r2, r8
    b bb0_0
bb0_10:
    ldr r0, =0
    add sp, sp, #32
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

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
    ldr r6, Addr1_0
    ldr r6, [r6]
    STM SP, {r3}
    ldr r0, [sp]
    mov r1, r6
    bl select_sort
    LDM SP, {r3}
    mov r8, r0
    Mov r7, r8
    b bb1_0
bb1_0:
    ldr r1, Addr1_0
    ldr r1, [r1]
    cmp r7, r1
    ldr r9, =0
    ldrlt r9, =1
    cmp r7, r1
    blt bb1_1
    b bb1_2
bb1_1:
    b litpool1_0
    .pool
litpool1_0:
    add r5, r7, #0
    add r0, sp, #44
    ldr r2, =4
    mul r4, r5, r2
    add r6, r0, r4
    ldr r3, [r6]
    STM SP, {r3}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r3}
    ldr r0, =10
    bl put_char
    add r8, r7, #1
    Mov r7, r8
    b bb1_0
bb1_2:
    b bb1_3
bb1_3:
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

