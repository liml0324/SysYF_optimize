    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =29
    ldr r1, =4
    cmp r0, r1
    ldr r2, =0
    ldrne r2, =1
    ldr r3, =29
    ldr r4, =4
    cmp r3, r4
    bne bb0_0
    b bb0_1
bb0_0:
    ldr r0, =0
    bl put_int
    b bb0_1
bb0_1:
    ldr r5, =-24
    ldr r6, =1
    cmp r5, r6
    ldr r7, =0
    ldreq r7, =1
    ldr r8, =-24
    ldr r9, =1
    cmp r8, r9
    beq bb0_2
    b bb0_3
bb0_2:
    ldr r0, =4
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

