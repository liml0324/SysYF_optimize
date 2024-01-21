    .arch armv8 
    .text 
    .globl KnapSack
    .p2align 2
    .type KnapSack, %function
KnapSack:
    push {r4, r5, r6, r7, r8, r9, lr}
    ldr lr, =153
    sub sp, sp, lr
    Ldr r4, =1
    b bb0_0
bb0_0:
    cmp r4, r0
    ldr r5, =0
    ldrle r5, =1
    cmp r4, r0
    ble bb0_1
    b bb0_2
bb0_1:
    Mov r5, r3
    Ldr r6, =0
    Mov r9, r2
    b bb0_3
bb0_2:
    Mov r6, r1
    Mov r7, r0
    b bb0_12
bb0_3:
    add r8, r1, #1
    cmp r6, r8
    ldr r7, =0
    ldrlt r7, =1
    cmp r6, r8
    blt bb0_4
    b bb0_5
bb0_4:
    add r3, r4, #0
    ldr r8, Addr0_0
    ldr r7, =4
    mul r2, r3, r7
    str r0, [sp]
    add r0, r8, r2
    str r0, [sp, #137]
    ldr r0, [sp, #137]
    ldr r7, [r0]
    cmp r6, r7
    ldr r3, =0
    ldrlt r3, =1
    cmp r6, r7
    ldr r0, [sp]
    blt bb0_6
    b bb0_7
bb0_5:
    add r2, r4, #1
    Mov r3, r5
    Mov r4, r2
    Mov r2, r9
    b bb0_0
bb0_6:
    ldr r8, =200
    mul r3, r4, r8
    add r7, r3, r6
    add r2, r7, #0
    ldr r8, Addr0_3
    ldr r3, =4
    mul r7, r2, r3
    str r0, [sp]
    add r0, r8, r7
    str r0, [sp, #141]
    sub r3, r4, #1
    ldr r2, =200
    mul r7, r3, r2
    add r8, r7, r6
    add r2, r8, #0
    ldr r3, Addr0_3
    ldr r7, =4
    mul r8, r2, r7
    add r0, r3, r8
    str r0, [sp, #56]
    ldr r0, [sp, #56]
    ldr r7, [r0]
    ldr r0, [sp, #141]
    str r7, [r0]
    ldr r0, [sp]
    Mov r3, r9
    Mov r8, r5
    b bb0_8
bb0_7:
    b litpool0_0
    .pool
litpool0_0:
    sub r2, r4, #1
    ldr r8, =200
    mul r7, r2, r8
    add r3, r7, r6
    add r8, r3, #0
    ldr r2, Addr0_3
    ldr r7, =4
    mul r3, r8, r7
    str r0, [sp]
    add r0, r2, r3
    str r0, [sp, #121]
    ldr r0, [sp, #121]
    ldr r7, [r0]
    sub r8, r4, #1
    ldr r3, =200
    mul r2, r8, r3
    add r0, r2, r6
    str r0, [sp, #40]
    add r3, r4, #0
    ldr r8, Addr0_0
    ldr r2, =4
    mul r0, r3, r2
    str r0, [sp, #89]
    ldr r0, [sp, #89]
    add r0, r8, r0
    str r0, [sp, #93]
    ldr r0, [sp, #93]
    ldr r2, [r0]
    ldr r0, [sp, #40]
    sub r3, r0, r2
    add r8, r3, #0
    ldr r2, Addr0_3
    ldr r3, =4
    mul r0, r8, r3
    str r0, [sp, #101]
    ldr r0, [sp, #101]
    add r0, r2, r0
    str r0, [sp, #105]
    ldr r0, [sp, #105]
    ldr r3, [r0]
    add r8, r4, #0
    ldr r2, Addr0_1
    ldr r0, =4
    str r0, [sp, #133]
    ldr r0, [sp, #133]
    mul r0, r8, r0
    str r0, [sp, #109]
    ldr r0, [sp, #109]
    add r0, r2, r0
    str r0, [sp, #113]
    ldr r0, [sp, #113]
    ldr r8, [r0]
    add r2, r3, r8
    cmp r7, r2
    ldr r0, =0
    ldrgt r0, =1
    str r0, [sp, #60]
    cmp r7, r2
    ldr r0, [sp]
    bgt bb0_9
    b bb0_10
bb0_8:
    str r0, [sp]
    add r0, r6, #1
    str r0, [sp, #97]
    ldr r0, [sp]
    Mov r5, r8
    ldr r6, [sp, #97]
    Mov r9, r3
    b bb0_3
bb0_9:
    str r0, [sp]
    ldr r0, =200
    str r0, [sp, #133]
    ldr r0, [sp, #133]
    mul r3, r4, r0
    add r8, r3, r6
    add r0, r8, #0
    str r0, [sp, #69]
    ldr r3, Addr0_3
    ldr r8, =4
    ldr r0, [sp, #69]
    mul r0, r0, r8
    str r0, [sp, #117]
    ldr r0, [sp, #117]
    add r0, r3, r0
    str r0, [sp, #81]
    ldr r0, [sp, #81]
    str r7, [r0]
    ldr r0, [sp]
    b bb0_11
bb0_10:
    ldr r3, =200
    mul r8, r4, r3
    str r0, [sp]
    add r0, r8, r6
    str r0, [sp, #85]
    ldr r0, [sp, #85]
    add r3, r0, #0
    ldr r8, Addr0_3
    ldr r0, =4
    str r0, [sp, #16]
    ldr r0, [sp, #16]
    mul r0, r3, r0
    str r0, [sp, #44]
    ldr r0, [sp, #44]
    add r0, r8, r0
    str r0, [sp, #48]
    ldr r0, [sp, #48]
    str r2, [r0]
    ldr r0, [sp]
    b bb0_11
bb0_11:
    b litpool0_1
    .pool
litpool0_1:
    Mov r3, r2
    Mov r8, r7
    b bb0_8
bb0_12:
    ldr r8, =1
    cmp r7, r8
    ldr r9, =0
    ldrge r9, =1
    ldr r5, =1
    cmp r7, r5
    bge bb0_13
    b bb0_14
bb0_13:
    ldr r5, =200
    mul r9, r7, r5
    add r8, r9, r6
    add r5, r8, #0
    ldr r9, Addr0_3
    ldr r8, =4
    str r0, [sp]
    mul r0, r5, r8
    str r0, [sp, #52]
    ldr r0, [sp, #52]
    add r0, r9, r0
    str r0, [sp, #61]
    ldr r0, [sp, #61]
    ldr r5, [r0]
    sub r8, r7, #1
    ldr r9, =200
    mul r0, r8, r9
    str r0, [sp, #125]
    ldr r0, [sp, #125]
    add r0, r0, r6
    str r0, [sp, #129]
    ldr r0, [sp, #129]
    add r8, r0, #0
    ldr r9, Addr0_3
    ldr r0, =4
    str r0, [sp, #16]
    ldr r0, [sp, #16]
    mul r0, r8, r0
    str r0, [sp, #65]
    ldr r0, [sp, #65]
    add r0, r9, r0
    str r0, [sp, #73]
    ldr r0, [sp, #73]
    ldr r8, [r0]
    cmp r5, r8
    ldr r9, =0
    ldrgt r9, =1
    cmp r5, r8
    ldr r0, [sp]
    bgt bb0_15
    b bb0_16
bb0_14:
    ldr r8, =200
    mul r9, r0, r8
    add r5, r9, r1
    add r8, r5, #0
    ldr r9, Addr0_3
    ldr r5, =4
    str r0, [sp]
    mul r0, r8, r5
    str r0, [sp, #77]
    ldr r0, [sp, #77]
    add r0, r9, r0
    str r0, [sp, #36]
    ldr r0, [sp, #36]
    ldr r8, [r0]
    ldr r0, [sp]
    b bb0_18
bb0_15:
    add r8, r7, #0
    ldr r9, Addr0_2
    ldr r5, =4
    str r0, [sp]
    mul r0, r8, r5
    str r0, [sp, #16]
    ldr r0, [sp, #16]
    add r0, r9, r0
    str r0, [sp, #20]
    ldr r8, =1
    ldr r0, [sp, #20]
    str r8, [r0]
    add r5, r7, #0
    ldr r9, Addr0_0
    ldr r8, =4
    mul r0, r5, r8
    str r0, [sp, #24]
    ldr r0, [sp, #24]
    add r0, r9, r0
    str r0, [sp, #28]
    ldr r0, [sp, #28]
    ldr r5, [r0]
    sub r8, r6, r5
    ldr r0, [sp]
    Mov r5, r8
    b bb0_17
bb0_16:
    str r0, [sp]
    add r0, r7, #0
    str r0, [sp, #133]
    ldr r5, Addr0_2
    ldr r8, =4
    ldr r0, [sp, #133]
    mul r9, r0, r8
    add r0, r5, r9
    str r0, [sp, #32]
    ldr r8, =0
    ldr r0, [sp, #32]
    str r8, [r0]
    ldr r0, [sp]
    Mov r5, r6
    b bb0_17
bb0_17:
    b litpool0_2
    .pool
litpool0_2:
    sub r9, r7, #1
    Mov r6, r5
    Mov r7, r9
    b bb0_12
bb0_18:
    mov r0, r8
    ldr lr, =153
    add sp, sp, lr
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr0_0:
    .long ..w
Addr0_1:
    .long ..v
Addr0_2:
    .long ..x
Addr0_3:
    .long ..V

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    ldr r0, =5
    ldr r1, =10
    bl KnapSack
    STM SP, {r0}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r0}
    b bb1_0
bb1_0:
    ldr r0, =0
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

    .type ..len, %object
    .section .rodata,"a", %progbits
    .globl ..len
    .p2align 2
..len:
    .long 200
    .size ..len, 4

    .type ..V, %object
    .comm ..V, 160000, 4

    .type ..w, %object
    .data
    .globl ..w
    .p2align 2
..w:
    .long 
    .long 
    .long 
    .long 
    .long 
    .long 
    .size ..w, 24

    .type ..v, %object
    .data
    .globl ..v
    .p2align 2
..v:
    .long 
    .long 
    .long 
    .long 
    .long 
    .long 
    .size ..v, 24

    .type ..x, %object
    .comm ..x, 24, 4

