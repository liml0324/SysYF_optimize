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
    ldr r7, Addr0_0
    ldr r7, [r7]
    add r8, r7, #1
    push {r0}
    ldr r0, Addr0_0
    str r8, [r0]
    pop {r0}
    Ldr r9, =112
    b bb0_2
bb0_1:
    ldr r6, Addr0_0
    ldr r6, [r6]
    b bb0_7
bb0_2:
    ldr r0, =10
    cmp r9, r0
    ldr r2, =0
    ldrgt r2, =1
    ldr r1, =10
    cmp r9, r1
    bgt bb0_3
    b bb0_4
bb0_3:
    sub r3, r9, #88
    ldr r4, =1000
    cmp r3, r4
    ldr r5, =0
    ldrlt r5, =1
    ldr r6, =1000
    cmp r3, r6
    blt bb0_5
    Mov r7, r3
    b bb0_6
bb0_4:
    mov r0, r9
    bl put_int
    Mov r5, r9
    b bb0_1
bb0_5:
    b litpool0_0
    .pool
litpool0_0:
    sub r8, r3, #10
    add r0, r8, #11
    add r2, r0, #11
    Mov r7, r2
    b bb0_6
bb0_6:
    Mov r9, r7
    b bb0_2
bb0_7:
    mov r0, r6
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

