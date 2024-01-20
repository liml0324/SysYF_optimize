    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #48
    add r0, sp, #4
    ldr r1, =0
    ldr r2, =4
    mul r3, r1, r2
    add r4, r0, r3
    ldr r5, =1
    str r5, [r4]
    add r6, sp, #4
    ldr r7, =1
    ldr r8, =4
    mul r9, r7, r8
    add r1, r6, r9
    ldr r2, =2
    str r2, [r1]
    add r3, sp, #4
    ldr r0, =2
    ldr r4, =4
    mul r5, r0, r4
    add r7, r3, r5
    ldr r8, =3
    str r8, [r7]
    ldr r9, =20
    ldr r6, =5
    sdiv r1, r9, r6
    sub r2, r1, #2
    add r0, r2, #0
    add r4, sp, #4
    ldr r5, =4
    mul r3, r0, r5
    add r7, r4, r3
    ldr r8, [r7]
    mov r0, r8
    bl put_int
    b bb0_0
bb0_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

