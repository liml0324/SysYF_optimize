    .arch armv8 
    .text 
    .globl inc
    .p2align 2
    .type inc, %function
inc:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    ldr r2, =10000
    cmp r0, r2
    ldr r3, =0
    ldrgt r3, =1
    ldr r4, =10000
    cmp r0, r4
    bgt bb0_0
    b bb0_1
bb0_0:
    ldr r7, =2
    cmp r1, r7
    ldr r8, =0
    ldrlt r8, =1
    ldr r9, =2
    cmp r1, r9
    blt bb0_2
    b bb0_3
bb0_1:
    add r5, r0, r1
    ldr r7, =65535
    sdiv r8, r5, r7
    ldr r9, =65535
    mul r2, r8, r9
    sub r4, r5, r2
    Mov r3, r4
    b bb0_4
bb0_2:
    Ldr r3, =-1
    b bb0_4
bb0_3:
    b bb0_1
bb0_4:
    mov r0, r3
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl find
    .p2align 2
    .type find, %function
find:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r1, Addr1_1
    ldr r1, [r1]
    STM SP, {r0, r1, r2}
    ldr r0, [sp, #4]
    ldr r1, =2
    bl inc
    LDMIB SP, {r1, r2}
    mov r2, r0
    ldr r0, [SP]
    push {r0}
    ldr r0, Addr1_1
    str r2, [r0]
    pop {r0}
    ldr r3, =5
    sdiv r4, r0, r3
    ldr r5, =5
    mul r6, r4, r5
    sub r7, r0, r6
    add r8, r7, #0
    ldr r9, Addr1_0
    ldr r1, =4
    mul r2, r8, r1
    add r3, r9, r2
    ldr r4, [r3]
    b bb1_0
bb1_0:
    mov r0, r4
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..arr
Addr1_1:
    .long ..a

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    b bb2_0
bb2_0:
    b litpool2_0
    .pool
litpool2_0:
    ldr r0, Addr2_1
    ldr r0, [r0]
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldrgt r2, =1
    ldr r3, =0
    cmp r0, r3
    bgt bb2_1
    b bb2_2
bb2_1:
    ldr r3, Addr2_1
    ldr r3, [r3]
    STM SP, {r0, r3}
    ldr r0, [sp, #4]
    bl find
    LDMIB SP, {r3}
    ldr r2, =0
    cmp r0, r2
    ldr r6, =0
    ldrne r6, =1
    ldr r7, =0
    cmp r0, r7
    bne bb2_3
    b bb2_4
bb2_2:
    ldr r4, Addr2_1
    ldr r4, [r4]
    ldr r6, =127
    sdiv r7, r4, r6
    ldr r8, =127
    mul r9, r7, r8
    sub r1, r4, r9
    b bb2_7
bb2_3:
    ldr r8, Addr2_1
    ldr r8, [r8]
    mov r0, r8
    bl find
    mov r4, r0
    add r9, r4, #0
    ldr r5, Addr2_0
    ldr r1, =4
    mul r3, r9, r1
    add r2, r5, r3
    ldr r7, Addr2_1
    ldr r7, [r7]
    STM SP, {r0, r2}
    mov r0, r7
    bl find
    LDMIB SP, {r2}
    str r0, [r2]
    ldr r0, =0
    ldr r1, =0
    bl inc
    mov r6, r0
    ldr r8, =-1
    cmp r6, r8
    ldr r4, =0
    ldrne r4, =1
    ldr r9, =-1
    cmp r6, r9
    bne bb2_5
    Ldr r1, =0
    b bb2_6
bb2_4:
    b bb2_0
bb2_5:
    ldr r0, =0
    ldr r1, =1
    bl inc
    mov r5, r0
    Mov r1, r5
    b bb2_6
bb2_6:
    b litpool2_1
    .pool
litpool2_1:
    b bb2_2
bb2_7:
    mov r0, r1
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr2_0:
    .long ..arr
Addr2_1:
    .long ..a

    .type ..len, %object
    .section .rodata,"a", %progbits
    .globl ..len
    .p2align 2
..len:
    .long 5
    .size ..len, 4

    .type ..arr, %object
    .data
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
    .data
    .globl ..a
    .p2align 2
..a:
    .long 1
    .size ..a, 4

