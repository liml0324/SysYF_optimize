    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =-2
    ldr r1, =1
    mul r2, r0, r1
    ldr r3, =2
    sdiv r4, r2, r3
    ldr r5, =5
    sub r6, r5, #5
    add r7, r4, r6
    ldr r8, =1
    add r9, r8, #3
    rsb r0, r9, #0
    ldr r1, =2
    sdiv r3, r0, r1
    ldr r2, =2
    mul r5, r3, r2
    sub r6, r0, r5
    sub r4, r7, r6
    mov r0, r4
    bl put_int
    ldr r8, =-2
    ldr r9, =2
    sdiv r1, r8, r9
    ldr r3, =2
    mul r2, r1, r3
    ldr r0, =-2
    sub r5, r0, r2
    add r7, r5, #67
    ldr r6, =5
    sub r4, r6, #5
    rsb r8, r4, #0
    add r9, r7, r8
    ldr r1, =1
    add r3, r1, #2
    ldr r2, =2
    sdiv r0, r3, r2
    ldr r5, =2
    mul r6, r0, r5
    sub r4, r3, r6
    rsb r7, r4, #0
    sub r8, r9, r7
    add r1, r8, #3
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

