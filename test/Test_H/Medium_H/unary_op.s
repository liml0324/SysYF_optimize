    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =56
    ldr r1, =-4
    sub r2, r0, r1
    add r3, r2, #4
    ldr r4, =0
    cmp r3, r4
    ldr r5, =0
    ldreq r5, =1
    mov r6, r5
    ldr r7, =0
    cmp r6, r7
    ldr r8, =0
    ldreq r8, =1
    mov r9, r8
    ldr r0, =0
    cmp r9, r0
    ldr r1, =0
    ldreq r1, =1
    mov r2, r1
    rsb r4, r2, #0
    ldr r3, =0
    cmp r4, r3
    ldr r5, =0
    ldrne r5, =1
    ldr r7, =0
    cmp r4, r7
    bne bb0_0
    b bb0_1
bb0_0:
    Ldr r9, =-1
    b bb0_2
bb0_1:
    ldr r6, =0
    add r8, r6, #4
    Mov r9, r8
    b bb0_2
bb0_2:
    mov r0, r9
    bl put_int
    b bb0_3
bb0_3:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

