    .arch armv8 
    .text 
    .globl next_char
    .p2align 2
    .type next_char, %function
next_char:
    push {r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl get_char
    push {r1}
    ldr r1, Addr0_0
    str r0, [r1]
    pop {r1}
    ldr r1, Addr0_0
    ldr r1, [r1]
    b bb0_0
bb0_0:
    mov r0, r1
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool
Addr0_0:
    .long ..last_char

    .globl is_space
    .p2align 2
    .type is_space, %function
is_space:
    push {r4, r5, r6, r7, lr}
    sub sp, sp, #20
    ldr r1, =32
    cmp r0, r1
    ldr r2, =0
    ldreq r2, =1
    ldr r3, =32
    cmp r0, r3
    beq bb1_0
    b bb1_1
bb1_0:
    Ldr r7, =1
    b bb1_4
bb1_1:
    ldr r4, =10
    cmp r0, r4
    ldr r5, =0
    ldreq r5, =1
    ldr r6, =10
    cmp r0, r6
    beq bb1_2
    b bb1_3
bb1_2:
    Ldr r7, =1
    b bb1_4
bb1_3:
    Ldr r7, =0
    b bb1_4
bb1_4:
    mov r0, r7
    add sp, sp, #20
    pop {r4, r5, r6, r7, lr}
    bx lr
    .pool

    .globl is_num
    .p2align 2
    .type is_num, %function
is_num:
    push {r4, r5, r6, r7, lr}
    sub sp, sp, #20
    ldr r1, =48
    cmp r0, r1
    ldr r2, =0
    ldrge r2, =1
    ldr r3, =48
    cmp r0, r3
    bge bb2_0
    b bb2_1
bb2_0:
    b litpool2_0
    .pool
litpool2_0:
    ldr r5, =57
    cmp r0, r5
    ldr r6, =0
    ldrle r6, =1
    ldr r7, =57
    cmp r0, r7
    ble bb2_2
    b bb2_3
bb2_1:
    Ldr r4, =0
    b bb2_4
bb2_2:
    Ldr r4, =1
    b bb2_4
bb2_3:
    Ldr r4, =0
    b bb2_4
bb2_4:
    mov r0, r4
    add sp, sp, #20
    pop {r4, r5, r6, r7, lr}
    bx lr
    .pool

    .globl next_token
    .p2align 2
    .type next_token, %function
next_token:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    b bb3_0
bb3_0:
    ldr r0, Addr3_0
    ldr r0, [r0]
    STM SP, {r0, r1}
    ldr r0, [sp]
    bl is_space
    LDMIB SP, {r1}
    mov r1, r0
    ldr r0, [SP]
    ldr r2, =0
    cmp r1, r2
    ldr r3, =0
    ldrne r3, =1
    ldr r4, =0
    cmp r1, r4
    bne bb3_1
    b bb3_2
bb3_1:
    bl next_char
    mov r6, r0
    b bb3_0
bb3_2:
    ldr r5, Addr3_0
    ldr r5, [r5]
    mov r0, r5
    bl is_num
    mov r6, r0
    ldr r7, =0
    cmp r6, r7
    ldr r8, =0
    ldrne r8, =1
    ldr r9, =0
    cmp r6, r9
    bne bb3_3
    b bb3_4
bb3_3:
    b litpool3_0
    .pool
litpool3_0:
    ldr r3, Addr3_0
    ldr r3, [r3]
    sub r5, r3, #48
    push {r0}
    ldr r0, Addr3_1
    str r5, [r0]
    pop {r0}
    b bb3_6
bb3_4:
    ldr r0, Addr3_0
    ldr r0, [r0]
    push {r1}
    ldr r1, Addr3_2
    str r0, [r1]
    pop {r1}
    STM SP, {r2}
    bl next_char
    LDM SP, {r2}
    mov r2, r0
    ldr r4, =1
    push {r0}
    ldr r0, Addr3_3
    str r4, [r0]
    pop {r0}
    b bb3_5
bb3_5:
    ldr r1, Addr3_3
    ldr r1, [r1]
    b bb3_9
bb3_6:
    bl next_char
    mov r7, r0
    mov r0, r7
    bl is_num
    mov r6, r0
    ldr r8, =0
    cmp r6, r8
    ldr r9, =0
    ldrne r9, =1
    ldr r0, =0
    cmp r6, r0
    bne bb3_7
    b bb3_8
bb3_7:
    ldr r2, Addr3_1
    ldr r2, [r2]
    ldr r1, =10
    mul r3, r2, r1
    ldr r5, Addr3_0
    ldr r5, [r5]
    add r7, r3, r5
    sub r8, r7, #48
    push {r0}
    ldr r0, Addr3_1
    str r8, [r0]
    pop {r0}
    b bb3_6
bb3_8:
    ldr r4, =0
    push {r0}
    ldr r0, Addr3_3
    str r4, [r0]
    pop {r0}
    b bb3_5
bb3_9:
    b litpool3_1
    .pool
litpool3_1:
    mov r0, r1
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr3_0:
    .long ..last_char
Addr3_1:
    .long ..num
Addr3_2:
    .long ..other
Addr3_3:
    .long ..cur_token

    .globl panic
    .p2align 2
    .type panic, %function
panic:
    push {r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =112
    bl put_char
    ldr r0, =97
    bl put_char
    ldr r0, =110
    bl put_char
    ldr r0, =105
    bl put_char
    ldr r0, =99
    bl put_char
    ldr r0, =33
    bl put_char
    ldr r0, =10
    bl put_char
    b bb4_0
bb4_0:
    ldr r0, =-1
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

    .globl get_op_prec
    .p2align 2
    .type get_op_prec, %function
get_op_prec:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #20
    ldr r1, =43
    cmp r0, r1
    ldr r2, =0
    ldreq r2, =1
    ldr r3, =43
    cmp r0, r3
    beq bb5_0
    b bb5_1
bb5_0:
    Ldr r7, =10
    b bb5_10
bb5_1:
    ldr r4, =45
    cmp r0, r4
    ldr r5, =0
    ldreq r5, =1
    ldr r6, =45
    cmp r0, r6
    beq bb5_2
    b bb5_3
bb5_2:
    Ldr r7, =10
    b bb5_10
bb5_3:
    ldr r7, =42
    cmp r0, r7
    ldr r8, =0
    ldreq r8, =1
    ldr r9, =42
    cmp r0, r9
    beq bb5_4
    b bb5_5
bb5_4:
    b litpool5_0
    .pool
litpool5_0:
    Ldr r7, =20
    b bb5_10
bb5_5:
    ldr r1, =47
    cmp r0, r1
    ldr r3, =0
    ldreq r3, =1
    ldr r2, =47
    cmp r0, r2
    beq bb5_6
    b bb5_7
bb5_6:
    Ldr r7, =20
    b bb5_10
bb5_7:
    ldr r4, =37
    cmp r0, r4
    ldr r6, =0
    ldreq r6, =1
    ldr r5, =37
    cmp r0, r5
    beq bb5_8
    b bb5_9
bb5_8:
    Ldr r7, =20
    b bb5_10
bb5_9:
    Ldr r7, =0
    b bb5_10
bb5_10:
    mov r0, r7
    add sp, sp, #20
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl stack_push
    .p2align 2
    .type stack_push, %function
stack_push:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #24
    ldr r2, =0
    cmp r0, r2
    ldr r3, =0
    ldreq r3, =1
    ldr r4, =0
    cmp r0, r4
    beq bb6_0
    b bb6_1
bb6_0:
    ldr r8, Addr6_0
    ldr r2, =0
    ldr r3, =4
    mul r6, r2, r3
    add r7, r8, r6
    ldr r9, Addr6_0
    ldr r5, =0
    ldr r0, =4
    mul r4, r5, r0
    add r2, r9, r4
    ldr r3, [r2]
    add r6, r3, #1
    str r6, [r7]
    ldr r8, Addr6_0
    ldr r5, =0
    ldr r0, =4
    mul r9, r5, r0
    add r4, r8, r9
    ldr r2, [r4]
    add r3, r2, #0
    ldr r6, Addr6_0
    ldr r7, =4
    mul r5, r3, r7
    add r0, r6, r5
    str r1, [r0]
    b bb6_2
bb6_1:
    b litpool6_0
    .pool
litpool6_0:
    ldr r5, Addr6_1
    ldr r6, =0
    ldr r7, =4
    mul r8, r6, r7
    add r9, r5, r8
    ldr r2, Addr6_1
    ldr r0, =0
    ldr r4, =4
    mul r3, r0, r4
    add r6, r2, r3
    ldr r7, [r6]
    add r5, r7, #1
    str r5, [r9]
    ldr r8, Addr6_1
    ldr r0, =0
    ldr r4, =4
    mul r2, r0, r4
    add r3, r8, r2
    ldr r6, [r3]
    add r7, r6, #0
    ldr r5, Addr6_1
    ldr r9, =4
    mul r0, r7, r9
    add r4, r5, r0
    str r1, [r4]
    b bb6_2
bb6_2:
    b bb6_3
bb6_3:
    add sp, sp, #24
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr6_0:
    .long ..oprs
Addr6_1:
    .long ..ops

    .globl stack_pop
    .p2align 2
    .type stack_pop, %function
stack_pop:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #20
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldreq r2, =1
    ldr r3, =0
    cmp r0, r3
    beq bb7_0
    b bb7_1
bb7_0:
    ldr r0, Addr7_0
    ldr r2, =0
    ldr r3, =4
    mul r5, r2, r3
    add r7, r0, r5
    ldr r8, [r7]
    add r4, r8, #0
    ldr r1, Addr7_0
    ldr r6, =4
    mul r9, r4, r6
    add r2, r1, r9
    ldr r3, [r2]
    ldr r5, Addr7_0
    ldr r0, =0
    ldr r7, =4
    mul r8, r0, r7
    add r4, r5, r8
    ldr r6, Addr7_0
    ldr r1, =0
    ldr r9, =4
    mul r2, r1, r9
    add r0, r6, r2
    ldr r7, [r0]
    sub r5, r7, #1
    str r5, [r4]
    Mov r9, r3
    b bb7_2
bb7_1:
    ldr r4, Addr7_1
    ldr r5, =0
    ldr r6, =4
    mul r7, r5, r6
    add r8, r4, r7
    ldr r9, [r8]
    add r1, r9, #0
    ldr r0, Addr7_1
    ldr r3, =4
    mul r2, r1, r3
    add r5, r0, r2
    ldr r6, [r5]
    ldr r4, Addr7_1
    ldr r7, =0
    ldr r8, =4
    mul r9, r7, r8
    add r1, r4, r9
    ldr r3, Addr7_1
    ldr r0, =0
    ldr r2, =4
    mul r5, r0, r2
    add r7, r3, r5
    ldr r8, [r7]
    sub r4, r8, #1
    str r4, [r1]
    Mov r9, r6
    b bb7_2
bb7_2:
    b litpool7_0
    .pool
litpool7_0:
    b bb7_3
bb7_3:
    mov r0, r9
    add sp, sp, #20
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr7_0:
    .long ..oprs
Addr7_1:
    .long ..ops

    .globl stack_peek
    .p2align 2
    .type stack_peek, %function
stack_peek:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #20
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldreq r2, =1
    ldr r3, =0
    cmp r0, r3
    beq bb8_0
    b bb8_1
bb8_0:
    ldr r7, Addr8_0
    ldr r8, =0
    ldr r9, =4
    mul r1, r8, r9
    add r3, r7, r1
    ldr r0, [r3]
    add r2, r0, #0
    ldr r5, Addr8_0
    ldr r6, =4
    mul r4, r2, r6
    add r8, r5, r4
    ldr r9, [r8]
    Mov r4, r9
    b bb8_2
bb8_1:
    ldr r4, Addr8_1
    ldr r5, =0
    ldr r6, =4
    mul r7, r5, r6
    add r8, r4, r7
    ldr r9, [r8]
    add r1, r9, #0
    ldr r0, Addr8_1
    ldr r3, =4
    mul r2, r1, r3
    add r5, r0, r2
    ldr r6, [r5]
    Mov r4, r6
    b bb8_2
bb8_2:
    b bb8_3
bb8_3:
    mov r0, r4
    add sp, sp, #20
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr8_0:
    .long ..oprs
Addr8_1:
    .long ..ops

    .globl stack_size
    .p2align 2
    .type stack_size, %function
stack_size:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #20
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldreq r2, =1
    ldr r3, =0
    cmp r0, r3
    beq bb9_0
    b bb9_1
bb9_0:
    ldr r0, Addr9_0
    ldr r3, =0
    ldr r2, =4
    mul r5, r3, r2
    add r6, r0, r5
    ldr r4, [r6]
    Mov r1, r4
    b bb9_2
bb9_1:
    b litpool9_0
    .pool
litpool9_0:
    ldr r4, Addr9_1
    ldr r5, =0
    ldr r6, =4
    mul r7, r5, r6
    add r8, r4, r7
    ldr r9, [r8]
    Mov r1, r9
    b bb9_2
bb9_2:
    b bb9_3
bb9_3:
    mov r0, r1
    add sp, sp, #20
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr9_0:
    .long ..oprs
Addr9_1:
    .long ..ops

    .globl eval_op
    .p2align 2
    .type eval_op, %function
eval_op:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #28
    ldr r3, =43
    cmp r0, r3
    ldr r4, =0
    ldreq r4, =1
    ldr r5, =43
    cmp r0, r5
    beq bb10_0
    b bb10_1
bb10_0:
    add r5, r1, r2
    b bb10_10
bb10_1:
    ldr r6, =45
    cmp r0, r6
    ldr r7, =0
    ldreq r7, =1
    ldr r8, =45
    cmp r0, r8
    beq bb10_2
    b bb10_3
bb10_2:
    sub r3, r1, r2
    Mov r5, r3
    b bb10_10
bb10_3:
    ldr r9, =42
    cmp r0, r9
    ldr r3, =0
    ldreq r3, =1
    ldr r5, =42
    cmp r0, r5
    beq bb10_4
    b bb10_5
bb10_4:
    b litpool10_0
    .pool
litpool10_0:
    mul r9, r1, r2
    Mov r5, r9
    b bb10_10
bb10_5:
    ldr r4, =47
    cmp r0, r4
    ldr r6, =0
    ldreq r6, =1
    ldr r7, =47
    cmp r0, r7
    beq bb10_6
    b bb10_7
bb10_6:
    sdiv r0, r1, r2
    Mov r5, r0
    b bb10_10
bb10_7:
    ldr r8, =37
    cmp r0, r8
    ldr r9, =0
    ldreq r9, =1
    ldr r3, =37
    cmp r0, r3
    beq bb10_8
    b bb10_9
bb10_8:
    sdiv r6, r1, r2
    mul r7, r6, r2
    sub r8, r1, r7
    Mov r5, r8
    b bb10_10
bb10_9:
    Ldr r5, =0
    b bb10_10
bb10_10:
    mov r0, r5
    add sp, sp, #28
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl eval
    .p2align 2
    .type eval, %function
eval:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, Addr11_2
    ldr r0, [r0]
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldrne r2, =1
    ldr r3, =0
    cmp r0, r3
    bne bb11_0
    b bb11_1
bb11_0:
    STM SP, {r1}
    bl panic
    LDM SP, {r1}
    mov r1, r0
    Mov r9, r1
    b bb11_17
bb11_1:
    b litpool11_0
    .pool
litpool11_0:
    ldr r4, Addr11_0
    ldr r4, [r4]
    ldr r0, =0
    mov r1, r4
    bl stack_push
    bl next_token
    mov r5, r0
    b bb11_2
bb11_2:
    ldr r7, Addr11_2
    ldr r7, [r7]
    ldr r8, =1
    cmp r7, r8
    ldr r9, =0
    ldreq r9, =1
    ldr r1, =1
    cmp r7, r1
    beq bb11_3
    Mov r0, r6
    b bb11_4
bb11_3:
    ldr r3, Addr11_1
    ldr r3, [r3]
    STM SP, {r3}
    ldr r0, [sp]
    bl get_op_prec
    LDM SP, {r3}
    mov r5, r0
    ldr r8, =0
    cmp r5, r8
    ldr r7, =0
    ldreq r7, =1
    ldr r9, =0
    cmp r5, r9
    beq bb11_5
    b bb11_6
bb11_4:
    STM SP, {r0, r2}
    bl next_token
    LDMIB SP, {r2}
    mov r2, r0
    ldr r0, [SP]
    b bb11_14
bb11_5:
    Mov r0, r3
    b bb11_4
bb11_6:
    STM SP, {r3}
    bl next_token
    LDM SP, {r3}
    mov r6, r0
    b bb11_7
bb11_7:
    STM SP, {r1, r3}
    ldr r0, =1
    bl stack_size
    LDM SP, {r1, r3}
    mov r1, r0
    ldr r2, =0
    cmp r1, r2
    ldr r4, =0
    ldrne r4, =1
    ldr r0, =0
    cmp r1, r0
    bne bb11_8
    b bb11_9
bb11_8:
    b litpool11_1
    .pool
litpool11_1:
    STM SP, {r3}
    ldr r0, =1
    bl stack_peek
    LDM SP, {r3}
    mov r4, r0
    STM SP, {r0, r3}
    mov r0, r4
    bl get_op_prec
    LDMIB SP, {r3}
    STM SP, {r0, r3}
    ldr r0, [sp, #4]
    bl get_op_prec
    LDMIB SP, {r3}
    mov r5, r0
    ldr r0, [SP]
    cmp r0, r5
    ldr r8, =0
    ldrge r8, =1
    cmp r0, r5
    bge bb11_10
    b bb11_11
bb11_9:
    STM SP, {r3}
    ldr r0, =1
    ldr r1, [sp]
    bl stack_push
    LDM sp, {r3}
    ldr r8, Addr11_2
    ldr r8, [r8]
    ldr r5, =0
    cmp r8, r5
    ldr r7, =0
    ldrne r7, =1
    ldr r9, =0
    cmp r8, r9
    bne bb11_12
    b bb11_13
bb11_10:
    STM SP, {r3}
    ldr r0, =1
    bl stack_pop
    LDM SP, {r3}
    mov r7, r0
    STM SP, {r3}
    ldr r0, =0
    bl stack_pop
    LDM SP, {r3}
    mov r9, r0
    STM SP, {r3}
    ldr r0, =0
    bl stack_pop
    LDM SP, {r3}
    mov r6, r0
    STM SP, {r2, r3}
    mov r0, r7
    mov r1, r6
    mov r2, r9
    bl eval_op
    LDM SP, {r2, r3}
    mov r2, r0
    STM SP, {r2, r3}
    ldr r0, =0
    ldr r1, [sp]
    bl stack_push
    LDM sp, {r2, r3}
    b bb11_7
bb11_11:
    b bb11_9
bb11_12:
    STM SP, {r1, r3}
    bl panic
    LDM SP, {r1, r3}
    mov r1, r0
    Mov r9, r1
    b bb11_17
bb11_13:
    ldr r6, Addr11_0
    ldr r6, [r6]
    STM SP, {r3}
    ldr r0, =0
    mov r1, r6
    bl stack_push
    LDM sp, {r3}
    STM SP, {r2, r3}
    bl next_token
    LDM SP, {r2, r3}
    mov r2, r0
    Mov r6, r3
    b bb11_2
bb11_14:
    b litpool11_2
    .pool
litpool11_2:
    STM SP, {r0, r3}
    ldr r0, =1
    bl stack_size
    LDMIB SP, {r3}
    mov r3, r0
    ldr r0, [SP]
    ldr r4, =0
    cmp r3, r4
    ldr r5, =0
    ldrne r5, =1
    ldr r8, =0
    cmp r3, r8
    bne bb11_15
    b bb11_16
bb11_15:
    STM SP, {r0}
    ldr r0, =1
    bl stack_pop
    mov r6, r0
    ldr r0, [SP]
    STM SP, {r0, r1}
    ldr r0, =0
    bl stack_pop
    LDMIB SP, {r1}
    mov r1, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2}
    ldr r0, =0
    bl stack_pop
    LDMIB SP, {r1, r2}
    mov r2, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2}
    mov r0, r6
    ldr r1, [sp, #8]
    ldr r2, [sp, #4]
    bl eval_op
    LDMIB SP, {r1, r2}
    mov r4, r0
    ldr r0, [SP]
    STM SP, {r0}
    ldr r0, =0
    mov r1, r4
    bl stack_push
    LDM sp, {r0}
    b bb11_14
bb11_16:
    STM SP, {r0}
    ldr r0, =0
    bl stack_peek
    mov r7, r0
    ldr r0, [SP]
    Mov r9, r7
    b bb11_17
bb11_17:
    mov r0, r9
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr11_0:
    .long ..num
Addr11_1:
    .long ..other
Addr11_2:
    .long ..cur_token

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl get_int
    STM SP, {r0, r1}
    bl get_char
    LDMIB SP, {r1}
    mov r1, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2}
    bl next_token
    LDMIB SP, {r1, r2}
    mov r2, r0
    ldr r0, [SP]
    Mov r3, r0
    b bb12_0
bb12_0:
    ldr r4, =0
    cmp r3, r4
    ldr r5, =0
    ldrne r5, =1
    ldr r6, =0
    cmp r3, r6
    bne bb12_1
    b bb12_2
bb12_1:
    STM SP, {r3}
    bl eval
    LDM SP, {r3}
    mov r7, r0
    STM SP, {r3}
    mov r0, r7
    bl put_int
    LDM sp, {r3}
    STM SP, {r3}
    ldr r0, =10
    bl put_char
    LDM sp, {r3}
    sub r8, r3, #1
    Mov r3, r8
    b bb12_0
bb12_2:
    b litpool12_0
    .pool
litpool12_0:
    b bb12_3
bb12_3:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r11, lr}
    bx lr
    .pool

    .type ..TOKEN_NUM, %object
    .section .rodata,"a", %progbits
    .globl ..TOKEN_NUM
    .p2align 2
..TOKEN_NUM:
    .long 0
    .size ..TOKEN_NUM, 4

    .type ..TOKEN_OTHER, %object
    .section .rodata,"a", %progbits
    .globl ..TOKEN_OTHER
    .p2align 2
..TOKEN_OTHER:
    .long 1
    .size ..TOKEN_OTHER, 4

    .type ..last_char, %object
    .data
    .globl ..last_char
    .p2align 2
..last_char:
    .long 32
    .size ..last_char, 4

    .type ..num, %object
    .bss
    .globl ..num
    .p2align 2
..num:
    .long 0
    .size ..num, 4

    .type ..other, %object
    .bss
    .globl ..other
    .p2align 2
..other:
    .long 0
    .size ..other, 4

    .type ..cur_token, %object
    .bss
    .globl ..cur_token
    .p2align 2
..cur_token:
    .long 0
    .size ..cur_token, 4

    .type ..oprs, %object
    .comm ..oprs, 1024, 4

    .type ..ops, %object
    .comm ..ops, 1024, 4

