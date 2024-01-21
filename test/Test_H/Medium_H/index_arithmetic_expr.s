    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #60
    ldr r0, =0
    add r1, r0, #0
    add r2, sp, #16
    ldr r3, =4
    mul r4, r1, r3
    add r5, r2, r4
    ldr r6, =1
    str r6, [r5]
    ldr r7, =0
    add r8, r7, #1
    add r9, sp, #16
    ldr r0, =4
    mul r3, r8, r0
    add r1, r9, r3
    ldr r4, =2
    str r4, [r1]
    ldr r2, =0
    add r5, r2, #2
    add r6, sp, #16
    ldr r7, =4
    mul r0, r5, r7
    add r8, r6, r0
    ldr r3, =3
    str r3, [r8]
    ldr r9, =56
    ldr r1, =12
    sdiv r4, r9, r1
    ldr r2, =12
    mul r7, r4, r2
    rsb r5, r7, #56
    add r0, r5, #12
    ldr r6, =5
    sdiv r8, r0, r6
    sub r3, r8, #2
    add r9, r3, #0
    add r1, sp, #16
    ldr r4, =4
    mul r2, r9, r4
    add r7, r1, r2
    ldr r5, [r7]
    mov r0, r5
    bl put_int
    b bb0_0
bb0_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

