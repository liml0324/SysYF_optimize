    .arch armv8 
    .text 
    .globl myFunc
    .p2align 2
    .type myFunc, %function
myFunc:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    STMDB SP, {r0}
    Mov r0, r1
    ldr r1, =0
    ldr r2, =0
    cmp r1, r2
    ldr r3, =0
    ldrne r3, =1
    ldr r4, =0
    ldr r5, =0
    cmp r4, r5
    bne bb0_0
    b bb0_1
bb0_0:
    Ldr r2, =0
    b bb0_5
bb0_1:
    Mov r6, r0
    b bb0_2
bb0_2:
    ldr r7, =0
    cmp r6, r7
    ldr r8, =0
    ldrgt r8, =1
    ldr r9, =0
    cmp r6, r9
    bgt bb0_3
    b bb0_4
bb0_3:
    sub r4, r6, #1
    Mov r6, r4
    b bb0_2
bb0_4:
    add r1, r6, #2
    Mov r2, r1
    b bb0_5
bb0_5:
    mov r0, r2
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
    ldr r0, =3
    push {r1}
    ldr r1, Addr1_0
    str r0, [r1]
    pop {r1}
    STM SP, {r1}
    ldr r0, =1
    ldr r1, =2
    ldr r2, =1
    bl myFunc
    LDM SP, {r1}
    mov r1, r0
    ldr r2, Addr1_0
    ldr r2, [r2]
    add r3, r2, r1
    b bb1_0
bb1_0:
    b litpool1_0
    .pool
litpool1_0:
    mov r0, r3
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..a

    .type ..a, %object
    .bss
    .globl ..a
    .p2align 2
..a:
    .long 0
    .size ..a, 4

