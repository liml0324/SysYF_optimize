    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #76
    ldr r0, =0
    add r1, r0, #0
    add r2, sp, #24
    ldr r3, =4
    mul r4, r1, r3
    add r5, r2, r4
    ldr r6, =1
    str r6, [r5]
    ldr r7, =0
    add r8, r7, #1
    add r9, sp, #24
    ldr r0, =4
    mul r3, r8, r0
    add r1, r9, r3
    ldr r4, =2
    str r4, [r1]
    ldr r2, =0
    add r5, r2, #2
    add r6, sp, #24
    ldr r7, =4
    mul r0, r5, r7
    add r8, r6, r0
    ldr r3, =3
    str r3, [r8]
    ldr r9, =0
    add r1, r9, #3
    add r4, sp, #24
    ldr r2, =4
    mul r5, r1, r2
    add r7, r4, r5
    ldr r6, =4
    str r6, [r7]
    ldr r0, =0
    add r8, r0, #4
    add r3, sp, #24
    ldr r9, =4
    mul r1, r8, r9
    add r2, r3, r1
    ldr r4, =5
    str r4, [r2]
    ldr r5, =-2
    ldr r7, =1
    mul r6, r5, r7
    ldr r0, =2
    sdiv r8, r6, r0
    add r9, r8, #4
    ldr r3, =5
    sub r1, r3, #5
    add r2, r9, r1
    ldr r4, =1
    add r5, r4, #3
    rsb r7, r5, #0
    ldr r6, =2
    sdiv r0, r7, r6
    ldr r8, =2
    mul r3, r0, r8
    sub r9, r7, r3
    sub r1, r2, r9
    ldr r4, =5
    sdiv r5, r1, r4
    ldr r6, =5
    mul r0, r5, r6
    sub r8, r1, r0
    add r7, r8, #0
    add r3, sp, #24
    ldr r2, =4
    mul r9, r7, r2
    add r4, r3, r9
    ldr r5, [r4]
    mov r0, r5
    bl put_int
    ldr r6, =1
    ldr r1, =2
    sdiv r0, r6, r1
    ldr r8, =2
    mul r7, r0, r8
    rsb r2, r7, #1
    add r3, r2, #67
    add r9, r3, #5
    sub r4, r9, #5
    ldr r5, =1
    add r6, r5, #2
    ldr r1, =2
    sdiv r0, r6, r1
    ldr r8, =2
    mul r7, r0, r8
    sub r2, r6, r7
    rsb r3, r2, #0
    sub r9, r4, r3
    ldr r5, =5
    sdiv r1, r9, r5
    ldr r0, =5
    mul r8, r1, r0
    sub r7, r9, r8
    add r6, r7, #0
    add r2, sp, #24
    ldr r4, =4
    mul r3, r6, r4
    add r5, r2, r3
    ldr r1, [r5]
    STM SP, {r1}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r1}
    b bb0_0
bb0_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

