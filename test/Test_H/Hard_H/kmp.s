    .arch armv8 
    .text 
    .globl get_next
    .p2align 2
    .type get_next, %function
get_next:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #16
    add r2, r1, #0
    ldr r3, =0
    ldr r4, =4
    mul r5, r3, r4
    add r6, r2, r5
    ldr r7, =-1
    str r7, [r6]
    Ldr r8, =-1
    Ldr r9, =0
    b bb0_0
bb0_0:
    add r3, r9, #0
    add r4, r0, #0
    ldr r5, =4
    mul r2, r3, r5
    add r6, r4, r2
    ldr r7, [r6]
    ldr r3, =0
    cmp r7, r3
    ldr r5, =0
    ldrne r5, =1
    ldr r4, =0
    cmp r7, r4
    bne bb0_1
    b bb0_2
bb0_1:
    ldr r2, =-1
    cmp r8, r2
    ldr r6, =0
    ldreq r6, =1
    ldr r3, =-1
    cmp r8, r3
    beq bb0_3
    b bb0_6
bb0_2:
    b bb0_7
bb0_3:
    add r2, r8, #1
    add r3, r9, #1
    add r7, r3, #0
    add r5, r1, #0
    ldr r4, =4
    mul r6, r7, r4
    add r8, r5, r6
    str r2, [r8]
    Mov r4, r2
    Mov r6, r3
    b bb0_5
bb0_4:
    add r4, r8, #0
    add r2, r1, #0
    ldr r6, =4
    mul r3, r4, r6
    add r7, r2, r3
    ldr r5, [r7]
    Mov r4, r5
    Mov r6, r9
    b bb0_5
bb0_5:
    b litpool0_0
    .pool
litpool0_0:
    Mov r8, r4
    Mov r9, r6
    b bb0_0
bb0_6:
    add r7, r9, #0
    add r5, r0, #0
    ldr r4, =4
    mul r2, r7, r4
    add r6, r5, r2
    ldr r3, [r6]
    add r7, r8, #0
    add r4, r0, #0
    ldr r5, =4
    mul r2, r7, r5
    add r6, r4, r2
    ldr r7, [r6]
    cmp r3, r7
    ldr r5, =0
    ldreq r5, =1
    cmp r3, r7
    beq bb0_3
    b bb0_4
bb0_7:
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl KMP
    .p2align 2
    .type KMP, %function
KMP:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    ldr lr, =16420
    sub sp, sp, lr
    add r2, r0, #0
    ldr r3, =0
    ldr r4, =4
    mul r5, r3, r4
    add r6, r2, r5
    add r7, sp, #4
    ldr r8, =0
    ldr r9, =4
    mul r3, r8, r9
    add r4, r7, r3
    STM SP, {r0, r1}
    mov r0, r6
    mov r1, r4
    bl get_next
    LDM sp, {r0, r1}
    Ldr r2, =0
    Ldr r5, =0
    b bb1_0
bb1_0:
    add r8, r2, #0
    add r9, r1, #0
    ldr r3, =4
    mul r7, r8, r3
    add r6, r9, r7
    ldr r4, [r6]
    ldr r8, =0
    cmp r4, r8
    ldr r3, =0
    ldrne r3, =1
    ldr r9, =0
    cmp r4, r9
    bne bb1_1
    b bb1_2
bb1_1:
    add r6, r5, #0
    add r8, r0, #0
    ldr r4, =4
    mul r3, r6, r4
    add r9, r8, r3
    ldr r7, [r9]
    add r6, r2, #0
    add r4, r1, #0
    ldr r8, =4
    mul r3, r6, r8
    add r9, r4, r3
    ldr r6, [r9]
    cmp r7, r6
    ldr r8, =0
    ldreq r8, =1
    cmp r7, r6
    beq bb1_3
    b bb1_4
bb1_2:
    Ldr r7, =-1
    b bb1_10
bb1_3:
    b litpool1_0
    .pool
litpool1_0:
    add r6, r5, #1
    add r4, r2, #1
    add r9, r6, #0
    add r8, r0, #0
    ldr r3, =4
    mul r7, r9, r3
    add r5, r8, r7
    ldr r2, [r5]
    ldr r9, =0
    cmp r2, r9
    ldr r3, =0
    ldreq r3, =1
    ldr r8, =0
    cmp r2, r8
    beq bb1_6
    b bb1_7
bb1_4:
    add r4, r5, #0
    add r3, sp, #4
    ldr r9, =4
    mul r7, r4, r9
    add r6, r3, r7
    ldr r8, [r6]
    ldr r4, =-1
    cmp r8, r4
    ldr r9, =0
    ldreq r9, =1
    ldr r3, =-1
    cmp r8, r3
    beq bb1_8
    Mov r6, r8
    Mov r7, r2
    b bb1_9
bb1_5:
    Mov r2, r4
    Mov r5, r9
    b bb1_0
bb1_6:
    Mov r7, r4
    b bb1_10
bb1_7:
    Mov r9, r6
    b bb1_5
bb1_8:
    add r3, r8, #1
    add r7, r2, #1
    Mov r6, r3
    b bb1_9
bb1_9:
    b litpool1_1
    .pool
litpool1_1:
    Mov r4, r7
    Mov r9, r6
    b bb1_5
bb1_10:
    mov r0, r7
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

    .globl read_str
    .p2align 2
    .type read_str, %function
read_str:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    Ldr r1, =0
    b bb2_0
bb2_0:
    ldr r2, =1
    ldr r3, =0
    cmp r2, r3
    ldr r4, =0
    ldrne r4, =1
    ldr r5, =1
    ldr r6, =0
    cmp r5, r6
    bne bb2_1
    b bb2_2
bb2_1:
    add r6, r1, #0
    add r4, r0, #0
    ldr r7, =4
    mul r9, r6, r7
    add r8, r4, r9
    STM SP, {r0, r1, r2}
    bl get_char
    LDMIB SP, {r1, r2}
    mov r2, r0
    ldr r0, [SP]
    str r2, [r8]
    add r3, r1, #0
    add r5, r0, #0
    ldr r6, =4
    mul r7, r3, r6
    add r4, r5, r7
    ldr r9, [r4]
    ldr r2, =10
    cmp r9, r2
    ldr r8, =0
    ldreq r8, =1
    ldr r3, =10
    cmp r9, r3
    beq bb2_3
    b bb2_4
bb2_2:
    add r7, r1, #0
    add r8, r0, #0
    ldr r9, =4
    mul r2, r7, r9
    add r3, r8, r2
    ldr r5, =0
    str r5, [r3]
    b bb2_5
bb2_3:
    b bb2_2
bb2_4:
    add r6, r1, #1
    Mov r1, r6
    b bb2_0
bb2_5:
    b litpool2_0
    .pool
litpool2_0:
    mov r0, r1
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    ldr lr, =32804
    sub sp, sp, lr
    add r0, sp, #4
    ldr r1, =0
    ldr r2, =4
    mul r3, r1, r2
    add r4, r0, r3
    mov r0, r4
    bl read_str
    mov r5, r0
    ldr r6, =16388
    add r6, sp, r6
    ldr r7, =0
    ldr r8, =4
    mul r9, r7, r8
    add r1, r6, r9
    STM SP, {r1, r2}
    ldr r0, [sp]
    bl read_str
    LDM SP, {r1, r2}
    mov r2, r0
    add r3, sp, #4
    ldr r0, =0
    ldr r4, =4
    mul r7, r0, r4
    add r8, r3, r7
    ldr r9, =16388
    add r9, sp, r9
    ldr r6, =0
    ldr r1, =4
    mul r0, r6, r1
    add r4, r9, r0
    STM SP, {r2}
    mov r0, r8
    mov r1, r4
    bl KMP
    LDM SP, {r2}
    mov r7, r0
    STM SP, {r2}
    mov r0, r7
    bl put_int
    LDM sp, {r2}
    STM SP, {r2}
    ldr r0, =10
    bl put_char
    LDM sp, {r2}
    b bb3_0
bb3_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

