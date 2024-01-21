    .arch armv8 
    .text 
    .globl sum
    .p2align 2
    .type sum, %function
sum:
    push {lr}
    sub sp, sp, #16
    add r2, r0, r1
    b bb0_0
bb0_0:
    mov r0, r2
    add sp, sp, #16
    pop {lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    Ldr r0, =0
    b bb1_0
bb1_0:
    ldr r1, Addr1_1
    ldr r1, [r1]
    ldr r2, Addr1_1
    ldr r2, [r2]
    add r3, r2, #0
    ldr r4, Addr1_0
    ldr r5, =4
    mul r6, r3, r5
    add r7, r4, r6
    ldr r8, [r7]
    cmp r1, r8
    ldr r9, =0
    ldrlt r9, =1
    cmp r1, r8
    blt bb1_1
    b bb1_2
bb1_1:
    ldr r2, Addr1_1
    ldr r2, [r2]
    add r5, r2, #0
    ldr r6, Addr1_0
    ldr r3, =4
    mul r4, r5, r3
    add r7, r6, r4
    ldr r1, [r7]
    push {r0}
    ldr r0, Addr1_1
    str r1, [r0]
    pop {r0}
    ldr r8, Addr1_1
    ldr r8, [r8]
    ldr r9, Addr1_1
    ldr r9, [r9]
    add r2, r9, #0
    ldr r5, Addr1_0
    ldr r3, =4
    mul r6, r2, r3
    add r4, r5, r6
    ldr r7, [r4]
    add r1, r8, r7
    sub r9, r1, #1
    add r2, r9, #0
    ldr r3, Addr1_0
    ldr r5, =4
    mul r6, r2, r5
    add r4, r3, r6
    ldr r8, [r4]
    ldr r7, Addr1_1
    ldr r7, [r7]
    add r1, r7, #0
    ldr r9, Addr1_0
    ldr r2, =4
    mul r5, r1, r2
    add r3, r9, r5
    ldr r6, [r3]
    fcmp r1, r7
    bgt bb1_3
    Mov r9, r0
    b bb1_4
bb1_2:
    ldr r2, Addr1_1
    ldr r2, [r2]
    add r5, r2, #0
    ldr r3, Addr1_0
    ldr r6, =4
    mul r4, r5, r6
    add r7, r3, r4
    ldr r1, [r7]
    rsb r8, r0, #0
    STM SP, {r1}
    ldr r0, [sp]
    mov r1, r8
    bl sum
    LDM SP, {r1}
    mov r9, r0
    b bb1_5
bb1_3:
    add r5, r0, #0
    ldr r3, Addr1_0
    ldr r6, =4
    mul r4, r5, r6
    add r8, r3, r4
    ldr r7, [r8]
    add r1, r7, #1
    Mov r9, r1
    b bb1_4
bb1_4:
    Mov r0, r9
    b bb1_0
bb1_5:
    b litpool1_0
    .pool
litpool1_0:
    mov r0, r9
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..arr
Addr1_1:
    .long ..a

    .type ..arr, %object
    .section .rodata,"a", %progbits
    .globl ..arr
    .p2align 2
..arr:
    .long 
    .long 
    .long 
    .long 
    .long 
    .size ..arr, 20

    .type ..a, %object
    .bss
    .globl ..a
    .p2align 2
..a:
    .long 0
    .size ..a, 4

