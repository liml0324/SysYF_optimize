    .arch armv8 
    .text 
    .globl if_ifElse_
    .p2align 2
    .type if_ifElse_, %function
if_ifElse_:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    ldr r0, =5
    ldr r1, =5
    cmp r0, r1
    ldr r2, =0
    ldreq r2, =1
    ldr r3, =5
    ldr r4, =5
    cmp r3, r4
    beq bb0_0
    Ldr r5, =5
    b bb0_1
bb0_0:
    ldr r6, =10
    ldr r7, =10
    cmp r6, r7
    ldr r8, =0
    ldreq r8, =1
    ldr r9, =10
    ldr r0, =10
    cmp r9, r0
    beq bb0_2
    b bb0_3
bb0_1:
    b bb0_5
bb0_2:
    Ldr r1, =25
    b bb0_4
bb0_3:
    Ldr r1, =20
    b bb0_4
bb0_4:
    Mov r5, r1
    b bb0_1
bb0_5:
    mov r0, r5
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl if_ifElse_
    b bb1_0
bb1_0:
    b litpool1_0
    .pool
litpool1_0:
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

