    .arch armv8 
    .text 
    .globl reverse
    .p2align 2
    .type reverse, %function
reverse:
    push {r4, r5, r6, r11, lr}
    mov r11, sp
    sub sp, sp, #40
    ldr r1, =1
    cmp r0, r1
    ldr r2, =0
    ldrle r2, =1
    ldr r3, =1
    cmp r0, r3
    ble bb0_0
    b bb0_1
bb0_0:
    bl get_int
    mov r6, r0
    mov r0, r6
    bl put_int
    b bb0_2
bb0_1:
    STM SP, {r0}
    bl get_int
    mov r4, r0
    ldr r0, [SP]
    sub r5, r0, #1
    mov r0, r5
    bl reverse
    mov r0, r4
    bl put_int
    b bb0_2
bb0_2:
    b bb0_3
bb0_3:
    mov sp, r11
    pop {r4, r5, r6, r11, lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =200
    bl reverse
    b bb1_0
bb1_0:
    ldr r0, =0
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

