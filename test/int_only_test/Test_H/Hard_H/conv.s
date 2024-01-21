    .arch armv8 
    .text 
    .globl checkrange
    .p2align 2
    .type checkrange, %function
checkrange:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #20
    Mov r1, r0
    b bb0_0
bb0_0:
    ldr r2, =1073741824
    cmp r1, r2
    ldr r3, =0
    ldrgt r3, =1
    ldr r4, =1073741824
    cmp r1, r4
    bgt bb0_1
    b bb0_2
bb0_1:
    ldr r2, =1073741824
    sub r4, r1, r2
    Mov r1, r4
    b bb0_0
bb0_2:
    Mov r5, r1
    b bb0_3
bb0_3:
    ldr r6, =0
    cmp r5, r6
    ldr r7, =0
    ldrlt r7, =1
    ldr r8, =0
    cmp r5, r8
    blt bb0_4
    b bb0_5
bb0_4:
    ldr r9, =1073741824
    add r0, r5, r9
    Mov r5, r0
    b bb0_3
bb0_5:
    b bb0_6
bb0_6:
    mov r0, r5
    add sp, sp, #20
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl reduce
    .p2align 2
    .type reduce, %function
reduce:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #48
    ldr r3, =0
    cmp r0, r3
    ldr r4, =0
    ldreq r4, =1
    ldr r5, =0
    cmp r0, r5
    beq bb1_0
    b bb1_1
bb1_0:
    b litpool1_0
    .pool
litpool1_0:
    add r6, r1, r2
    mov r0, r6
    bl checkrange
    mov r4, r0
    Mov r3, r4
    b bb1_32
bb1_1:
    ldr r6, =1
    cmp r0, r6
    ldr r7, =0
    ldreq r7, =1
    ldr r8, =1
    cmp r0, r8
    beq bb1_2
    b bb1_3
bb1_2:
    Ldr r7, =1
    Ldr r8, =0
    b bb1_4
bb1_3:
    ldr r9, =2
    cmp r0, r9
    ldr r3, =0
    ldreq r3, =1
    ldr r5, =2
    cmp r0, r5
    beq bb1_10
    b bb1_11
bb1_4:
    ldr r9, =1073741824
    cmp r7, r9
    ldr r5, =0
    ldrlt r5, =1
    ldr r3, =1073741824
    cmp r7, r3
    blt bb1_5
    b bb1_6
bb1_5:
    sdiv r0, r1, r7
    ldr r6, =2
    sdiv r4, r0, r6
    ldr r9, =2
    mul r3, r4, r9
    sub r5, r0, r3
    sdiv r6, r2, r7
    ldr r4, =2
    sdiv r9, r6, r4
    ldr r3, =2
    mul r0, r9, r3
    sub r4, r6, r0
    cmp r5, r4
    ldr r9, =0
    ldreq r9, =1
    cmp r5, r4
    beq bb1_7
    b bb1_8
bb1_6:
    Mov r3, r8
    b bb1_32
bb1_7:
    b litpool1_1
    .pool
litpool1_1:
    ldr r3, =2
    mul r0, r8, r3
    Mov r5, r0
    b bb1_9
bb1_8:
    ldr r3, =2
    mul r0, r8, r3
    add r6, r0, #1
    Mov r5, r6
    b bb1_9
bb1_9:
    ldr r4, =2
    mul r9, r7, r4
    Mov r7, r9
    Mov r8, r5
    b bb1_4
bb1_10:
    cmp r1, r2
    ldr r4, =0
    ldrgt r4, =1
    cmp r1, r2
    bgt bb1_12
    b bb1_13
bb1_11:
    ldr r4, =3
    cmp r0, r4
    ldr r6, =0
    ldreq r6, =1
    ldr r8, =3
    cmp r0, r8
    beq bb1_14
    b bb1_15
bb1_12:
    Mov r3, r1
    b bb1_32
bb1_13:
    Mov r3, r2
    b bb1_32
bb1_14:
    Ldr r0, =1
    Ldr r9, =0
    b bb1_16
bb1_15:
    b litpool1_2
    .pool
litpool1_2:
    ldr r7, =4
    cmp r0, r7
    ldr r9, =0
    ldreq r9, =1
    ldr r5, =4
    cmp r0, r5
    beq bb1_23
    b bb1_24
bb1_16:
    ldr r3, =1073741824
    cmp r0, r3
    ldr r8, =0
    ldrlt r8, =1
    ldr r6, =1073741824
    cmp r0, r6
    blt bb1_17
    b bb1_18
bb1_17:
    sdiv r7, r1, r0
    ldr r5, =2
    sdiv r4, r7, r5
    ldr r3, =2
    mul r6, r4, r3
    sub r8, r7, r6
    ldr r5, =1
    cmp r8, r5
    ldr r4, =0
    ldreq r4, =1
    ldr r3, =1
    cmp r8, r3
    beq bb1_19
    b bb1_22
bb1_18:
    Mov r3, r9
    b bb1_32
bb1_19:
    ldr r5, =2
    mul r3, r9, r5
    add r6, r3, #1
    Mov r7, r6
    b bb1_21
bb1_20:
    ldr r3, =2
    mul r6, r9, r3
    Mov r7, r6
    b bb1_21
bb1_21:
    ldr r4, =2
    mul r8, r0, r4
    Mov r0, r8
    Mov r9, r7
    b bb1_16
bb1_22:
    b litpool1_3
    .pool
litpool1_3:
    sdiv r6, r2, r0
    ldr r7, =2
    sdiv r5, r6, r7
    ldr r8, =2
    mul r3, r5, r8
    sub r4, r6, r3
    ldr r7, =1
    cmp r4, r7
    ldr r5, =0
    ldreq r5, =1
    ldr r8, =1
    cmp r4, r8
    beq bb1_19
    b bb1_20
bb1_23:
    Ldr r4, =1
    Ldr r8, =0
    b bb1_25
bb1_24:
    Ldr r3, =0
    b bb1_32
bb1_25:
    ldr r6, =1073741824
    cmp r4, r6
    ldr r7, =0
    ldrlt r7, =1
    ldr r0, =1073741824
    cmp r4, r0
    blt bb1_26
    b bb1_27
bb1_26:
    sdiv r5, r1, r4
    ldr r9, =2
    sdiv r3, r5, r9
    ldr r6, =2
    mul r0, r3, r6
    sub r7, r5, r0
    ldr r9, =1
    cmp r7, r9
    ldr r3, =0
    ldreq r3, =1
    ldr r6, =1
    cmp r7, r6
    beq bb1_31
    b bb1_29
bb1_27:
    Mov r3, r8
    b bb1_32
bb1_28:
    ldr r6, =2
    mul r7, r8, r6
    add r5, r7, #1
    Mov r9, r5
    b bb1_30
bb1_29:
    b litpool1_4
    .pool
litpool1_4:
    ldr r5, =2
    mul r0, r8, r5
    Mov r9, r0
    b bb1_30
bb1_30:
    ldr r3, =2
    mul r7, r4, r3
    Mov r4, r7
    Mov r8, r9
    b bb1_25
bb1_31:
    sdiv r6, r2, r4
    ldr r5, =2
    sdiv r0, r6, r5
    ldr r3, =2
    mul r7, r0, r3
    sub r9, r6, r7
    ldr r5, =1
    cmp r9, r5
    ldr r0, =0
    ldreq r0, =1
    ldr r3, =1
    cmp r9, r3
    beq bb1_28
    b bb1_29
bb1_32:
    mov r0, r3
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

    .globl getvalue
    .p2align 2
    .type getvalue, %function
getvalue:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #32
    ldr r4, [sp, #44]
    ldr r5, =0
    cmp r3, r5
    ldr r6, =0
    ldrlt r6, =1
    ldr r7, =0
    cmp r3, r7
    blt bb2_0
    b bb2_4
bb2_0:
    Ldr r4, =0
    b bb2_5
bb2_1:
    mul r8, r3, r2
    add r9, r8, r4
    add r5, r9, #0
    add r1, r0, #0
    ldr r6, =4
    mul r7, r5, r6
    add r2, r1, r7
    ldr r3, [r2]
    Mov r4, r3
    b bb2_5
bb2_2:
    cmp r4, r2
    ldr r7, =0
    ldrge r7, =1
    cmp r4, r2
    bge bb2_0
    b bb2_1
bb2_3:
    b litpool2_0
    .pool
litpool2_0:
    cmp r3, r1
    ldr r6, =0
    ldrge r6, =1
    cmp r3, r1
    bge bb2_0
    b bb2_2
bb2_4:
    ldr r8, =0
    cmp r4, r8
    ldr r9, =0
    ldrlt r9, =1
    ldr r5, =0
    cmp r4, r5
    blt bb2_0
    b bb2_3
bb2_5:
    mov r0, r4
    add sp, sp, #32
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl convn
    .p2align 2
    .type convn, %function
convn:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    ldr lr, =144
    sub sp, sp, lr
    ldr r4, [sp, #160]
    ldr r5, [sp, #164]
    Ldr r12, =0
    str r12, [sp, #104]
    Ldr r9, =0
    b bb3_0
bb3_0:
    ldr r9, =1
    str r0, [sp, #20]
    ldr r0, =1
    str r0, [sp, #128]
    ldr r0, [sp, #128]
    cmp r9, r0
    ldr r0, =0
    ldreq r0, =1
    str r0, [sp, #52]
    ldr r0, =1
    str r0, [sp, #128]
    ldr r9, =1
    ldr r0, [sp, #128]
    cmp r0, r9
    ldr r0, [sp, #20]
    beq bb3_1
    b bb3_2
bb3_1:
    Mov r9, r6
    Mov r6, r7
    Mov r7, r8
    Ldr r8, =0
    b bb3_3
bb3_2:
    b bb3_20
bb3_3:
    ldr r9, =1
    str r0, [sp, #20]
    ldr r0, =1
    str r0, [sp, #104]
    ldr r0, [sp, #104]
    cmp r9, r0
    ldr r0, =0
    ldreq r0, =1
    str r0, [sp, #53]
    ldr r0, =1
    str r0, [sp, #96]
    ldr r9, =1
    ldr r0, [sp, #96]
    cmp r0, r9
    ldr r0, [sp, #20]
    beq bb3_4
    str r8, [sp, #108]
    str r9, [sp, #116]
    Mov r9, r7
    Mov r7, r6
    b bb3_5
bb3_4:
    ldr r7, =2
    sdiv r9, r5, r7
    str r0, [sp, #20]
    ldr r0, [sp, #104]
    sub r0, r0, r9
    str r0, [sp, #54]
    ldr r0, [sp, #20]
    Ldr r7, =0
    Mov r9, r6
    ldr r6, [sp, #54]
    b bb3_6
bb3_5:
    b litpool3_0
    .pool
litpool3_0:
    str r0, [sp, #20]
    ldr r0, [sp, #104]
    add r0, r0, #1
    str r0, [sp, #100]
    ldr r0, [sp, #100]
    cmp r0, r3
    ldr r7, =0
    ldrge r7, =1
    ldr r0, [sp, #100]
    cmp r0, r3
    ldr r0, [sp, #20]
    bge bb3_18
    b bb3_19
bb3_6:
    ldr r9, =1
    str r0, [sp, #20]
    ldr r0, =1
    str r0, [sp, #76]
    ldr r0, [sp, #76]
    cmp r9, r0
    ldr r0, =0
    ldreq r0, =1
    str r0, [sp, #58]
    ldr r0, =1
    str r0, [sp, #92]
    ldr r9, =1
    ldr r0, [sp, #92]
    cmp r0, r9
    ldr r0, [sp, #20]
    beq bb3_7
    str r6, [sp, #112]
    str r7, [sp, #124]
    b bb3_8
bb3_7:
    ldr r9, =2
    str r0, [sp, #20]
    sdiv r0, r5, r9
    str r0, [sp, #59]
    ldr r0, [sp, #59]
    sub r0, r8, r0
    str r0, [sp, #63]
    ldr r0, [sp, #20]
    Mov r9, r7
    ldr r7, [sp, #63]
    b bb3_9
bb3_8:
    str r0, [sp, #20]
    ldr r0, [sp, #104]
    mul r9, r0, r4
    add r0, r9, r8
    str r0, [sp, #92]
    ldr r0, [sp, #92]
    add r0, r0, #0
    str r0, [sp, #96]
    add r9, r2, #0
    ldr r9, =4
    ldr r0, [sp, #96]
    mul r0, r0, r9
    str r0, [sp, #48]
    ldr r0, [sp, #48]
    add r0, r9, r0
    str r0, [sp, #44]
    str r1, [sp, #24]
    ldr r1, [sp, #44]
    ldr r0, [sp, #124]
    str r0, [r1]
    add r9, r8, #1
    cmp r9, r4
    ldr r9, =0
    ldrge r9, =1
    cmp r9, r4
    ldr r0, [sp, #20]
    ldr r1, [sp, #24]
    bge bb3_16
    b bb3_17
bb3_9:
    ldr r9, =1
    str r0, [sp, #20]
    ldr r0, =1
    str r0, [sp, #128]
    ldr r0, [sp, #128]
    cmp r9, r0
    ldr r0, =0
    ldreq r0, =1
    str r0, [sp, #67]
    ldr r0, =1
    str r0, [sp, #128]
    ldr r9, =1
    ldr r0, [sp, #128]
    cmp r0, r9
    ldr r0, [sp, #20]
    beq bb3_10
    str r9, [sp, #120]
    Mov r9, r7
    b bb3_11
bb3_10:
    add r9, r1, #0
    ldr r9, =0
    str r0, [sp, #20]
    ldr r0, =4
    str r0, [sp, #128]
    ldr r0, [sp, #128]
    mul r0, r9, r0
    str r0, [sp, #40]
    ldr r0, [sp, #40]
    add r0, r9, r0
    str r0, [sp, #36]
    STM SP, {r0, r1, r2, r3}
    push {r7}
    ldr r0, [sp, #40]
    ldr r1, [sp, #16]
    mov r2, r4
    mov r3, r6
    bl getvalue
    ADD sp, sp, #4
    LDMIB SP, {r1, r2, r3}
    mov r9, r0
    ldr r0, [SP]
    ldr r0, [sp, #20]
    STM SP, {r0, r1, r2, r3}
    ldr r0, [sp]
    mov r1, r9
    mov r2, r9
    bl reduce
    LDMIB SP, {r1, r2, r3}
    str r0, [sp, #68]
    ldr r0, [SP]
    str r0, [sp, #20]
    add r0, r7, #1
    str r0, [sp, #72]
    ldr r9, =2
    sdiv r7, r5, r9
    add r0, r8, r7
    str r0, [sp, #76]
    str r1, [sp, #24]
    ldr r0, [sp, #72]
    ldr r1, [sp, #76]
    cmp r0, r1
    ldr r9, =0
    ldrge r9, =1
    ldr r0, [sp, #72]
    ldr r1, [sp, #76]
    cmp r0, r1
    ldr r0, [sp, #20]
    ldr r1, [sp, #24]
    bge bb3_12
    b bb3_13
bb3_11:
    b litpool3_1
    .pool
litpool3_1:
    str r0, [sp, #20]
    add r0, r6, #1
    str r0, [sp, #80]
    ldr r9, =2
    sdiv r0, r5, r9
    str r0, [sp, #84]
    str r1, [sp, #24]
    ldr r1, [sp, #84]
    ldr r0, [sp, #104]
    add r0, r0, r1
    str r0, [sp, #88]
    ldr r0, [sp, #80]
    ldr r1, [sp, #88]
    cmp r0, r1
    ldr r9, =0
    ldrge r9, =1
    ldr r0, [sp, #80]
    ldr r1, [sp, #88]
    cmp r0, r1
    ldr r0, [sp, #20]
    ldr r1, [sp, #24]
    bge bb3_14
    b bb3_15
bb3_12:
    ldr r12, [sp, #68]
    str r12, [sp, #120]
    ldr r9, [sp, #72]
    b bb3_11
bb3_13:
    ldr r7, [sp, #72]
    ldr r9, [sp, #68]
    b bb3_9
bb3_14:
    ldr r12, [sp, #80]
    str r12, [sp, #112]
    ldr r12, [sp, #120]
    str r12, [sp, #124]
    b bb3_8
bb3_15:
    ldr r6, [sp, #80]
    ldr r7, [sp, #120]
    b bb3_6
bb3_16:
    str r9, [sp, #108]
    ldr r12, [sp, #124]
    str r12, [sp, #116]
    Mov r7, r9
    ldr r9, [sp, #112]
    b bb3_5
bb3_17:
    b litpool3_2
    .pool
litpool3_2:
    Mov r6, r9
    ldr r7, [sp, #112]
    Mov r8, r9
    ldr r9, [sp, #124]
    b bb3_3
bb3_18:
    b bb3_2
bb3_19:
    ldr r12, [sp, #100]
    str r12, [sp, #104]
    ldr r6, [sp, #116]
    Mov r8, r9
    ldr r9, [sp, #108]
    b bb3_0
bb3_20:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

    .globl memmove
    .p2align 2
    .type memmove, %function
memmove:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #28
    Ldr r3, =0
    b bb4_0
bb4_0:
    cmp r3, r2
    ldr r4, =0
    ldrlt r4, =1
    cmp r3, r2
    blt bb4_1
    b bb4_2
bb4_1:
    add r5, r3, #0
    add r6, r0, #0
    ldr r7, =4
    mul r8, r5, r7
    add r9, r6, r8
    add r4, r3, #0
    add r5, r1, #0
    ldr r7, =4
    mul r6, r4, r7
    add r8, r5, r6
    ldr r4, [r8]
    str r4, [r9]
    add r7, r3, #1
    Mov r3, r7
    b bb4_0
bb4_2:
    b bb4_3
bb4_3:
    add sp, sp, #28
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #56
    STM SP, {r0}
    bl get_int
    STM SP, {r0, r1}
    bl get_int
    LDMIB SP, {r1}
    mov r1, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2}
    bl get_int
    LDMIB SP, {r1, r2}
    mov r2, r0
    ldr r0, [SP]
    ldr r3, Addr5_0
    ldr r4, =0
    ldr r5, =4
    mul r6, r4, r5
    add r7, r3, r6
    STM SP, {r0, r1, r2}
    mov r0, r7
    bl get_int_array
    LDMIB SP, {r1, r2}
    mov r8, r0
    ldr r0, [SP]
    ldr r9, Addr5_2
    ldr r4, =0
    ldr r5, =4
    mul r6, r4, r5
    add r3, r9, r6
    STM SP, {r0, r1, r2, r3}
    ldr r0, [sp, #12]
    bl get_int_array
    LDMIB SP, {r1, r2, r3}
    mov r7, r0
    ldr r0, [SP]
    Ldr r4, =0
    b bb5_0
bb5_0:
    cmp r4, r7
    ldr r5, =0
    ldrlt r5, =1
    cmp r4, r7
    blt bb5_1
    b bb5_2
bb5_1:
    b litpool5_0
    .pool
litpool5_0:
    add r3, r4, #0
    ldr r8, Addr5_2
    ldr r9, =4
    mul r5, r3, r9
    add r6, r8, r5
    ldr r3, [r6]
    ldr r9, Addr5_0
    ldr r8, =0
    ldr r5, =4
    mul r6, r8, r5
    str r0, [sp, #20]
    add r0, r9, r6
    str r0, [sp, #36]
    ldr r8, Addr5_1
    ldr r5, =0
    ldr r9, =4
    mul r6, r5, r9
    add r0, r8, r6
    str r0, [sp, #48]
    ldr r0, [sp, #20]
    STM SP, {r0, r1, r2, r3}
    ldr r12, [sp]
    push {r12}
    ldr r12, [sp, #12]
    push {r12}
    ldr r0, [sp, #20]
    ldr r1, [sp, #44]
    ldr r2, [sp, #56]
    ldr r3, [sp, #12]
    bl convn
    ADD sp, sp, #8
    LDMIB SP, {r1, r2, r3}
    mov r5, r0
    ldr r0, [SP]
    ldr r9, Addr5_0
    ldr r8, =0
    ldr r6, =4
    mul r3, r8, r6
    str r0, [sp, #20]
    add r0, r9, r3
    str r0, [sp, #52]
    ldr r8, Addr5_1
    ldr r6, =0
    ldr r9, =4
    mul r3, r6, r9
    add r0, r8, r3
    str r0, [sp, #44]
    mul r6, r1, r2
    STM SP, {r0, r1, r2}
    ldr r0, [sp, #52]
    ldr r1, [sp, #44]
    mov r2, r6
    bl memmove
    LDM sp, {r0, r1, r2}
    add r9, r4, #1
    ldr r0, [sp, #20]
    Mov r4, r9
    b bb5_0
bb5_2:
    mul r6, r1, r2
    ldr r9, Addr5_0
    ldr r3, =0
    ldr r8, =4
    mul r5, r3, r8
    str r0, [sp, #20]
    add r0, r9, r5
    str r0, [sp, #40]
    mov r0, r6
    ldr r1, [sp, #40]
    bl put_int_array
    ldr r0, [sp, #20]
    b bb5_3
bb5_3:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr5_0:
    .long ..a
Addr5_1:
    .long ..b
Addr5_2:
    .long ..kernelid

    .type ..max, %object
    .section .rodata,"a", %progbits
    .globl ..max
    .p2align 2
..max:
    .long 1073741824
    .size ..max, 4

    .type ..a, %object
    .comm ..a, 40000000, 4

    .type ..b, %object
    .comm ..b, 40000000, 4

    .type ..kernelid, %object
    .comm ..kernelid, 40000, 4

