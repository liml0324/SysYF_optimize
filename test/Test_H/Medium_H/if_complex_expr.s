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
    ldr r1, =2
    sdiv r2, r0, r1
    ldr r3, =0
    cmp r2, r3
    ldr r4, =0
    ldrlt r4, =1
    ldr r5, =0
    cmp r2, r5
    blt bb0_0
    b bb0_2
bb0_0:
    ldr r0, =2
    bl put_int
    b bb0_1
bb0_1:
    ldr r1, =67
    ldr r3, =0
    cmp r1, r3
    ldr r5, =0
    ldrlt r5, =1
    ldr r2, =67
    ldr r4, =0
    cmp r2, r4
    blt bb0_4
    b bb0_6
bb0_2:
    ldr r6, =0
    ldr r7, =0
    cmp r6, r7
    ldr r8, =0
    ldrne r8, =1
    ldr r9, =0
    ldr r0, =0
    cmp r9, r0
    bne bb0_3
    b bb0_1
bb0_3:
    ldr r6, =0
    ldr r7, =0
    cmp r6, r7
    ldr r8, =0
    ldrne r8, =1
    ldr r9, =0
    ldr r0, =0
    cmp r9, r0
    bne bb0_0
    b bb0_1
bb0_4:
    ldr r0, =4
    bl put_int
    b bb0_5
bb0_5:
    b bb0_8
bb0_6:
    b litpool0_0
    .pool
litpool0_0:
    ldr r6, =0
    ldr r7, =0
    cmp r6, r7
    ldr r8, =0
    ldrne r8, =1
    ldr r9, =0
    ldr r0, =0
    cmp r9, r0
    bne bb0_7
    b bb0_5
bb0_7:
    ldr r1, =1
    ldr r3, =0
    cmp r1, r3
    ldr r5, =0
    ldrne r5, =1
    ldr r2, =1
    ldr r4, =0
    cmp r2, r4
    bne bb0_4
    b bb0_5
bb0_8:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

