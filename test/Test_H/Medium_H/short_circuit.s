    .arch armv8 
    .text 
    .globl func
    .p2align 2
    .type func, %function
func:
    push {r4, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r1, Addr0_0
    ldr r1, [r1]
    add r2, r1, r0
    push {r0}
    ldr r0, Addr0_0
    str r2, [r0]
    pop {r0}
    ldr r3, Addr0_0
    ldr r3, [r3]
    STM SP, {r3}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r3}
    ldr r4, Addr0_0
    ldr r4, [r4]
    b bb0_0
bb0_0:
    mov r0, r4
    mov sp, r11
    pop {r4, r11, lr}
    bx lr
    .pool
Addr0_0:
    .long ..g

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl get_int
    ldr r1, =10
    cmp r0, r1
    ldr r2, =0
    ldrgt r2, =1
    ldr r3, =10
    cmp r0, r3
    bgt bb1_3
    b bb1_1
bb1_0:
    Ldr r4, =1
    b bb1_2
bb1_1:
    Ldr r4, =0
    b bb1_2
bb1_2:
    bl get_int
    mov r5, r0
    ldr r6, =11
    cmp r5, r6
    ldr r7, =0
    ldrgt r7, =1
    ldr r8, =11
    cmp r5, r8
    bgt bb1_7
    b bb1_5
bb1_3:
    STM SP, {r0}
    ldr r0, [sp]
    bl func
    mov r6, r0
    ldr r0, [SP]
    ldr r2, =0
    cmp r6, r2
    ldr r4, =0
    ldrne r4, =1
    ldr r3, =0
    cmp r6, r3
    bne bb1_0
    b bb1_1
bb1_4:
    b litpool1_0
    .pool
litpool1_0:
    Ldr r9, =1
    b bb1_6
bb1_5:
    Ldr r9, =0
    b bb1_6
bb1_6:
    STM SP, {r1}
    bl get_int
    LDM SP, {r1}
    mov r1, r0
    ldr r2, =99
    cmp r1, r2
    ldr r3, =0
    ldrle r3, =1
    ldr r6, =99
    cmp r1, r6
    ble bb1_8
    b bb1_11
bb1_7:
    mov r0, r5
    bl func
    mov r9, r0
    ldr r1, =0
    cmp r9, r1
    ldr r8, =0
    ldrne r8, =1
    ldr r7, =0
    cmp r9, r7
    bne bb1_4
    b bb1_5
bb1_8:
    Ldr r3, =1
    b bb1_10
bb1_9:
    Ldr r3, =0
    b bb1_10
bb1_10:
    STM SP, {r3}
    bl get_int
    LDM SP, {r3}
    mov r9, r0
    ldr r6, =100
    cmp r9, r6
    ldr r1, =0
    ldrle r1, =1
    ldr r4, =100
    cmp r9, r4
    ble bb1_12
    b bb1_15
bb1_11:
    STM SP, {r1}
    ldr r0, [sp]
    bl func
    LDM SP, {r1}
    mov r7, r0
    ldr r4, =0
    cmp r7, r4
    ldr r8, =0
    ldrne r8, =1
    ldr r2, =0
    cmp r7, r2
    bne bb1_8
    b bb1_9
bb1_12:
    b litpool1_1
    .pool
litpool1_1:
    Ldr r1, =1
    b bb1_14
bb1_13:
    Ldr r1, =0
    b bb1_14
bb1_14:
    STM SP, {r1, r3}
    ldr r0, =99
    bl func
    LDM SP, {r1, r3}
    mov r3, r0
    ldr r4, =0
    cmp r3, r4
    ldr r9, =0
    ldreq r9, =1
    ldr r8, =0
    cmp r3, r8
    beq bb1_19
    b bb1_17
bb1_15:
    mov r0, r9
    bl func
    mov r7, r0
    ldr r8, =0
    cmp r7, r8
    ldr r2, =0
    ldrne r2, =1
    ldr r6, =0
    cmp r7, r6
    bne bb1_12
    b bb1_13
bb1_16:
    Ldr r7, =1
    b bb1_18
bb1_17:
    Ldr r7, =0
    b bb1_18
bb1_18:
    b bb1_20
bb1_19:
    STM SP, {r2}
    ldr r0, =100
    bl func
    LDM SP, {r2}
    mov r2, r0
    ldr r6, =0
    cmp r2, r6
    ldr r4, =0
    ldrne r4, =1
    ldr r3, =0
    cmp r2, r3
    bne bb1_16
    b bb1_17
bb1_20:
    b litpool1_2
    .pool
litpool1_2:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

    .type ..g, %object
    .bss
    .globl ..g
    .p2align 2
..g:
    .long 0
    .size ..g, 4

