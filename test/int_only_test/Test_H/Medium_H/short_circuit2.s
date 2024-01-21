    .arch armv8 
    .text 
    .globl func
    .p2align 2
    .type func, %function
func:
    push {r4, r11, lr}
    mov r11, sp
    sub sp, sp, #40
    ldr r1, =50
    cmp r0, r1
    ldr r2, =0
    ldrle r2, =1
    ldr r3, =50
    cmp r0, r3
    ble bb0_0
    b bb0_1
bb0_0:
    STM SP, {r0}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r0}
    Ldr r4, =1
    b bb0_2
bb0_1:
    STM SP, {r0}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r0}
    Ldr r4, =0
    b bb0_2
bb0_2:
    mov r0, r4
    mov sp, r11
    pop {r4, r11, lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    ldr r0, =0
    bl func
    ldr r1, =1
    cmp r0, r1
    ldr r2, =0
    ldreq r2, =1
    ldr r3, =1
    cmp r0, r3
    beq bb1_0
    b bb1_3
bb1_0:
    b bb1_2
bb1_1:
    b bb1_2
bb1_2:
    ldr r0, =50
    bl func
    mov r8, r0
    ldr r9, =1
    cmp r8, r9
    ldr r1, =0
    ldreq r1, =1
    ldr r0, =1
    cmp r8, r0
    beq bb1_9
    b bb1_8
bb1_3:
    b litpool1_0
    .pool
litpool1_0:
    ldr r0, =50
    bl func
    mov r4, r0
    ldr r5, =1
    cmp r4, r5
    ldr r6, =0
    ldreq r6, =1
    ldr r7, =1
    cmp r4, r7
    beq bb1_4
    b bb1_1
bb1_4:
    ldr r0, =100
    bl func
    mov r8, r0
    ldr r1, =0
    cmp r8, r1
    ldr r2, =0
    ldreq r2, =1
    ldr r3, =0
    cmp r8, r3
    beq bb1_0
    b bb1_1
bb1_5:
    b bb1_7
bb1_6:
    b bb1_7
bb1_7:
    b bb1_10
bb1_8:
    STM SP, {r3}
    ldr r0, =1
    bl func
    LDM SP, {r3}
    mov r3, r0
    ldr r2, =1
    cmp r3, r2
    ldr r5, =0
    ldreq r5, =1
    ldr r4, =1
    cmp r3, r4
    beq bb1_5
    b bb1_6
bb1_9:
    ldr r0, =40
    bl func
    mov r6, r0
    ldr r7, =1
    cmp r6, r7
    ldr r9, =0
    ldreq r9, =1
    ldr r0, =1
    cmp r6, r0
    beq bb1_5
    b bb1_8
bb1_10:
    b litpool1_1
    .pool
litpool1_1:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

