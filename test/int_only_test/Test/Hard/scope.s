    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =3389
    push {r1}
    ldr r1, Addr0_0
    str r0, [r1]
    pop {r1}
    ldr r1, Addr0_0
    ldr r1, [r1]
    ldr r2, =10000
    cmp r1, r2
    ldr r3, =0
    ldrlt r3, =1
    ldr r4, =10000
    cmp r1, r4
    blt bb0_0
    b bb0_1
bb0_0:
    ldr r6, Addr0_0
    ldr r6, [r6]
    add r7, r6, #1
    push {r0}
    ldr r0, Addr0_0
    str r7, [r0]
    pop {r0}
    Ldr r8, =112
    b bb0_2
bb0_1:
    ldr r5, Addr0_0
    ldr r5, [r5]
    b bb0_7
bb0_2:
    ldr r9, =10
    cmp r8, r9
    ldr r0, =0
    ldrgt r0, =1
    ldr r2, =10
    cmp r8, r2
    bgt bb0_3
    b bb0_4
bb0_3:
    sub r1, r8, #88
    ldr r3, =1000
    cmp r1, r3
    ldr r4, =0
    ldrlt r4, =1
    ldr r5, =1000
    cmp r1, r5
    blt bb0_5
    Mov r6, r1
    b bb0_6
bb0_4:
    mov r0, r8
    bl put_int
    b bb0_1
bb0_5:
    b litpool0_0
    .pool
litpool0_0:
    sub r7, r1, #10
    add r9, r7, #11
    add r0, r9, #11
    Mov r6, r0
    b bb0_6
bb0_6:
    Mov r8, r6
    b bb0_2
bb0_7:
    mov r0, r5
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr0_0:
    .long ..k

    .type ..k, %object
    .bss
    .globl ..k
    .p2align 2
..k:
    .long 0
    .size ..k, 4

