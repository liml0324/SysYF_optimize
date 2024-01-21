    .arch armv8 
    .text 
    .globl exgcd
    .p2align 2
    .type exgcd, %function
exgcd:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #56
    ldr r4, =0
    cmp r1, r4
    ldr r5, =0
    ldreq r5, =1
    ldr r6, =0
    cmp r1, r6
    beq bb0_0
    b bb0_1
bb0_0:
    ldr r8, =0
    add r7, r8, #0
    add r5, r2, #0
    ldr r1, =4
    mul r9, r7, r1
    add r6, r5, r9
    ldr r4, =1
    str r4, [r6]
    ldr r8, =0
    add r2, r8, #0
    add r7, r3, #0
    ldr r1, =4
    mul r5, r2, r1
    add r9, r7, r5
    ldr r6, =0
    str r6, [r9]
    Mov r4, r0
    b bb0_2
bb0_1:
    sdiv r7, r0, r1
    mul r8, r7, r1
    sub r9, r0, r8
    add r4, r2, #0
    ldr r5, =0
    ldr r6, =4
    mul r7, r5, r6
    add r8, r4, r7
    add r5, r3, #0
    ldr r6, =0
    ldr r4, =4
    mul r7, r6, r4
    str r0, [sp, #20]
    add r0, r5, r7
    str r0, [sp, #8]
    STM SP, {r0, r1, r2, r3}
    ldr r0, [sp, #4]
    mov r1, r9
    mov r2, r8
    ldr r3, [sp, #8]
    bl exgcd
    LDMIB SP, {r1, r2, r3}
    mov r6, r0
    ldr r0, [SP]
    ldr r4, =0
    add r5, r4, #0
    add r7, r2, #0
    ldr r9, =4
    mul r8, r5, r9
    add r4, r7, r8
    ldr r5, [r4]
    ldr r9, =0
    add r7, r9, #0
    add r8, r2, #0
    ldr r4, =4
    mul r9, r7, r4
    add r0, r8, r9
    str r0, [sp, #16]
    ldr r7, =0
    add r4, r7, #0
    add r8, r3, #0
    ldr r9, =4
    mul r7, r4, r9
    add r0, r8, r7
    str r0, [sp, #20]
    ldr r0, [sp, #20]
    ldr r4, [r0]
    ldr r0, [sp, #16]
    str r4, [r0]
    ldr r9, =0
    add r8, r9, #0
    add r7, r3, #0
    ldr r4, =4
    mul r9, r8, r4
    add r0, r7, r9
    str r0, [sp, #4]
    ldr r0, [sp, #20]
    sdiv r8, r0, r1
    ldr r4, =0
    add r7, r4, #0
    add r9, r3, #0
    ldr r1, =4
    mul r4, r7, r1
    str r0, [sp, #20]
    add r0, r9, r4
    str r0, [sp, #12]
    ldr r0, [sp, #12]
    ldr r7, [r0]
    mul r1, r8, r7
    sub r9, r5, r1
    ldr r0, [sp, #4]
    str r9, [r0]
    ldr r0, [sp, #20]
    Mov r4, r6
    b bb0_2
bb0_2:
    mov r0, r4
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
    sub sp, sp, #52
    add r0, sp, #12
    ldr r1, =0
    ldr r2, =4
    mul r3, r1, r2
    add r4, r0, r3
    ldr r5, =1
    str r5, [r4]
    add r6, sp, #16
    ldr r7, =0
    ldr r8, =4
    mul r9, r7, r8
    add r1, r6, r9
    ldr r2, =1
    str r2, [r1]
    add r3, sp, #12
    ldr r0, =0
    ldr r4, =4
    mul r5, r0, r4
    add r7, r3, r5
    add r8, sp, #16
    ldr r9, =0
    ldr r6, =4
    mul r1, r9, r6
    add r2, r8, r1
    STM SP, {r0, r2}
    ldr r0, =7
    ldr r1, =15
    mov r2, r7
    ldr r3, [sp, #4]
    bl exgcd
    LDMIB SP, {r2}
    ldr r4, =0
    add r5, r4, #0
    add r3, sp, #12
    ldr r9, =4
    mul r6, r5, r9
    add r8, r3, r6
    ldr r1, =0
    add r7, r1, #0
    add r2, sp, #12
    ldr r4, =4
    mul r5, r7, r4
    add r9, r2, r5
    ldr r3, [r9]
    ldr r6, =15
    sdiv r1, r3, r6
    ldr r7, =15
    mul r4, r1, r7
    sub r2, r3, r4
    add r5, r2, #15
    ldr r9, =15
    sdiv r6, r5, r9
    ldr r1, =15
    mul r7, r6, r1
    sub r3, r5, r7
    str r3, [r8]
    ldr r4, =0
    add r2, r4, #0
    add r9, sp, #12
    ldr r6, =4
    mul r1, r2, r6
    add r5, r9, r1
    ldr r7, [r5]
    STM SP, {r0}
    mov r0, r7
    bl put_int
    LDM sp, {r0}
    b bb1_0
bb1_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

