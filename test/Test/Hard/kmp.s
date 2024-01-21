    .arch armv8 
    .text 
    .globl get_next
    .p2align 2
    .type get_next, %function
get_next:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    ldr r0, =0
    add r1, r0, #0
    ldr r2, Addr0_1
    ldr r3, =4
    mul r4, r1, r3
    add r5, r2, r4
    ldr r6, =-1
    str r6, [r5]
    Ldr r7, =-1
    Ldr r8, =0
    b bb0_0
bb0_0:
    add r9, r8, #0
    ldr r0, Addr0_0
    ldr r1, =4
    mul r3, r9, r1
    add r2, r0, r3
    ldr r4, [r2]
    ldr r5, =0
    cmp r4, r5
    ldr r6, =0
    ldrne r6, =1
    ldr r1, =0
    cmp r4, r1
    bne bb0_1
    b bb0_2
bb0_1:
    ldr r9, =-1
    cmp r7, r9
    ldr r3, =0
    ldreq r3, =1
    ldr r0, =-1
    cmp r7, r0
    beq bb0_3
    b bb0_6
bb0_2:
    b bb0_7
bb0_3:
    add r3, r7, #1
    add r0, r8, #1
    add r2, r0, #0
    ldr r1, Addr0_1
    ldr r5, =4
    mul r9, r2, r5
    add r4, r1, r9
    str r3, [r4]
    Mov r4, r3
    Mov r6, r0
    b bb0_5
bb0_4:
    add r3, r7, #0
    ldr r2, Addr0_1
    ldr r0, =4
    mul r1, r3, r0
    add r5, r2, r1
    ldr r9, [r5]
    Mov r4, r9
    Mov r6, r8
    b bb0_5
bb0_5:
    b litpool0_0
    .pool
litpool0_0:
    Mov r7, r4
    Mov r8, r6
    b bb0_0
bb0_6:
    add r2, r8, #0
    ldr r5, Addr0_0
    ldr r1, =4
    mul r4, r2, r1
    add r6, r5, r4
    ldr r9, [r6]
    add r3, r7, #0
    ldr r0, Addr0_0
    ldr r2, =4
    mul r1, r3, r2
    add r5, r0, r1
    ldr r4, [r5]
    cmp r9, r4
    ldr r6, =0
    ldreq r6, =1
    cmp r9, r4
    beq bb0_3
    b bb0_4
bb0_7:
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool
Addr0_0:
    .long ..dst
Addr0_1:
    .long ..next

    .globl KMP
    .p2align 2
    .type KMP, %function
KMP:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    bl get_next
    Ldr r0, =0
    Ldr r1, =0
    b bb1_0
bb1_0:
    add r2, r0, #0
    ldr r3, Addr1_1
    ldr r4, =4
    mul r5, r2, r4
    add r6, r3, r5
    ldr r7, [r6]
    ldr r8, =0
    cmp r7, r8
    ldr r9, =0
    ldrne r9, =1
    ldr r4, =0
    cmp r7, r4
    bne bb1_1
    b bb1_2
bb1_1:
    add r6, r1, #0
    ldr r8, Addr1_0
    ldr r4, =4
    mul r7, r6, r4
    add r9, r8, r7
    ldr r2, [r9]
    add r5, r0, #0
    ldr r3, Addr1_1
    ldr r6, =4
    mul r4, r5, r6
    add r8, r3, r4
    ldr r7, [r8]
    cmp r2, r7
    ldr r9, =0
    ldreq r9, =1
    cmp r2, r7
    beq bb1_3
    b bb1_4
bb1_2:
    Mov r2, r0
    Ldr r3, =-1
    Mov r5, r1
    b bb1_10
bb1_3:
    add r5, r1, #1
    add r3, r0, #1
    add r6, r5, #0
    ldr r4, Addr1_0
    ldr r8, =4
    mul r2, r6, r8
    add r7, r4, r2
    ldr r9, [r7]
    ldr r1, =0
    cmp r9, r1
    ldr r0, =0
    ldreq r0, =1
    ldr r6, =0
    cmp r9, r6
    beq bb1_6
    b bb1_7
bb1_4:
    b litpool1_0
    .pool
litpool1_0:
    add r5, r1, #0
    ldr r6, Addr1_2
    ldr r3, =4
    mul r4, r5, r3
    add r8, r6, r4
    ldr r2, [r8]
    ldr r7, =-1
    cmp r2, r7
    ldr r9, =0
    ldreq r9, =1
    ldr r5, =-1
    cmp r2, r5
    beq bb1_8
    Mov r3, r0
    Mov r6, r2
    b bb1_9
bb1_5:
    Mov r0, r4
    Mov r1, r8
    b bb1_0
bb1_6:
    Mov r2, r3
    b bb1_10
bb1_7:
    Mov r4, r3
    Mov r8, r5
    b bb1_5
bb1_8:
    add r7, r2, #1
    add r9, r0, #1
    Mov r3, r9
    Mov r6, r7
    b bb1_9
bb1_9:
    Mov r4, r3
    Mov r8, r6
    b bb1_5
bb1_10:
    mov r0, r3
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..dst
Addr1_1:
    .long ..src
Addr1_2:
    .long ..next

    .globl read_str
    .p2align 2
    .type read_str, %function
read_str:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldreq r2, =1
    ldr r3, =0
    cmp r0, r3
    beq bb2_0
    b bb2_1
bb2_0:
    b litpool2_0
    .pool
litpool2_0:
    Ldr r9, =0
    b bb2_2
bb2_1:
    Ldr r4, =0
    b bb2_7
bb2_2:
    ldr r8, =1
    ldr r1, =0
    cmp r8, r1
    ldr r0, =0
    ldrne r0, =1
    ldr r3, =1
    ldr r2, =0
    cmp r3, r2
    bne bb2_3
    b bb2_4
bb2_3:
    add r0, r9, #0
    ldr r3, Addr2_0
    ldr r2, =4
    mul r6, r0, r2
    add r7, r3, r6
    bl get_char
    mov r5, r0
    str r5, [r7]
    add r4, r9, #0
    ldr r8, Addr2_0
    ldr r1, =4
    mul r0, r4, r1
    add r2, r8, r0
    ldr r3, [r2]
    ldr r6, =10
    cmp r3, r6
    ldr r5, =0
    ldreq r5, =1
    ldr r7, =10
    cmp r3, r7
    beq bb2_5
    b bb2_6
bb2_4:
    add r6, r9, #0
    ldr r5, Addr2_0
    ldr r7, =4
    mul r4, r6, r7
    add r8, r5, r4
    ldr r1, =0
    str r1, [r8]
    Mov r8, r9
    b bb2_12
bb2_5:
    b bb2_4
bb2_6:
    add r4, r9, #1
    Mov r9, r4
    b bb2_2
bb2_7:
    ldr r5, =1
    ldr r6, =0
    cmp r5, r6
    ldr r7, =0
    ldrne r7, =1
    ldr r8, =1
    ldr r9, =0
    cmp r8, r9
    bne bb2_8
    b bb2_9
bb2_8:
    b litpool2_1
    .pool
litpool2_1:
    add r1, r4, #0
    ldr r2, Addr2_1
    ldr r0, =4
    mul r3, r1, r0
    add r5, r2, r3
    bl get_char
    mov r6, r0
    str r6, [r5]
    add r7, r4, #0
    ldr r8, Addr2_1
    ldr r9, =4
    mul r1, r7, r9
    add r0, r8, r1
    ldr r2, [r0]
    ldr r3, =10
    cmp r2, r3
    ldr r6, =0
    ldreq r6, =1
    ldr r5, =10
    cmp r2, r5
    beq bb2_10
    b bb2_11
bb2_9:
    add r1, r4, #0
    ldr r0, Addr2_1
    ldr r2, =4
    mul r3, r1, r2
    add r5, r0, r3
    ldr r6, =0
    str r6, [r5]
    Mov r7, r4
    Mov r9, r4
    b bb2_12
bb2_10:
    b bb2_9
bb2_11:
    add r7, r4, #1
    Mov r4, r7
    b bb2_7
bb2_12:
    mov r0, r9
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr2_0:
    .long ..dst
Addr2_1:
    .long ..src

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    ldr r0, =0
    bl read_str
    STM SP, {r0, r1}
    ldr r0, =1
    bl read_str
    LDMIB SP, {r1}
    mov r1, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2}
    bl KMP
    LDMIB SP, {r1, r2}
    mov r2, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2}
    ldr r0, [sp, #8]
    bl put_int
    LDM sp, {r0, r1, r2}
    STM SP, {r0, r1}
    ldr r0, =10
    bl put_char
    LDM sp, {r0, r1}
    b bb3_0
bb3_0:
    ldr r0, =0
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

    .type ..dst, %object
    .comm ..dst, 16384, 4

    .type ..src, %object
    .comm ..src, 16384, 4

    .type ..next, %object
    .comm ..next, 16384, 4

