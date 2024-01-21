    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #56
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
    add r9, sp, #4
    ldr r6, =3
    ldr r1, =4
    mul r2, r6, r1
    add r0, r9, r2
    ldr r4, =4
    str r4, [r0]
    add r3, sp, #4
    ldr r5, =4
    ldr r7, =4
    mul r8, r5, r7
    add r6, r3, r8
    ldr r1, =5
    str r1, [r6]
    ldr r9, =-2
    ldr r2, =2
    sdiv r0, r9, r2
    add r4, r0, #4
    add r5, r4, #0
    sub r7, r5, #0
    ldr r3, =5
    sdiv r8, r7, r3
    ldr r6, =5
    mul r1, r8, r6
    sub r9, r7, r1
    add r2, r9, #0
    add r0, sp, #4
    ldr r4, =4
    mul r5, r2, r4
    add r3, r0, r5
    ldr r8, [r3]
    mov r0, r8
    bl put_int
    add r6, sp, #4
    ldr r7, =4
    ldr r1, =4
    mul r9, r7, r1
    add r2, r6, r9
    ldr r4, [r2]
    mov r0, r4
    bl put_int
    b bb0_0
bb0_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

