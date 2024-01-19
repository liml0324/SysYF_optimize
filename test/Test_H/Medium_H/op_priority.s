    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl get_int
    push {r1}
    ldr r1, Addr0_0
    str r0, [r1]
    pop {r1}
    STM SP, {r1}
    bl get_int
    LDM SP, {r1}
    mov r1, r0
    push {r0}
    ldr r0, Addr0_1
    str r1, [r0]
    pop {r0}
    STM SP, {r2}
    bl get_int
    LDM SP, {r2}
    mov r2, r0
    push {r0}
    ldr r0, Addr0_2
    str r2, [r0]
    pop {r0}
    STM SP, {r3}
    bl get_int
    LDM SP, {r3}
    mov r3, r0
    push {r0}
    ldr r0, Addr0_3
    str r3, [r0]
    pop {r0}
    bl get_int
    mov r4, r0
    push {r0}
    ldr r0, Addr0_4
    str r4, [r0]
    pop {r0}
    ldr r5, Addr0_0
    ldr r5, [r5]
    ldr r6, Addr0_1
    ldr r6, [r6]
    ldr r7, Addr0_2
    ldr r7, [r7]
    mul r8, r6, r7
    sub r9, r5, r8
    ldr r0, Addr0_3
    ldr r0, [r0]
    ldr r1, Addr0_0
    ldr r1, [r1]
    ldr r2, Addr0_2
    ldr r2, [r2]
    sdiv r3, r1, r2
    sub r4, r0, r3
    cmp r9, r4
    ldr r6, =0
    ldrne r6, =1
    cmp r9, r4
    bne bb0_0
    b bb0_3
bb0_0:
    Ldr r4, =1
    b bb0_1
bb0_1:
    b bb0_4
bb0_2:
    ldr r6, Addr0_0
    ldr r6, [r6]
    ldr r7, Addr0_1
    ldr r7, [r7]
    add r8, r6, r7
    ldr r5, Addr0_2
    ldr r5, [r5]
    add r1, r8, r5
    ldr r0, Addr0_3
    ldr r0, [r0]
    ldr r3, Addr0_4
    ldr r3, [r3]
    add r2, r0, r3
    cmp r1, r2
    ldr r9, =0
    ldreq r9, =1
    cmp r1, r2
    beq bb0_0
    Ldr r4, =0
    b bb0_1
bb0_3:
    ldr r7, Addr0_0
    ldr r7, [r7]
    ldr r8, Addr0_1
    ldr r8, [r8]
    mul r5, r7, r8
    ldr r1, Addr0_2
    ldr r1, [r1]
    sdiv r2, r5, r1
    b litpool0_0
    .pool
litpool0_0:
    ldr r0, Addr0_4
    ldr r0, [r0]
    ldr r3, Addr0_3
    ldr r3, [r3]
    add r9, r0, r3
    cmp r2, r9
    ldr r4, =0
    ldreq r4, =1
    cmp r2, r9
    beq bb0_0
    b bb0_2
bb0_4:
    mov r0, r4
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr0_0:
    .long ..a
Addr0_1:
    .long ..b
Addr0_2:
    .long ..c
Addr0_3:
    .long ..d
Addr0_4:
    .long ..e

    .type ..a, %object
    .bss
    .globl ..a
    .p2align 2
..a:
    .long 0
    .size ..a, 4

    .type ..b, %object
    .bss
    .globl ..b
    .p2align 2
..b:
    .long 0
    .size ..b, 4

    .type ..c, %object
    .bss
    .globl ..c
    .p2align 2
..c:
    .long 0
    .size ..c, 4

    .type ..d, %object
    .bss
    .globl ..d
    .p2align 2
..d:
    .long 0
    .size ..d, 4

    .type ..e, %object
    .bss
    .globl ..e
    .p2align 2
..e:
    .long 0
    .size ..e, 4

