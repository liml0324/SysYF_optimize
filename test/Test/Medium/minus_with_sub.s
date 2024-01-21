    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =0
    sub r1, r0, #1
    ldr r2, =-2
    sub r3, r2, r1
    ldr r4, =-2
    add r5, r4, #1
    rsb r6, r5, #0
    ldr r7, =-2
    sub r8, r7, #1
    rsb r9, r8, #0
    sdiv r0, r6, r9
    mul r2, r0, r9
    sub r1, r6, r2
    add r4, r3, r1
    mov r0, r4
    bl put_int
    b bb0_0
bb0_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

