    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl get_int
    push {r1}
    ldr r1, Addr0_0
    str r0, [r1]
    pop {r1}
    STM SP, {r1}
    bl get_int
    LDM SP, {r1}
    mov r1, r0
    push {r0}
    ldr r0, Addr0_1
    str r1, [r0]
    pop {r0}
    ldr r2, Addr0_0
    ldr r2, [r2]
    ldr r3, Addr0_1
    ldr r3, [r3]
    cmp r2, r3
    ldr r4, =0
    ldreq r4, =1
    cmp r2, r3
    beq bb0_0
    b bb0_1
bb0_0:
    Ldr r5, =1
    b bb0_2
bb0_1:
    Ldr r5, =0
    b bb0_2
bb0_2:
    mov r0, r5
    mov sp, r11
    pop {r4, r5, r11, lr}
    bx lr
    .pool
Addr0_0:
    .long ..a
Addr0_1:
    .long ..b

    .type ..a, %object
    .bss
    .globl ..a
    .p2align 2
..a:
    .long 0
    .size ..a, 4

    .type ..b, %object
    .bss
    .globl ..b
    .p2align 2
..b:
    .long 0
    .size ..b, 4

