    .arch armv8 
    .text 
    .globl exgcd
    .p2align 2
    .type exgcd, %function
exgcd:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #72
    ldr r4, =0
    cmp r1, r4
    ldr r5, =0
    ldreq r5, =1
    ldr r6, =0
    cmp r1, r6
    beq bb0_0
    b bb0_1
bb0_0:
    add r4, r2, #0
    ldr r7, =0
    ldr r5, =4
    mul r9, r7, r5
    add r8, r4, r9
    ldr r6, =1
    str r6, [r8]
    add r1, r3, #0
    ldr r2, =0
    ldr r7, =4
    mul r5, r2, r7
    add r4, r1, r5
    ldr r9, =0
    str r9, [r4]
    Mov r1, r0
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
    str r0, [sp, #48]
    STM SP, {r0, r1, r2, r3}
    ldr r0, [sp, #4]
    mov r1, r9
    mov r2, r8
    ldr r3, [sp, #48]
    bl exgcd
    LDMIB SP, {r1, r2, r3}
    mov r6, r0
    ldr r0, [SP]
    add r4, r2, #0
    ldr r5, =0
    ldr r7, =4
    mul r9, r5, r7
    add r8, r4, r9
    ldr r5, [r8]
    add r7, r2, #0
    ldr r4, =0
    ldr r9, =4
    mul r8, r4, r9
    add r0, r7, r8
    str r0, [sp, #44]
    add r4, r3, #0
    ldr r9, =0
    ldr r7, =4
    mul r8, r9, r7
    add r0, r4, r8
    str r0, [sp, #52]
    ldr r0, [sp, #52]
    ldr r9, [r0]
    ldr r0, [sp, #44]
    str r9, [r0]
    add r7, r3, #0
    ldr r4, =0
    ldr r8, =4
    mul r9, r4, r8
    add r0, r7, r9
    str r0, [sp, #36]
    ldr r0, [sp, #20]
    sdiv r4, r0, r1
    add r8, r3, #0
    ldr r7, =0
    ldr r9, =4
    mul r1, r7, r9
    str r0, [sp, #20]
    add r0, r8, r1
    str r0, [sp, #40]
    ldr r0, [sp, #40]
    ldr r7, [r0]
    mul r9, r4, r7
    sub r8, r5, r9
    ldr r0, [sp, #36]
    str r8, [r0]
    ldr r0, [sp, #20]
    Mov r1, r6
    b bb0_2
bb0_2:
    mov r0, r1
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
    sub sp, sp, #44
    add r0, sp, #36
    ldr r1, =0
    ldr r2, =4
    mul r3, r1, r2
    add r4, r0, r3
    ldr r5, =1
    str r5, [r4]
    add r6, sp, #40
    ldr r7, =0
    ldr r8, =4
    mul r9, r7, r8
    add r1, r6, r9
    ldr r2, =1
    str r2, [r1]
    add r3, sp, #36
    ldr r0, =0
    ldr r4, =4
    mul r5, r0, r4
    add r7, r3, r5
    add r8, sp, #40
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
    add r4, sp, #36
    ldr r5, =0
    ldr r3, =4
    mul r9, r5, r3
    add r6, r4, r9
    add r8, sp, #36
    ldr r1, =0
    ldr r7, =4
    mul r2, r1, r7
    add r5, r8, r2
    ldr r3, [r5]
    ldr r4, =15
    sdiv r9, r3, r4
    ldr r1, =15
    mul r7, r9, r1
    sub r8, r3, r7
    add r2, r8, #15
    ldr r5, =15
    sdiv r4, r2, r5
    ldr r9, =15
    mul r1, r4, r9
    sub r3, r2, r1
    str r3, [r6]
    add r7, sp, #36
    ldr r8, =0
    ldr r5, =4
    mul r4, r8, r5
    add r9, r7, r4
    ldr r2, [r9]
    STM SP, {r0, r2}
    ldr r0, [sp, #4]
    bl put_int
    LDM sp, {r0, r2}
    b bb1_0
bb1_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

