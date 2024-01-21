    .arch armv8 
    .text 
    .globl swap
    .p2align 2
    .type swap, %function
swap:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #28
    add r3, r1, #0
    add r4, r0, #0
    ldr r5, =4
    mul r6, r3, r5
    add r7, r4, r6
    ldr r8, [r7]
    add r9, r1, #0
    add r3, r0, #0
    ldr r5, =4
    mul r4, r9, r5
    add r6, r3, r4
    add r7, r2, #0
    add r1, r0, #0
    ldr r9, =4
    mul r5, r7, r9
    add r3, r1, r5
    ldr r4, [r3]
    str r4, [r6]
    add r7, r2, #0
    add r9, r0, #0
    ldr r1, =4
    mul r5, r7, r1
    add r3, r9, r5
    str r8, [r3]
    b bb0_0
bb0_0:
    ldr r0, =0
    add sp, sp, #28
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl heap_ajust
    .p2align 2
    .type heap_ajust, %function
heap_ajust:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #52
    ldr r3, =2
    mul r4, r1, r3
    add r5, r4, #1
    Mov r6, r5
    Mov r7, r1
    b bb1_0
bb1_0:
    add r8, r2, #1
    cmp r6, r8
    ldr r9, =0
    ldrlt r9, =1
    cmp r6, r8
    blt bb1_1
    b bb1_2
bb1_1:
    cmp r6, r2
    ldr r4, =0
    ldrlt r4, =1
    cmp r6, r2
    blt bb1_5
    Mov r1, r6
    b bb1_4
bb1_2:
    Ldr r3, =0
    b bb1_8
bb1_3:
    add r5, r6, #1
    Mov r1, r5
    b bb1_4
bb1_4:
    b litpool1_0
    .pool
litpool1_0:
    add r5, r7, #0
    add r8, r0, #0
    ldr r9, =4
    mul r3, r5, r9
    add r4, r8, r3
    ldr r5, [r4]
    add r9, r1, #0
    add r8, r0, #0
    ldr r3, =4
    mul r4, r9, r3
    str r0, [sp, #20]
    add r0, r8, r4
    str r0, [sp, #36]
    ldr r0, [sp, #36]
    ldr r9, [r0]
    cmp r5, r9
    ldr r3, =0
    ldrgt r3, =1
    cmp r5, r9
    ldr r0, [sp, #20]
    bgt bb1_6
    b bb1_7
bb1_5:
    add r3, r6, #0
    add r5, r0, #0
    ldr r8, =4
    mul r4, r3, r8
    add r9, r5, r4
    ldr r1, [r9]
    add r3, r6, #1
    add r8, r3, #0
    add r5, r0, #0
    ldr r4, =4
    mul r9, r8, r4
    add r3, r5, r9
    ldr r8, [r3]
    cmp r1, r8
    ldr r4, =0
    ldrlt r4, =1
    cmp r1, r8
    blt bb1_3
    Mov r1, r6
    b bb1_4
bb1_6:
    Ldr r3, =0
    b bb1_8
bb1_7:
    add r8, r0, #0
    ldr r4, =0
    ldr r5, =4
    mul r9, r4, r5
    add r3, r8, r9
    STM SP, {r0, r1, r2, r3}
    ldr r0, [sp, #12]
    mov r1, r7
    ldr r2, [sp, #4]
    bl swap
    LDMIB SP, {r1, r2, r3}
    mov r4, r0
    ldr r0, [SP]
    ldr r5, =2
    mul r8, r1, r5
    add r9, r8, #1
    Mov r6, r9
    Mov r7, r1
    b bb1_0
bb1_8:
    mov r0, r3
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

    .globl heap_sort
    .p2align 2
    .type heap_sort, %function
heap_sort:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #48
    ldr r2, =2
    sdiv r3, r1, r2
    sub r4, r3, #1
    Mov r5, r4
    b bb2_0
bb2_0:
    b litpool2_0
    .pool
litpool2_0:
    ldr r6, =-1
    cmp r5, r6
    ldr r7, =0
    ldrgt r7, =1
    ldr r8, =-1
    cmp r5, r8
    bgt bb2_1
    b bb2_2
bb2_1:
    sub r9, r1, #1
    add r4, r0, #0
    ldr r8, =0
    ldr r2, =4
    mul r6, r8, r2
    add r7, r4, r6
    STM SP, {r0, r1, r3}
    mov r0, r7
    mov r1, r5
    mov r2, r9
    bl heap_ajust
    LDMIB SP, {r1, r3}
    mov r3, r0
    ldr r0, [SP]
    sub r8, r5, #1
    Mov r5, r8
    b bb2_0
bb2_2:
    sub r9, r1, #1
    Mov r2, r9
    b bb2_3
bb2_3:
    ldr r3, =0
    cmp r2, r3
    ldr r4, =0
    ldrgt r4, =1
    ldr r6, =0
    cmp r2, r6
    bgt bb2_4
    b bb2_5
bb2_4:
    add r7, r0, #0
    ldr r8, =0
    ldr r9, =4
    mul r3, r8, r9
    add r4, r7, r3
    STM SP, {r0, r2}
    mov r0, r4
    ldr r1, =0
    ldr r2, [sp, #4]
    bl swap
    LDMIB SP, {r2}
    mov r6, r0
    ldr r0, [SP]
    sub r8, r2, #1
    add r9, r0, #0
    ldr r7, =0
    ldr r3, =4
    mul r4, r7, r3
    str r0, [sp, #20]
    add r0, r9, r4
    str r0, [sp, #36]
    STM SP, {r0, r2}
    ldr r0, [sp, #36]
    ldr r1, =0
    mov r2, r8
    bl heap_ajust
    LDMIB SP, {r2}
    mov r7, r0
    ldr r0, [SP]
    sub r3, r2, #1
    ldr r0, [sp, #20]
    Mov r2, r3
    b bb2_3
bb2_5:
    b bb2_6
bb2_6:
    b litpool2_1
    .pool
litpool2_1:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #76
    ldr r0, =10
    push {r1}
    ldr r1, Addr3_0
    str r0, [r1]
    pop {r1}
    add r1, sp, #36
    ldr r2, =0
    ldr r3, =4
    mul r4, r2, r3
    add r5, r1, r4
    ldr r6, =4
    str r6, [r5]
    add r7, sp, #36
    ldr r8, =1
    ldr r9, =4
    mul r0, r8, r9
    add r2, r7, r0
    ldr r3, =3
    str r3, [r2]
    add r1, sp, #36
    ldr r4, =2
    ldr r5, =4
    mul r6, r4, r5
    add r8, r1, r6
    ldr r9, =9
    str r9, [r8]
    add r7, sp, #36
    ldr r0, =3
    ldr r2, =4
    mul r3, r0, r2
    add r4, r7, r3
    ldr r5, =2
    str r5, [r4]
    add r6, sp, #36
    ldr r1, =4
    ldr r8, =4
    mul r9, r1, r8
    add r0, r6, r9
    ldr r2, =0
    str r2, [r0]
    add r3, sp, #36
    ldr r7, =5
    ldr r4, =4
    mul r5, r7, r4
    add r1, r3, r5
    ldr r8, =1
    str r8, [r1]
    add r6, sp, #36
    ldr r9, =6
    ldr r0, =4
    mul r2, r9, r0
    add r7, r6, r2
    ldr r4, =6
    str r4, [r7]
    add r3, sp, #36
    ldr r5, =7
    ldr r1, =4
    mul r8, r5, r1
    add r9, r3, r8
    ldr r0, =5
    str r0, [r9]
    add r6, sp, #36
    ldr r2, =8
    ldr r7, =4
    mul r4, r2, r7
    add r5, r6, r4
    ldr r1, =7
    str r1, [r5]
    add r3, sp, #36
    ldr r8, =9
    ldr r9, =4
    mul r0, r8, r9
    add r2, r3, r0
    ldr r7, =8
    str r7, [r2]
    add r6, sp, #36
    ldr r4, =0
    ldr r5, =4
    mul r1, r4, r5
    add r8, r6, r1
    ldr r9, Addr3_0
    ldr r9, [r9]
    STM SP, {r3}
    mov r0, r8
    mov r1, r9
    bl heap_sort
    LDM SP, {r3}
    mov r3, r0
    Mov r0, r3
    b bb3_0
bb3_0:
    ldr r2, Addr3_0
    ldr r2, [r2]
    cmp r0, r2
    ldr r7, =0
    ldrlt r7, =1
    cmp r0, r2
    blt bb3_1
    b bb3_2
bb3_1:
    add r4, r0, #0
    add r5, sp, #36
    ldr r6, =4
    mul r1, r4, r6
    add r9, r5, r1
    ldr r8, [r9]
    STM SP, {r0}
    mov r0, r8
    bl put_int
    LDM sp, {r0}
    STM SP, {r0}
    ldr r0, =10
    bl put_char
    LDM sp, {r0}
    add r3, r0, #1
    Mov r0, r3
    b bb3_0
bb3_2:
    b bb3_3
bb3_3:
    b litpool3_0
    .pool
litpool3_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr3_0:
    .long ..n

    .type ..n, %object
    .bss
    .globl ..n
    .p2align 2
..n:
    .long 0
    .size ..n, 4

