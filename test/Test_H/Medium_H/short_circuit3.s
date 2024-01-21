    .arch armv8 
    .text 
    .globl set_a
    .p2align 2
    .type set_a, %function
set_a:
    push {lr}
    sub sp, sp, #16
    push {r1}
    ldr r1, Addr0_0
    str r0, [r1]
    pop {r1}
    ldr r1, Addr0_0
    ldr r1, [r1]
    b bb0_0
bb0_0:
    mov r0, r1
    add sp, sp, #16
    pop {lr}
    bx lr
    .pool
Addr0_0:
    .long ..a

    .globl set_b
    .p2align 2
    .type set_b, %function
set_b:
    push {lr}
    sub sp, sp, #16
    push {r1}
    ldr r1, Addr1_0
    str r0, [r1]
    pop {r1}
    ldr r1, Addr1_0
    ldr r1, [r1]
    b bb1_0
bb1_0:
    mov r0, r1
    add sp, sp, #16
    pop {lr}
    bx lr
    .pool
Addr1_0:
    .long ..b

    .globl set_d
    .p2align 2
    .type set_d, %function
set_d:
    push {lr}
    sub sp, sp, #16
    push {r1}
    ldr r1, Addr2_0
    str r0, [r1]
    pop {r1}
    ldr r1, Addr2_0
    ldr r1, [r1]
    b bb2_0
bb2_0:
    mov r0, r1
    add sp, sp, #16
    pop {lr}
    bx lr
    .pool
Addr2_0:
    .long ..d

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =2
    push {r1}
    ldr r1, Addr3_0
    str r0, [r1]
    pop {r1}
    ldr r1, =3
    push {r0}
    ldr r0, Addr3_1
    str r1, [r0]
    pop {r0}
    STM SP, {r2}
    ldr r0, =0
    bl set_a
    LDM SP, {r2}
    mov r2, r0
    ldr r3, =0
    cmp r2, r3
    ldr r4, =0
    ldrne r4, =1
    ldr r5, =0
    cmp r2, r5
    bne bb3_2
    b bb3_1
bb3_0:
    b bb3_1
bb3_1:
    ldr r6, Addr3_0
    ldr r6, [r6]
    mov r0, r6
    bl put_int
    ldr r0, =32
    bl put_char
    ldr r7, Addr3_1
    ldr r7, [r7]
    mov r0, r7
    bl put_int
    ldr r0, =32
    bl put_char
    ldr r8, =2
    push {r0}
    ldr r0, Addr3_0
    str r8, [r0]
    pop {r0}
    ldr r9, =3
    push {r0}
    ldr r0, Addr3_1
    str r9, [r0]
    pop {r0}
    STM SP, {r0}
    ldr r0, =0
    bl set_a
    ldr r1, =0
    cmp r0, r1
    ldr r3, =0
    ldrne r3, =1
    ldr r2, =0
    cmp r0, r2
    bne bb3_5
    b bb3_4
bb3_2:
    b litpool3_0
    .pool
litpool3_0:
    ldr r0, =1
    bl set_b
    mov r7, r0
    ldr r8, =0
    cmp r7, r8
    ldr r9, =0
    ldrne r9, =1
    ldr r5, =0
    cmp r7, r5
    bne bb3_0
    b bb3_1
bb3_3:
    b bb3_4
bb3_4:
    ldr r5, Addr3_0
    ldr r5, [r5]
    mov r0, r5
    bl put_int
    ldr r0, =32
    bl put_char
    ldr r4, Addr3_1
    ldr r4, [r4]
    mov r0, r4
    bl put_int
    ldr r0, =10
    bl put_char
    ldr r6, =2
    push {r0}
    ldr r0, Addr3_2
    str r6, [r0]
    pop {r0}
    ldr r7, =1
    ldr r8, =1
    cmp r7, r8
    ldr r9, =0
    ldrge r9, =1
    ldr r1, =1
    ldr r2, =1
    cmp r1, r2
    bge bb3_8
    b bb3_7
bb3_5:
    ldr r0, =1
    bl set_b
    mov r4, r0
    ldr r0, =0
    cmp r4, r0
    ldr r2, =0
    ldrne r2, =1
    ldr r6, =0
    cmp r4, r6
    bne bb3_3
    b bb3_4
bb3_6:
    b bb3_7
bb3_7:
    ldr r0, Addr3_2
    ldr r0, [r0]
    STM SP, {r0}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r0}
    ldr r0, =32
    bl put_char
    ldr r3, =1
    ldr r5, =1
    cmp r3, r5
    ldr r4, =0
    ldrle r4, =1
    ldr r6, =1
    ldr r7, =1
    cmp r6, r7
    ble bb3_9
    b bb3_11
bb3_8:
    STM SP, {r1}
    ldr r0, =3
    bl set_d
    LDM SP, {r1}
    mov r1, r0
    ldr r9, =0
    cmp r1, r9
    ldr r3, =0
    ldrne r3, =1
    ldr r5, =0
    cmp r1, r5
    bne bb3_6
    b bb3_7
bb3_9:
    b litpool3_1
    .pool
litpool3_1:
    b bb3_10
bb3_10:
    ldr r0, Addr3_2
    ldr r0, [r0]
    STM SP, {r0}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r0}
    ldr r0, =10
    bl put_char
    ldr r3, =16
    ldr r5, =0
    cmp r3, r5
    ldr r6, =0
    ldrge r6, =1
    ldr r7, =16
    ldr r4, =0
    cmp r7, r4
    bge bb3_12
    b bb3_13
bb3_11:
    ldr r0, =4
    bl set_d
    mov r8, r0
    ldr r1, =0
    cmp r8, r1
    ldr r2, =0
    ldrne r2, =1
    ldr r9, =0
    cmp r8, r9
    bne bb3_9
    b bb3_10
bb3_12:
    ldr r0, =65
    bl put_char
    b bb3_13
bb3_13:
    ldr r1, =18
    ldr r9, =18
    cmp r1, r9
    ldr r8, =0
    ldrne r8, =1
    ldr r2, =18
    ldr r0, =18
    cmp r2, r0
    bne bb3_14
    b bb3_15
bb3_14:
    ldr r0, =66
    bl put_char
    b bb3_15
bb3_15:
    ldr r3, =1
    ldr r5, =8
    cmp r3, r5
    ldr r7, =0
    ldrlt r7, =1
    mov r4, r7
    ldr r6, =1
    cmp r4, r6
    ldr r1, =0
    ldrne r1, =1
    ldr r9, =1
    cmp r4, r9
    bne bb3_16
    b bb3_17
bb3_16:
    b litpool3_2
    .pool
litpool3_2:
    ldr r0, =67
    bl put_char
    b bb3_17
bb3_17:
    ldr r2, =3
    ldr r0, =4
    cmp r2, r0
    ldr r8, =0
    ldrgt r8, =1
    mov r3, r8
    ldr r5, =0
    cmp r3, r5
    ldr r7, =0
    ldreq r7, =1
    ldr r6, =0
    cmp r3, r6
    beq bb3_18
    b bb3_19
bb3_18:
    ldr r0, =68
    bl put_char
    b bb3_19
bb3_19:
    ldr r9, =102
    ldr r4, =63
    cmp r9, r4
    ldr r1, =0
    ldrle r1, =1
    mov r2, r1
    ldr r0, =1
    cmp r0, r2
    ldr r8, =0
    ldreq r8, =1
    ldr r5, =1
    cmp r5, r2
    beq bb3_20
    b bb3_21
bb3_20:
    ldr r0, =69
    bl put_char
    b bb3_21
bb3_21:
    ldr r6, =0
    ldr r3, =0
    cmp r6, r3
    ldr r7, =0
    ldreq r7, =1
    mov r9, r7
    rsb r4, r9, #0
    ldr r1, =-1
    cmp r1, r4
    ldr r0, =0
    ldreq r0, =1
    ldr r5, =-1
    cmp r5, r4
    beq bb3_22
    b bb3_23
bb3_22:
    ldr r0, =70
    bl put_char
    b bb3_23
bb3_23:
    b litpool3_3
    .pool
litpool3_3:
    ldr r0, =10
    bl put_char
    b bb3_24
bb3_24:
    ldr r2, =0
    ldr r8, =0
    cmp r2, r8
    ldr r6, =0
    ldrne r6, =1
    ldr r3, =0
    ldr r7, =0
    cmp r3, r7
    bne bb3_27
    b bb3_26
bb3_25:
    ldr r0, =32
    bl put_char
    b bb3_24
bb3_26:
    ldr r9, =0
    ldr r1, =0
    cmp r9, r1
    ldr r5, =0
    ldrne r5, =1
    ldr r4, =0
    ldr r0, =0
    cmp r4, r0
    bne bb3_28
    b bb3_30
bb3_27:
    ldr r0, =1
    ldr r2, =0
    cmp r0, r2
    ldr r8, =0
    ldrne r8, =1
    ldr r6, =1
    ldr r7, =0
    cmp r6, r7
    bne bb3_25
    b bb3_26
bb3_28:
    ldr r0, =67
    bl put_char
    b bb3_29
bb3_29:
    ldr r9, =0
    ldr r1, =1
    cmp r9, r1
    ldr r4, =0
    ldrge r4, =1
    ldr r0, =0
    ldr r5, =1
    cmp r0, r5
    bge bb3_31
    b bb3_33
bb3_30:
    b litpool3_4
    .pool
litpool3_4:
    ldr r2, =1
    ldr r8, =0
    cmp r2, r8
    ldr r3, =0
    ldrne r3, =1
    ldr r7, =1
    ldr r6, =0
    cmp r7, r6
    bne bb3_28
    b bb3_29
bb3_31:
    ldr r0, =72
    bl put_char
    b bb3_32
bb3_32:
    ldr r9, =2
    ldr r1, =1
    cmp r9, r1
    ldr r0, =0
    ldrge r0, =1
    ldr r5, =2
    ldr r4, =1
    cmp r5, r4
    bge bb3_36
    b bb3_35
bb3_33:
    ldr r2, =1
    ldr r8, =0
    cmp r2, r8
    ldr r7, =0
    ldrle r7, =1
    ldr r6, =1
    ldr r3, =0
    cmp r6, r3
    ble bb3_31
    b bb3_32
bb3_34:
    ldr r0, =73
    bl put_char
    b bb3_35
bb3_35:
    ldr r2, =1
    ldr r8, =0
    cmp r2, r8
    ldr r6, =0
    ldreq r6, =1
    mov r3, r6
    ldr r7, =0
    cmp r7, r3
    ldr r9, =0
    ldreq r9, =1
    ldr r1, =0
    cmp r1, r3
    beq bb3_40
    b bb3_39
bb3_36:
    ldr r1, =4
    ldr r9, =3
    cmp r1, r9
    ldr r3, =0
    ldrne r3, =1
    ldr r5, =4
    ldr r4, =3
    cmp r5, r4
    bne bb3_34
    b bb3_35
bb3_37:
    b litpool3_5
    .pool
litpool3_5:
    ldr r0, =74
    bl put_char
    b bb3_38
bb3_38:
    ldr r6, =1
    ldr r7, =0
    cmp r6, r7
    ldr r1, =0
    ldreq r1, =1
    mov r3, r1
    ldr r9, =0
    cmp r9, r3
    ldr r5, =0
    ldreq r5, =1
    ldr r4, =0
    cmp r4, r3
    beq bb3_41
    b bb3_43
bb3_39:
    ldr r5, =4
    ldr r4, =4
    cmp r5, r4
    ldr r0, =0
    ldrge r0, =1
    ldr r2, =4
    ldr r8, =4
    cmp r2, r8
    bge bb3_37
    b bb3_38
bb3_40:
    ldr r0, =3
    ldr r2, =3
    cmp r0, r2
    ldr r8, =0
    ldrlt r8, =1
    ldr r6, =3
    ldr r7, =3
    cmp r6, r7
    blt bb3_37
    b bb3_39
bb3_41:
    ldr r0, =75
    bl put_char
    b bb3_42
bb3_42:
    ldr r0, =10
    bl put_char
    b bb3_45
bb3_43:
    ldr r0, =3
    ldr r2, =3
    cmp r0, r2
    ldr r8, =0
    ldrlt r8, =1
    ldr r6, =3
    ldr r7, =3
    cmp r6, r7
    blt bb3_44
    b bb3_42
bb3_44:
    b litpool3_6
    .pool
litpool3_6:
    ldr r1, =4
    ldr r9, =4
    cmp r1, r9
    ldr r3, =0
    ldrge r3, =1
    ldr r5, =4
    ldr r4, =4
    cmp r5, r4
    bge bb3_41
    b bb3_42
bb3_45:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr3_0:
    .long ..a
Addr3_1:
    .long ..b
Addr3_2:
    .long ..d

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

    .type ..d, %object
    .bss
    .globl ..d
    .p2align 2
..d:
    .long 0
    .size ..d, 4

