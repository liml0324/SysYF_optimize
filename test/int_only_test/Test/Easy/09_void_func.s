    .arch armv8 
    .text 
    .globl add
    .p2align 2
    .type add, %function
add:
    push {lr}
    sub sp, sp, #24
    add r2, r0, r1
    push {r0}
    ldr r0, Addr0_0
    str r2, [r0]
    pop {r0}
    b bb0_0
bb0_0:
    add sp, sp, #24
    pop {lr}
    bx lr
    .pool
Addr0_0:
    .long ..c

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, =3
    push {r1}
    ldr r1, Addr1_0
    str r0, [r1]
    pop {r1}
    ldr r1, =2
    push {r0}
    ldr r0, Addr1_1
    str r1, [r0]
    pop {r0}
    ldr r2, Addr1_0
    ldr r2, [r2]
    ldr r3, Addr1_1
    ldr r3, [r3]
    STM SP, {r2, r3}
    ldr r0, [sp]
    ldr r1, [sp, #4]
    bl add
    LDM sp, {r2, r3}
    ldr r4, Addr1_2
    ldr r4, [r4]
    b bb1_0
bb1_0:
    mov r0, r4
    mov sp, r11
    pop {r4, r11, lr}
    bx lr
    .pool
Addr1_0:
    .long ..a
Addr1_1:
    .long ..b
Addr1_2:
    .long ..c

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

    .type ..c, %object
    .bss
    .globl ..c
    .p2align 2
..c:
    .long 0
    .size ..c, 4

