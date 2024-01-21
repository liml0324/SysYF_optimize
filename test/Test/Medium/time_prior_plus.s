    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =6
    ldr r1, =-4
    mul r2, r0, r1
    add r3, r2, #20
    ldr r4, =20
    ldr r5, =-4
    add r6, r4, r5
    ldr r7, =5
    sdiv r8, r7, r6
    mul r9, r8, r6
    rsb r0, r9, #5
    ldr r1, =20
    sdiv r2, r0, r1
    sub r4, r3, r2
    mov r0, r4
    bl put_int
    b bb0_0
bb0_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

