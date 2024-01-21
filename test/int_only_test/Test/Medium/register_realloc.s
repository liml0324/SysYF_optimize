    .arch armv8 
    .text 
    .globl func
    .p2align 2
    .type func, %function
func:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #24
    sub r2, r0, r1
    add r3, r2, #10
    add r4, r3, #10
    add r5, r4, #20
    add r6, r5, #30
    add r7, r6, #40
    sub r8, r7, #2
    sub r9, r8, #4
    sub r0, r9, #6
    sub r1, r0, #8
    add r2, r1, #3
    add r3, r2, #6
    add r4, r3, #9
    add r5, r4, #12
    sub r6, r5, #4
    sub r7, r6, #8
    sub r8, r7, #12
    sub r9, r8, #16
    add r0, r9, #5
    add r1, r0, #10
    add r2, r1, #15
    add r3, r2, #20
    sub r4, r3, #6
    sub r5, r4, #12
    sub r6, r5, #18
    sub r7, r6, #24
    add r8, r7, #7
    add r9, r8, #14
    add r0, r9, #21
    add r1, r0, #28
    sub r2, r1, #8
    sub r3, r2, #16
    sub r4, r3, #24
    sub r5, r4, #32
    add r6, r5, #9
    add r7, r6, #18
    add r8, r7, #27
    add r9, r8, #36
    b bb0_0
bb0_0:
    mov r0, r9
    add sp, sp, #24
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    ldr r0, =1
    ldr r1, =19
    bl func
    b bb1_0
bb1_0:
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

