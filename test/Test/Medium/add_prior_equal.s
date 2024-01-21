    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =28
    add r1, r0, #1
    ldr r2, =4
    cmp r1, r2
    ldr r3, =0
    ldrne r3, =1
    ldr r4, =4
    cmp r1, r4
    bne bb0_0
    b bb0_1
bb0_0:
    ldr r6, =0
    sub r8, r6, #4
    ldr r9, =28
    sdiv r0, r9, r8
    mul r2, r0, r8
    rsb r4, r2, #28
    mov r0, r4
    bl put_int
    b bb0_1
bb0_1:
    ldr r5, =4
    sub r6, r5, #28
    ldr r7, =1
    cmp r6, r7
    ldr r8, =0
    ldreq r8, =1
    ldr r9, =1
    cmp r6, r9
    beq bb0_2
    b bb0_3
bb0_2:
    ldr r0, =28
    ldr r2, =4
    sdiv r4, r0, r2
    ldr r1, =4
    mul r3, r4, r1
    rsb r5, r3, #28
    add r7, r5, #4
    mov r0, r7
    bl put_int
    b bb0_3
bb0_3:
    b bb0_4
bb0_4:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

