    .arch armv8 
    .text 
    .globl get_ans_se
    .p2align 2
    .type get_ans_se, %function
get_ans_se:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    cmp r1, r2
    ldr r3, =0
    ldreq r3, =1
    cmp r1, r2
    beq bb0_0
    Ldr r4, =0
    b bb0_1
bb0_0:
    Ldr r4, =1
    b bb0_1
bb0_1:
    ldr r5, =2
    mul r6, r0, r5
    add r7, r6, r4
    ldr r8, Addr0_0
    ldr r8, [r8]
    add r9, r8, r7
    push {r0}
    ldr r0, Addr0_0
    str r9, [r0]
    pop {r0}
    b bb0_2
bb0_2:
    mov r0, r7
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr0_0:
    .long ..s

    .globl get_ans
    .p2align 2
    .type get_ans, %function
get_ans:
    push {r4, r5, r6, r7, lr}
    sub sp, sp, #16
    cmp r1, r2
    ldr r3, =0
    ldreq r3, =1
    cmp r1, r2
    beq bb1_0
    Ldr r4, =0
    b bb1_1
bb1_0:
    Ldr r4, =1
    b bb1_1
bb1_1:
    ldr r5, =2
    mul r6, r0, r5
    add r7, r6, r4
    b bb1_2
bb1_2:
    mov r0, r7
    add sp, sp, #16
    pop {r4, r5, r6, r7, lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    ldr r0, =0
    ldr r1, =-2147483648
    ldr r2, =-2147483648
    bl get_ans
    STM SP, {r0, r1}
    ldr r0, [sp]
    ldr r1, =-2147483647
    ldr r2, =-2147483647
    bl get_ans
    LDMIB SP, {r1}
    mov r1, r0
    ldr r0, [SP]
    STM SP, {r1, r2}
    ldr r0, [sp]
    ldr r1, =-2147483648
    ldr r2, =-2147483648
    bl get_ans
    LDM SP, {r1, r2}
    mov r2, r0
    STM SP, {r2, r3}
    ldr r0, [sp]
    ldr r1, =-2147483648
    ldr r2, =2147483647
    bl get_ans
    LDM SP, {r2, r3}
    mov r3, r0
    STM SP, {r3}
    ldr r0, [sp]
    ldr r1, =-1073741824
    ldr r2, =-1073741823
    bl get_ans
    LDM SP, {r3}
    mov r4, r0
    mov r0, r4
    ldr r1, =-2147483648
    ldr r2, =-2147483648
    bl get_ans
    mov r5, r0
    mov r0, r5
    ldr r1, =-2147483648
    ldr r2, =2147483647
    bl get_ans
    mov r6, r0
    ldr r0, =0
    ldr r1, =-2147483647
    ldr r2, =2147483647
    bl get_ans
    mov r7, r0
    mov r0, r7
    ldr r1, =-2147483647
    ldr r2, =2147483646
    bl get_ans
    mov r8, r0
    mov r0, r8
    ldr r1, =2147483647
    ldr r2, =2147483646
    bl get_ans
    mov r9, r0
    STM SP, {r0}
    mov r0, r9
    ldr r1, =-1073741824
    ldr r2, =-1073741824
    bl get_ans
    STM SP, {r0, r1}
    ldr r0, =0
    ldr r1, =-2147483648
    ldr r2, =-2147483648
    bl get_ans_se
    LDMIB SP, {r1}
    mov r1, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2}
    ldr r0, [sp, #4]
    ldr r1, =-2147483647
    ldr r2, =-2147483647
    bl get_ans_se
    LDMIB SP, {r1, r2}
    mov r2, r0
    ldr r0, [SP]
    STM SP, {r0, r2, r3}
    ldr r0, [sp, #4]
    ldr r1, =-2147483648
    ldr r2, =-2147483648
    bl get_ans_se
    LDMIB SP, {r2, r3}
    mov r3, r0
    ldr r0, [SP]
    STM SP, {r0, r3}
    ldr r0, [sp, #4]
    ldr r1, =-2147483648
    ldr r2, =2147483647
    bl get_ans_se
    LDMIB SP, {r3}
    mov r4, r0
    ldr r0, [SP]
    STM SP, {r0}
    mov r0, r4
    ldr r1, =-1073741824
    ldr r2, =-1073741823
    bl get_ans_se
    mov r5, r0
    ldr r0, [SP]
    STM SP, {r0}
    mov r0, r5
    ldr r1, =-2147483648
    ldr r2, =-2147483648
    bl get_ans_se
    mov r7, r0
    ldr r0, [SP]
    STM SP, {r0}
    mov r0, r7
    ldr r1, =-2147483648
    ldr r2, =2147483647
    bl get_ans_se
    mov r8, r0
    ldr r0, [SP]
    STM SP, {r0}
    ldr r0, =0
    ldr r1, =-2147483647
    ldr r2, =2147483647
    bl get_ans_se
    mov r9, r0
    ldr r0, [SP]
    STM SP, {r0, r1}
    mov r0, r9
    ldr r1, =-2147483647
    ldr r2, =2147483646
    bl get_ans_se
    LDMIB SP, {r1}
    mov r1, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2}
    ldr r0, [sp, #4]
    ldr r1, =2147483647
    ldr r2, =2147483646
    bl get_ans_se
    LDMIB SP, {r1, r2}
    mov r2, r0
    ldr r0, [SP]
    STM SP, {r0, r2, r3}
    ldr r0, [sp, #4]
    ldr r1, =-1073741824
    ldr r2, =-1073741824
    bl get_ans_se
    LDMIB SP, {r2, r3}
    mov r3, r0
    ldr r0, [SP]
    add r4, r6, r0
    add r5, r4, r8
    add r7, r5, r3
    b bb2_0
bb2_0:
    b litpool2_0
    .pool
litpool2_0:
    mov r0, r7
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

    .type ..s, %object
    .bss
    .globl ..s
    .p2align 2
..s:
    .long 0
    .size ..s, 4

