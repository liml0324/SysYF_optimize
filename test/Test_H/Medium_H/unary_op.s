    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =64
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldreq r2, =1
    mov r3, r2
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
    rsb r0, r9, #0
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldrne r2, =1
    ldr r4, =0
    cmp r0, r4
    bne bb0_0
    b bb0_1
bb0_0:
    Ldr r3, =-1
    b bb0_2
bb0_1:
    Ldr r3, =4
    b bb0_2
bb0_2:
    STM SP, {r3}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r3}
    b bb0_3
bb0_3:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

