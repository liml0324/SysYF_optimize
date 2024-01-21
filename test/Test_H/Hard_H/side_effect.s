    .arch armv8 
    .text 
    .globl inc_a
    .p2align 2
    .type inc_a, %function
inc_a:
    push {lr}
    sub sp, sp, #16
    ldr r0, Addr0_0
    ldr r0, [r0]
    add r1, r0, #1
    push {r0}
    ldr r0, Addr0_0
    str r1, [r0]
    pop {r0}
    ldr r2, Addr0_0
    ldr r2, [r2]
    b bb0_0
bb0_0:
    mov r0, r2
    add sp, sp, #16
    pop {lr}
    bx lr
    .pool
Addr0_0:
    .long ..a

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    Ldr r0, =5
    b bb1_0
bb1_0:
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldrge r2, =1
    ldr r3, =0
    cmp r0, r3
    bge bb1_1
    b bb1_2
bb1_1:
    STM SP, {r0}
    bl inc_a
    mov r7, r0
    ldr r0, [SP]
    ldr r8, =0
    cmp r7, r8
    ldr r9, =0
    ldrne r9, =1
    ldr r1, =0
    cmp r7, r1
    bne bb1_6
    b bb1_4
bb1_2:
    ldr r4, Addr1_0
    ldr r4, [r4]
    mov r0, r4
    bl put_int
    ldr r0, =32
    bl put_char
    ldr r5, Addr1_1
    ldr r5, [r5]
    mov r0, r5
    bl put_int
    ldr r0, =10
    bl put_char
    ldr r6, Addr1_0
    ldr r6, [r6]
    b bb1_12
bb1_3:
    ldr r4, Addr1_0
    ldr r4, [r4]
    STM SP, {r0}
    mov r0, r4
    bl put_int
    LDM sp, {r0}
    STM SP, {r0}
    ldr r0, =32
    bl put_char
    LDM sp, {r0}
    ldr r6, Addr1_1
    ldr r6, [r6]
    STM SP, {r0}
    mov r0, r6
    bl put_int
    LDM sp, {r0}
    STM SP, {r0}
    ldr r0, =10
    bl put_char
    LDM sp, {r0}
    b bb1_4
bb1_4:
    b litpool1_0
    .pool
litpool1_0:
    STM SP, {r0, r3}
    bl inc_a
    LDMIB SP, {r3}
    mov r3, r0
    ldr r0, [SP]
    ldr r2, =14
    cmp r3, r2
    ldr r4, =0
    ldrlt r4, =1
    ldr r5, =14
    cmp r3, r5
    blt bb1_7
    b bb1_10
bb1_5:
    STM SP, {r0}
    bl inc_a
    mov r7, r0
    ldr r0, [SP]
    ldr r9, =0
    cmp r7, r9
    ldr r2, =0
    ldrne r2, =1
    ldr r3, =0
    cmp r7, r3
    bne bb1_3
    b bb1_4
bb1_6:
    STM SP, {r0}
    bl inc_a
    mov r5, r0
    ldr r0, [SP]
    ldr r6, =0
    cmp r5, r6
    ldr r8, =0
    ldrne r8, =1
    ldr r1, =0
    cmp r5, r1
    bne bb1_5
    b bb1_4
bb1_7:
    ldr r9, Addr1_0
    ldr r9, [r9]
    STM SP, {r0}
    mov r0, r9
    bl put_int
    LDM sp, {r0}
    STM SP, {r0}
    ldr r0, =10
    bl put_char
    LDM sp, {r0}
    ldr r2, Addr1_1
    ldr r2, [r2]
    ldr r3, =2
    mul r4, r2, r3
    push {r0}
    ldr r0, Addr1_1
    str r4, [r0]
    pop {r0}
    b bb1_9
bb1_8:
    STM SP, {r0}
    bl inc_a
    mov r9, r0
    ldr r0, [SP]
    b bb1_9
bb1_9:
    sub r2, r0, #1
    Mov r0, r2
    b bb1_0
bb1_10:
    b litpool1_1
    .pool
litpool1_1:
    STM SP, {r0}
    bl inc_a
    mov r6, r0
    ldr r0, [SP]
    ldr r8, =0
    cmp r6, r8
    ldr r1, =0
    ldrne r1, =1
    ldr r7, =0
    cmp r6, r7
    bne bb1_11
    b bb1_8
bb1_11:
    STM SP, {r0, r3}
    bl inc_a
    LDMIB SP, {r3}
    mov r3, r0
    ldr r0, [SP]
    STM SP, {r0, r3}
    bl inc_a
    LDMIB SP, {r3}
    mov r4, r0
    ldr r0, [SP]
    sub r5, r3, r4
    add r8, r5, #1
    ldr r6, =0
    cmp r8, r6
    ldr r1, =0
    ldrne r1, =1
    ldr r7, =0
    cmp r8, r7
    bne bb1_7
    b bb1_8
bb1_12:
    mov r0, r6
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..a
Addr1_1:
    .long ..b

    .type ..a, %object
    .data
    .globl ..a
    .p2align 2
..a:
    .long -1
    .size ..a, 4

    .type ..b, %object
    .data
    .globl ..b
    .p2align 2
..b:
    .long 1
    .size ..b, 4

