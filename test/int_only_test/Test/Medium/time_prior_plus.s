    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =5
    ldr r1, =20
    sdiv r2, r0, r1
    ldr r3, =-4
    sub r4, r3, r2
    mov r0, r4
    bl put_int
    b bb0_0
bb0_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r11, lr}
    bx lr
    .pool

