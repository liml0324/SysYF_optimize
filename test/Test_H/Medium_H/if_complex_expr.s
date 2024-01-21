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
    ldr r5, =0
    cmp r4, r5
    ldr r6, =0
    ldrlt r6, =1
    ldr r7, =0
    cmp r4, r7
    blt bb0_0
    b bb0_2
bb0_0:
    ldr r0, =2
    bl put_int
    b bb0_1
bb0_1:
    ldr r2, =-2
    ldr r5, =2
    sdiv r7, r2, r5
    ldr r4, =2
    mul r6, r7, r4
    ldr r8, =-2
    sub r0, r8, r6
    add r9, r0, #67
    ldr r1, =0
    cmp r9, r1
    ldr r3, =0
    ldrlt r3, =1
    ldr r2, =0
    cmp r9, r2
    blt bb0_4
    b bb0_6
bb0_2:
    ldr r8, =5
    sub r9, r8, #5
    ldr r0, =0
    cmp r9, r0
    ldr r1, =0
    ldrne r1, =1
    ldr r3, =0
    cmp r9, r3
    bne bb0_3
    b bb0_1
bb0_3:
    ldr r1, =1
    add r3, r1, #3
    ldr r2, =2
    sdiv r5, r3, r2
    ldr r9, =2
    mul r4, r5, r9
    sub r6, r3, r4
    ldr r8, =0
    cmp r6, r8
    ldr r7, =0
    ldrne r7, =1
    ldr r0, =0
    cmp r6, r0
    bne bb0_0
    b bb0_1
bb0_4:
    ldr r0, =4
    bl put_int
    Ldr r0, =4
    b bb0_5
bb0_5:
    b litpool0_0
    .pool
litpool0_0:
    b bb0_8
bb0_6:
    ldr r5, =5
    sub r7, r5, #5
    ldr r4, =0
    cmp r7, r4
    ldr r6, =0
    ldrne r6, =1
    ldr r8, =0
    cmp r7, r8
    bne bb0_7
    Ldr r0, =2
    b bb0_5
bb0_7:
    ldr r1, =1
    add r9, r1, #2
    ldr r3, =2
    sdiv r2, r9, r3
    ldr r5, =2
    mul r4, r2, r5
    sub r7, r9, r4
    ldr r6, =0
    cmp r7, r6
    ldr r8, =0
    ldrne r8, =1
    ldr r0, =0
    cmp r7, r0
    bne bb0_4
    Ldr r0, =2
    b bb0_5
bb0_8:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

