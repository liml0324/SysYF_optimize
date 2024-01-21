    .arch armv8 
    .text 
    .globl init
    .p2align 2
    .type init, %function
init:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    Ldr r1, =1
    b bb0_0
bb0_0:
    mul r2, r0, r0
    add r3, r2, #1
    cmp r1, r3
    ldr r4, =0
    ldrle r4, =1
    cmp r1, r3
    ble bb0_1
    b bb0_2
bb0_1:
    add r5, r1, #0
    ldr r6, Addr0_0
    ldr r7, =4
    mul r8, r5, r7
    add r9, r6, r8
    ldr r2, =-1
    str r2, [r9]
    add r3, r1, #1
    Mov r1, r3
    b bb0_0
bb0_2:
    b bb0_3
bb0_3:
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr0_0:
    .long ..array

    .globl findfa
    .p2align 2
    .type findfa, %function
findfa:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    add r1, r0, #0
    ldr r2, Addr1_0
    ldr r3, =4
    mul r4, r1, r3
    add r5, r2, r4
    ldr r6, [r5]
    cmp r6, r0
    ldr r7, =0
    ldreq r7, =1
    cmp r6, r0
    beq bb1_0
    b bb1_1
bb1_0:
    Mov r3, r0
    b bb1_2
bb1_1:
    add r8, r0, #0
    ldr r9, Addr1_0
    ldr r3, =4
    mul r1, r8, r3
    add r4, r9, r1
    add r2, r0, #0
    ldr r5, Addr1_0
    ldr r6, =4
    mul r7, r2, r6
    add r8, r5, r7
    ldr r3, [r8]
    STM SP, {r0, r3}
    ldr r0, [sp, #4]
    bl findfa
    LDMIB SP, {r3}
    mov r9, r0
    ldr r0, [SP]
    str r9, [r4]
    add r1, r0, #0
    ldr r2, Addr1_0
    ldr r6, =4
    mul r5, r1, r6
    add r7, r2, r5
    ldr r8, [r7]
    Mov r3, r8
    b bb1_2
bb1_2:
    b litpool1_0
    .pool
litpool1_0:
    mov r0, r3
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..array

    .globl mmerge
    .p2align 2
    .type mmerge, %function
mmerge:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0, r1, r2}
    ldr r0, [sp]
    bl findfa
    LDMIB SP, {r1, r2}
    mov r2, r0
    ldr r0, [SP]
    STM SP, {r1, r2, r3}
    ldr r0, [sp]
    bl findfa
    LDM SP, {r1, r2, r3}
    mov r3, r0
    cmp r2, r3
    ldr r4, =0
    ldrne r4, =1
    cmp r2, r3
    bne bb2_0
    b bb2_1
bb2_0:
    add r5, r2, #0
    ldr r6, Addr2_0
    ldr r7, =4
    mul r8, r5, r7
    add r9, r6, r8
    str r3, [r9]
    b bb2_1
bb2_1:
    b bb2_2
bb2_2:
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr2_0:
    .long ..array

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #112
    Ldr r4, =0
    Ldr r5, =0
    Ldr r6, =0
    Ldr r7, =1
    b bb3_0
bb3_0:
    ldr r8, =0
    cmp r7, r8
    ldr r9, =0
    ldrne r9, =1
    str r0, [sp, #20]
    ldr r0, =0
    str r0, [sp, #12]
    ldr r0, [sp, #12]
    cmp r7, r0
    ldr r0, [sp, #20]
    bne bb3_1
    b bb3_2
bb3_1:
    sub r8, r7, #1
    ldr r1, =4
    push {r0}
    ldr r0, Addr3_0
    str r1, [r0]
    pop {r0}
    ldr r2, Addr3_0
    ldr r2, [r2]
    STM SP, {r0, r2}
    ldr r0, [sp, #4]
    bl init
    LDM sp, {r0, r2}
    ldr r3, Addr3_0
    ldr r3, [r3]
    ldr r6, Addr3_0
    ldr r6, [r6]
    mul r9, r3, r6
    add r7, r9, #1
    Mov r1, r0
    Ldr r2, =0
    Ldr r3, =0
    Mov r6, r4
    Mov r9, r5
    b bb3_3
bb3_2:
    b litpool3_0
    .pool
litpool3_0:
    b bb3_30
bb3_3:
    ldr r0, =10
    cmp r3, r0
    ldr r4, =0
    ldrlt r4, =1
    ldr r5, =10
    cmp r3, r5
    blt bb3_4
    b bb3_5
bb3_4:
    STM SP, {r0, r1, r2, r3}
    bl get_int
    LDMIB SP, {r1, r2, r3}
    STM SP, {r0, r1, r2, r3}
    bl get_int
    LDMIB SP, {r1, r2, r3}
    mov r4, r0
    ldr r0, [SP]
    ldr r5, =0
    cmp r2, r5
    ldr r6, =0
    ldreq r6, =1
    ldr r9, =0
    cmp r2, r9
    beq bb3_6
    Mov r5, r1
    Mov r1, r2
    b bb3_7
bb3_5:
    ldr r0, =0
    cmp r2, r0
    ldr r5, =0
    ldreq r5, =1
    ldr r4, =0
    cmp r2, r4
    beq bb3_28
    b bb3_29
bb3_6:
    ldr r6, Addr3_0
    ldr r6, [r6]
    sub r5, r0, #1
    mul r1, r6, r5
    add r9, r1, r4
    add r6, r9, #0
    ldr r5, Addr3_1
    ldr r1, =4
    str r0, [sp, #20]
    mul r0, r6, r1
    str r0, [sp, #4]
    ldr r0, [sp, #4]
    add r0, r5, r0
    str r0, [sp, #76]
    ldr r0, [sp, #76]
    str r9, [r0]
    ldr r1, =1
    ldr r0, [sp, #20]
    cmp r0, r1
    ldr r6, =0
    ldreq r6, =1
    ldr r5, =1
    cmp r0, r5
    beq bb3_8
    b bb3_9
bb3_7:
    add r9, r3, #1
    Mov r2, r1
    Mov r1, r5
    Mov r3, r9
    Mov r6, r4
    Mov r9, r0
    b bb3_3
bb3_8:
    ldr r1, =0
    add r6, r1, #0
    ldr r5, Addr3_1
    ldr r1, =4
    str r0, [sp, #20]
    mul r0, r6, r1
    str r0, [sp, #56]
    ldr r0, [sp, #56]
    add r0, r5, r0
    str r0, [sp, #60]
    ldr r1, =0
    ldr r0, [sp, #60]
    str r1, [r0]
    STM SP, {r0, r2, r3}
    mov r0, r9
    ldr r1, =0
    bl mmerge
    LDM sp, {r0, r2, r3}
    ldr r0, [sp, #20]
    b bb3_9
bb3_9:
    b litpool3_1
    .pool
litpool3_1:
    ldr r1, Addr3_0
    ldr r1, [r1]
    cmp r0, r1
    ldr r5, =0
    ldreq r5, =1
    cmp r0, r1
    beq bb3_10
    b bb3_11
bb3_10:
    add r6, r7, #0
    ldr r5, Addr3_1
    ldr r1, =4
    str r0, [sp, #20]
    mul r0, r6, r1
    str r0, [sp, #64]
    ldr r0, [sp, #64]
    add r0, r5, r0
    str r0, [sp, #48]
    ldr r0, [sp, #48]
    str r7, [r0]
    STM SP, {r0, r2, r3}
    mov r0, r9
    mov r1, r7
    bl mmerge
    LDM sp, {r0, r2, r3}
    ldr r0, [sp, #20]
    b bb3_11
bb3_11:
    ldr r6, Addr3_0
    ldr r6, [r6]
    cmp r4, r6
    ldr r1, =0
    ldrlt r1, =1
    cmp r4, r6
    blt bb3_14
    b bb3_13
bb3_12:
    add r1, r9, #1
    STM SP, {r0, r1, r2, r3}
    mov r0, r9
    ldr r1, [sp, #4]
    bl mmerge
    LDM sp, {r0, r1, r2, r3}
    b bb3_13
bb3_13:
    ldr r5, =1
    cmp r4, r5
    ldr r6, =0
    ldrgt r6, =1
    ldr r1, =1
    cmp r4, r1
    bgt bb3_17
    b bb3_16
bb3_14:
    add r6, r9, #1
    add r1, r6, #0
    ldr r5, Addr3_1
    ldr r6, =4
    str r0, [sp, #20]
    mul r0, r1, r6
    str r0, [sp, #52]
    ldr r0, [sp, #52]
    add r0, r5, r0
    str r0, [sp, #8]
    ldr r0, [sp, #8]
    ldr r6, [r0]
    ldr r1, =-1
    cmp r6, r1
    ldr r5, =0
    ldrne r5, =1
    ldr r0, =-1
    str r0, [sp, #80]
    ldr r0, [sp, #80]
    cmp r6, r0
    ldr r0, [sp, #20]
    bne bb3_12
    b bb3_13
bb3_15:
    b litpool3_2
    .pool
litpool3_2:
    sub r5, r9, #1
    STM SP, {r0, r2, r3}
    mov r0, r9
    mov r1, r5
    bl mmerge
    LDM sp, {r0, r2, r3}
    b bb3_16
bb3_16:
    ldr r5, Addr3_0
    ldr r5, [r5]
    cmp r0, r5
    ldr r1, =0
    ldrlt r1, =1
    cmp r0, r5
    blt bb3_20
    b bb3_19
bb3_17:
    sub r6, r9, #1
    add r5, r6, #0
    ldr r1, Addr3_1
    ldr r6, =4
    str r0, [sp, #20]
    mul r0, r5, r6
    str r0, [sp, #24]
    ldr r0, [sp, #24]
    add r0, r1, r0
    str r0, [sp, #28]
    ldr r0, [sp, #28]
    ldr r6, [r0]
    ldr r5, =-1
    cmp r6, r5
    ldr r1, =0
    ldrne r1, =1
    ldr r0, =-1
    str r0, [sp, #24]
    ldr r0, [sp, #24]
    cmp r6, r0
    ldr r0, [sp, #20]
    bne bb3_15
    b bb3_16
bb3_18:
    ldr r5, Addr3_0
    ldr r5, [r5]
    add r1, r9, r5
    STM SP, {r0, r1, r2, r3}
    mov r0, r9
    ldr r1, [sp, #4]
    bl mmerge
    LDM sp, {r0, r1, r2, r3}
    b bb3_19
bb3_19:
    ldr r6, =1
    cmp r0, r6
    ldr r5, =0
    ldrgt r5, =1
    ldr r1, =1
    cmp r0, r1
    bgt bb3_23
    b bb3_22
bb3_20:
    ldr r6, Addr3_0
    ldr r6, [r6]
    add r5, r9, r6
    add r1, r5, #0
    ldr r6, Addr3_1
    ldr r5, =4
    str r0, [sp, #20]
    mul r0, r1, r5
    str r0, [sp, #68]
    ldr r0, [sp, #68]
    add r0, r6, r0
    str r0, [sp, #44]
    ldr r0, [sp, #44]
    ldr r1, [r0]
    ldr r5, =-1
    cmp r1, r5
    ldr r6, =0
    ldrne r6, =1
    ldr r0, =-1
    str r0, [sp, #8]
    ldr r0, [sp, #8]
    cmp r1, r0
    ldr r0, [sp, #20]
    bne bb3_18
    b bb3_19
bb3_21:
    b litpool3_3
    .pool
litpool3_3:
    ldr r5, Addr3_0
    ldr r5, [r5]
    sub r1, r9, r5
    STM SP, {r0, r1, r2, r3}
    mov r0, r9
    ldr r1, [sp, #4]
    bl mmerge
    LDM sp, {r0, r1, r2, r3}
    b bb3_22
bb3_22:
    ldr r6, =0
    add r5, r6, #0
    ldr r1, Addr3_1
    ldr r6, =4
    str r0, [sp, #20]
    mul r0, r5, r6
    str r0, [sp, #72]
    ldr r0, [sp, #72]
    add r0, r1, r0
    str r0, [sp, #36]
    ldr r0, [sp, #36]
    ldr r5, [r0]
    ldr r6, =-1
    cmp r5, r6
    ldr r1, =0
    ldrne r1, =1
    ldr r0, =-1
    str r0, [sp, #4]
    ldr r0, [sp, #4]
    cmp r5, r0
    ldr r0, [sp, #20]
    bne bb3_27
    Mov r6, r2
    b bb3_25
bb3_23:
    ldr r6, Addr3_0
    ldr r6, [r6]
    sub r5, r9, r6
    add r1, r5, #0
    ldr r6, Addr3_1
    ldr r5, =4
    str r0, [sp, #20]
    mul r0, r1, r5
    str r0, [sp, #12]
    ldr r0, [sp, #12]
    add r0, r6, r0
    str r0, [sp, #16]
    ldr r0, [sp, #16]
    ldr r1, [r0]
    ldr r5, =-1
    cmp r1, r5
    ldr r6, =0
    ldrne r6, =1
    ldr r0, =-1
    str r0, [sp, #8]
    ldr r0, [sp, #8]
    cmp r1, r0
    ldr r0, [sp, #20]
    bne bb3_21
    b bb3_22
bb3_24:
    str r0, [sp, #20]
    add r0, r3, #1
    str r0, [sp, #32]
    STM SP, {r0, r3}
    ldr r0, [sp, #32]
    bl put_int
    LDM sp, {r0, r3}
    STM SP, {r0, r3}
    ldr r0, =10
    bl put_char
    LDM sp, {r0, r3}
    ldr r0, [sp, #20]
    Ldr r6, =1
    b bb3_25
bb3_25:
    Mov r1, r6
    Mov r5, r9
    b bb3_7
bb3_26:
    STM SP, {r0, r2, r3}
    ldr r0, =0
    bl findfa
    LDMIB SP, {r2, r3}
    mov r6, r0
    ldr r0, [SP]
    STM SP, {r0, r2, r3}
    mov r0, r7
    bl findfa
    LDMIB SP, {r2, r3}
    mov r5, r0
    ldr r0, [SP]
    cmp r6, r5
    ldr r1, =0
    ldreq r1, =1
    cmp r6, r5
    beq bb3_24
    Mov r6, r2
    b bb3_25
bb3_27:
    b litpool3_4
    .pool
litpool3_4:
    add r5, r7, #0
    ldr r1, Addr3_1
    ldr r6, =4
    str r0, [sp, #20]
    mul r0, r5, r6
    str r0, [sp, #20]
    ldr r0, [sp, #20]
    add r0, r1, r0
    str r0, [sp, #40]
    ldr r0, [sp, #40]
    ldr r5, [r0]
    ldr r6, =-1
    cmp r5, r6
    ldr r1, =0
    ldrne r1, =1
    ldr r0, =-1
    str r0, [sp, #80]
    ldr r0, [sp, #80]
    cmp r5, r0
    ldr r0, [sp, #20]
    bne bb3_26
    Mov r6, r2
    b bb3_25
bb3_28:
    STM SP, {r1, r2, r3}
    ldr r0, =-1
    bl put_int
    LDM sp, {r1, r2, r3}
    STM SP, {r1, r2, r3}
    ldr r0, =10
    bl put_char
    LDM sp, {r1, r2, r3}
    b bb3_29
bb3_29:
    Mov r0, r1
    Mov r1, r7
    Mov r4, r6
    Mov r5, r9
    Ldr r6, =10
    Mov r7, r8
    b bb3_0
bb3_30:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr3_0:
    .long ..n
Addr3_1:
    .long ..array

    .type ..array, %object
    .comm ..array, 440, 4

    .type ..n, %object
    .bss
    .globl ..n
    .p2align 2
..n:
    .long 0
    .size ..n, 4

