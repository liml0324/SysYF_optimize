    .arch armv8 
    .text 
    .globl defn
    .p2align 2
    .type defn, %function
defn:
    push {lr}
    sub sp, sp, #16
    b bb0_0
bb0_0:
    ldr r0, =4
    add sp, sp, #16
    pop {lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl defn
    b bb1_0
bb1_0:
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

