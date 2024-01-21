    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl get_int
    b bb0_0
bb0_0:
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

