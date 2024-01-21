    .arch armv8 
    .text 
    .globl multiply
    .p2align 2
    .type multiply, %function
multiply:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #44
    ldr r2, =0
    cmp r1, r2
    ldr r3, =0
    ldreq r3, =1
    ldr r4, =0
    cmp r1, r4
    beq bb0_0
    b bb0_1
bb0_0:
    Ldr r6, =0
    b bb0_6
bb0_1:
    ldr r5, =1
    cmp r1, r5
    ldr r6, =0
    ldreq r6, =1
    ldr r7, =1
    cmp r1, r7
    beq bb0_2
    b bb0_3
bb0_2:
    ldr r9, =998244353
    sdiv r4, r0, r9
    ldr r3, =998244353
    mul r1, r4, r3
    sub r5, r0, r1
    Mov r6, r5
    b bb0_6
bb0_3:
    ldr r9, =2
    sdiv r2, r1, r9
    STM SP, {r0, r1, r2}
    ldr r0, [sp]
    ldr r1, [sp, #8]
    bl multiply
    LDMIB SP, {r1, r2}
    mov r4, r0
    ldr r0, [SP]
    add r3, r4, r4
    ldr r5, =998244353
    sdiv r6, r3, r5
    ldr r7, =998244353
    mul r9, r6, r7
    sub r2, r3, r9
    ldr r4, =2
    sdiv r5, r1, r4
    ldr r6, =2
    mul r7, r5, r6
    sub r3, r1, r7
    ldr r9, =1
    cmp r3, r9
    ldr r4, =0
    ldreq r4, =1
    ldr r5, =1
    cmp r3, r5
    beq bb0_4
    b bb0_5
bb0_4:
    add r1, r2, r0
    ldr r9, =998244353
    sdiv r4, r1, r9
    ldr r3, =998244353
    mul r5, r4, r3
    sub r6, r1, r5
    b bb0_6
bb0_5:
    Mov r6, r2
    b bb0_6
bb0_6:
    b litpool0_0
    .pool
litpool0_0:
    mov r0, r6
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

    .globl power
    .p2align 2
    .type power, %function
power:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #44
    ldr r2, =0
    cmp r1, r2
    ldr r3, =0
    ldreq r3, =1
    ldr r4, =0
    cmp r1, r4
    beq bb1_0
    b bb1_1
bb1_0:
    Ldr r2, =1
    b bb1_4
bb1_1:
    ldr r5, =2
    sdiv r6, r1, r5
    STM SP, {r0, r1}
    ldr r0, [sp]
    mov r1, r6
    bl power
    LDMIB SP, {r1}
    mov r7, r0
    ldr r0, [SP]
    STM SP, {r0, r1}
    mov r0, r7
    mov r1, r7
    bl multiply
    LDMIB SP, {r1}
    mov r8, r0
    ldr r0, [SP]
    ldr r9, =2
    sdiv r2, r1, r9
    ldr r4, =2
    mul r3, r2, r4
    sub r5, r1, r3
    ldr r6, =1
    cmp r5, r6
    ldr r7, =0
    ldreq r7, =1
    ldr r9, =1
    cmp r5, r9
    beq bb1_2
    b bb1_3
bb1_2:
    STM SP, {r0}
    mov r0, r8
    ldr r1, [sp]
    bl multiply
    mov r4, r0
    ldr r0, [SP]
    Mov r2, r4
    b bb1_4
bb1_3:
    Mov r2, r8
    b bb1_4
bb1_4:
    mov r0, r2
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

    .globl memmove
    .p2align 2
    .type memmove, %function
memmove:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #36
    Ldr r4, =0
    b bb2_0
bb2_0:
    b litpool2_0
    .pool
litpool2_0:
    cmp r4, r3
    ldr r5, =0
    ldrlt r5, =1
    cmp r4, r3
    blt bb2_1
    b bb2_2
bb2_1:
    add r6, r1, r4
    add r7, r6, #0
    add r8, r0, #0
    ldr r9, =4
    mul r5, r7, r9
    add r6, r8, r5
    add r7, r4, #0
    add r9, r2, #0
    ldr r8, =4
    mul r5, r7, r8
    str r0, [sp]
    add r0, r9, r5
    str r0, [sp, #16]
    ldr r0, [sp, #16]
    ldr r7, [r0]
    str r7, [r6]
    add r8, r4, #1
    ldr r0, [sp]
    Mov r4, r8
    b bb2_0
bb2_2:
    b bb2_3
bb2_3:
    mov r0, r4
    add sp, sp, #36
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl fft
    .p2align 2
    .type fft, %function
fft:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    ldr lr, =160
    sub sp, sp, lr
    ldr r4, =1
    cmp r2, r4
    ldr r5, =0
    ldreq r5, =1
    ldr r6, =1
    cmp r2, r6
    beq bb3_0
    b bb3_1
bb3_0:
    Ldr r5, =1
    b bb3_11
bb3_1:
    Ldr r7, =0
    b bb3_2
bb3_2:
    cmp r7, r2
    ldr r8, =0
    ldrlt r8, =1
    cmp r7, r2
    blt bb3_3
    b bb3_4
bb3_3:
    b litpool3_0
    .pool
litpool3_0:
    ldr r6, =2
    sdiv r9, r7, r6
    ldr r8, =2
    mul r5, r9, r8
    sub r4, r7, r5
    ldr r6, =0
    cmp r4, r6
    ldr r9, =0
    ldreq r9, =1
    ldr r8, =0
    cmp r4, r8
    beq bb3_5
    b bb3_6
bb3_4:
    add r9, r0, #0
    ldr r4, =0
    ldr r5, =4
    mul r6, r4, r5
    add r8, r9, r6
    ldr r4, Addr3_0
    ldr r5, =0
    ldr r6, =4
    mul r9, r5, r6
    str r0, [sp, #20]
    add r0, r4, r9
    str r0, [sp, #128]
    STM SP, {r0, r1, r2, r3}
    mov r0, r8
    ldr r1, [sp, #4]
    ldr r2, [sp, #128]
    ldr r3, [sp, #8]
    bl memmove
    LDMIB SP, {r1, r2, r3}
    mov r5, r0
    ldr r0, [SP]
    ldr r0, [sp, #20]
    add r6, r0, #0
    ldr r9, =0
    ldr r4, =4
    mul r8, r9, r4
    str r0, [sp, #20]
    add r0, r6, r8
    str r0, [sp, #48]
    ldr r9, =2
    sdiv r4, r2, r9
    STM SP, {r0, r1, r2, r3}
    ldr r0, [sp, #12]
    ldr r1, [sp, #12]
    bl multiply
    LDMIB SP, {r1, r2, r3}
    mov r8, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2, r3}
    ldr r0, [sp, #48]
    ldr r1, [sp, #4]
    mov r2, r4
    mov r3, r8
    bl fft
    LDMIB SP, {r1, r2, r3}
    mov r6, r0
    ldr r0, [SP]
    ldr r0, [sp, #20]
    add r9, r0, #0
    ldr r4, =0
    ldr r8, =4
    str r0, [sp, #20]
    mul r0, r4, r8
    str r0, [sp, #76]
    ldr r0, [sp, #76]
    add r0, r9, r0
    str r0, [sp, #72]
    ldr r4, =2
    sdiv r8, r2, r4
    add r9, r1, r8
    ldr r4, =2
    sdiv r8, r2, r4
    STM SP, {r0, r1, r2, r3}
    ldr r0, [sp, #12]
    ldr r1, [sp, #12]
    bl multiply
    LDMIB SP, {r1, r2, r3}
    str r0, [sp, #84]
    ldr r0, [SP]
    STM SP, {r0, r1, r2, r3}
    ldr r0, [sp, #72]
    mov r1, r9
    mov r2, r8
    ldr r3, [sp, #84]
    bl fft
    LDMIB SP, {r1, r2, r3}
    mov r4, r0
    ldr r0, [SP]
    ldr r0, [sp, #20]
    Ldr r8, =0
    Ldr r9, =1
    b bb3_8
bb3_5:
    ldr r6, =2
    sdiv r8, r7, r6
    add r9, r8, #0
    ldr r4, Addr3_0
    ldr r5, =4
    mul r6, r9, r5
    add r8, r4, r6
    add r5, r7, r1
    add r9, r5, #0
    add r6, r0, #0
    ldr r4, =4
    mul r5, r9, r4
    str r0, [sp, #20]
    add r0, r6, r5
    str r0, [sp, #88]
    ldr r0, [sp, #88]
    ldr r4, [r0]
    str r4, [r8]
    ldr r0, [sp, #20]
    b bb3_7
bb3_6:
    ldr r5, =2
    sdiv r6, r2, r5
    ldr r4, =2
    sdiv r8, r7, r4
    add r9, r6, r8
    add r5, r9, #0
    ldr r4, Addr3_0
    ldr r6, =4
    mul r8, r5, r6
    add r9, r4, r8
    add r6, r7, r1
    add r5, r6, #0
    add r8, r0, #0
    ldr r4, =4
    mul r6, r5, r4
    str r0, [sp, #20]
    add r0, r8, r6
    str r0, [sp, #136]
    ldr r0, [sp, #136]
    ldr r4, [r0]
    str r4, [r9]
    ldr r0, [sp, #20]
    b bb3_7
bb3_7:
    add r5, r7, #1
    Mov r7, r5
    b bb3_2
bb3_8:
    b litpool3_1
    .pool
litpool3_1:
    ldr r5, =2
    sdiv r6, r2, r5
    cmp r8, r6
    ldr r4, =0
    ldrlt r4, =1
    cmp r8, r6
    blt bb3_9
    b bb3_10
bb3_9:
    add r6, r1, r8
    add r4, r6, #0
    add r5, r0, #0
    ldr r6, =4
    str r0, [sp, #20]
    mul r0, r4, r6
    str r0, [sp, #52]
    ldr r0, [sp, #52]
    add r0, r5, r0
    str r0, [sp, #40]
    ldr r0, [sp, #40]
    ldr r6, [r0]
    add r4, r1, r8
    ldr r5, =2
    sdiv r0, r2, r5
    str r0, [sp, #92]
    ldr r0, [sp, #92]
    add r0, r4, r0
    str r0, [sp, #96]
    ldr r0, [sp, #96]
    add r5, r0, #0
    ldr r0, [sp, #20]
    add r4, r0, #0
    str r0, [sp, #20]
    ldr r0, =4
    str r0, [sp, #144]
    ldr r0, [sp, #144]
    mul r0, r5, r0
    str r0, [sp, #36]
    ldr r0, [sp, #36]
    add r0, r4, r0
    str r0, [sp, #140]
    ldr r0, [sp, #140]
    ldr r5, [r0]
    add r4, r1, r8
    add r0, r4, #0
    str r0, [sp, #100]
    ldr r0, [sp, #20]
    str r1, [sp, #20]
    add r1, r0, #0
    str r1, [sp, #104]
    ldr r4, =4
    ldr r1, [sp, #100]
    mul r1, r1, r4
    str r1, [sp, #132]
    str r0, [sp, #24]
    ldr r1, [sp, #104]
    ldr r0, [sp, #132]
    add r1, r1, r0
    str r1, [sp, #60]
    STM SP, {r0, r1, r2, r3}
    mov r0, r9
    mov r1, r5
    bl multiply
    LDMIB SP, {r1, r2, r3}
    mov r4, r0
    ldr r0, [SP]
    add r0, r6, r4
    str r0, [sp, #108]
    ldr r0, =998244353
    str r0, [sp, #144]
    ldr r0, [sp, #108]
    ldr r1, [sp, #144]
    sdiv r4, r0, r1
    ldr r0, =998244353
    str r0, [sp, #144]
    ldr r0, [sp, #144]
    mul r0, r4, r0
    str r0, [sp, #56]
    ldr r1, [sp, #56]
    ldr r0, [sp, #108]
    sub r0, r0, r1
    str r0, [sp, #80]
    ldr r1, [sp, #60]
    ldr r0, [sp, #80]
    str r0, [r1]
    ldr r1, [sp, #20]
    add r4, r1, r8
    ldr r4, =2
    sdiv r0, r2, r4
    str r0, [sp, #112]
    ldr r0, [sp, #112]
    add r0, r4, r0
    str r0, [sp, #116]
    ldr r0, [sp, #116]
    add r4, r0, #0
    ldr r0, [sp, #24]
    str r1, [sp, #20]
    add r1, r0, #0
    str r1, [sp, #120]
    ldr r1, =4
    str r1, [sp, #144]
    ldr r1, [sp, #144]
    mul r1, r4, r1
    str r1, [sp, #64]
    str r0, [sp, #24]
    ldr r0, [sp, #64]
    ldr r1, [sp, #120]
    add r1, r1, r0
    str r1, [sp, #68]
    STM SP, {r0, r1, r2, r3}
    mov r0, r9
    mov r1, r5
    bl multiply
    LDMIB SP, {r1, r2, r3}
    mov r4, r0
    ldr r0, [SP]
    sub r0, r6, r4
    str r0, [sp, #124]
    ldr r5, =998244353
    ldr r0, [sp, #124]
    add r4, r0, r5
    ldr r6, =998244353
    sdiv r5, r4, r6
    ldr r0, =998244353
    str r0, [sp, #144]
    ldr r0, [sp, #144]
    mul r6, r5, r0
    sub r0, r4, r6
    str r0, [sp, #44]
    ldr r0, [sp, #44]
    ldr r1, [sp, #68]
    str r0, [r1]
    STM SP, {r0, r1, r2, r3}
    mov r0, r9
    ldr r1, [sp, #12]
    bl multiply
    LDMIB SP, {r1, r2, r3}
    mov r5, r0
    ldr r0, [SP]
    add r4, r8, #1
    ldr r0, [sp, #24]
    ldr r1, [sp, #20]
    Mov r8, r4
    Mov r9, r5
    b bb3_8
bb3_10:
    Ldr r5, =0
    b bb3_11
bb3_11:
    mov r0, r5
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr3_0:
    .long ..temp

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r0, Addr4_1
    ldr r1, =0
    ldr r2, =4
    mul r3, r1, r2
    add r4, r0, r3
    mov r0, r4
    bl get_int_array
    mov r5, r0
    ldr r6, Addr4_2
    ldr r7, =0
    ldr r8, =4
    mul r9, r7, r8
    add r1, r6, r9
    STM SP, {r1, r2}
    ldr r0, [sp]
    bl get_int_array
    LDM SP, {r1, r2}
    mov r2, r0
    ldr r0, =1
    push {r1}
    ldr r1, Addr4_0
    str r0, [r1]
    pop {r1}
    b bb4_0
bb4_0:
    b litpool4_0
    .pool
litpool4_0:
    ldr r3, Addr4_0
    ldr r3, [r3]
    add r4, r5, r2
    sub r7, r4, #1
    cmp r3, r7
    ldr r8, =0
    ldrlt r8, =1
    cmp r3, r7
    blt bb4_1
    b bb4_2
bb4_1:
    ldr r6, Addr4_0
    ldr r6, [r6]
    ldr r0, =2
    mul r8, r6, r0
    push {r0}
    ldr r0, Addr4_0
    str r8, [r0]
    pop {r0}
    b bb4_0
bb4_2:
    ldr r6, Addr4_1
    ldr r9, =0
    ldr r1, =4
    mul r0, r9, r1
    add r4, r6, r0
    ldr r7, Addr4_0
    ldr r7, [r7]
    ldr r8, Addr4_0
    ldr r8, [r8]
    ldr r3, =998244352
    sdiv r9, r3, r8
    STM SP, {r1, r2}
    ldr r0, =3
    mov r1, r9
    bl power
    LDM SP, {r1, r2}
    mov r1, r0
    STM SP, {r1, r2}
    mov r0, r4
    ldr r1, =0
    mov r2, r7
    ldr r3, [sp]
    bl fft
    LDM SP, {r1, r2}
    mov r6, r0
    ldr r0, Addr4_2
    ldr r8, =0
    ldr r3, =4
    mul r9, r8, r3
    add r7, r0, r9
    ldr r1, Addr4_0
    ldr r1, [r1]
    ldr r4, Addr4_0
    ldr r4, [r4]
    ldr r3, =998244352
    sdiv r8, r3, r4
    STM SP, {r1, r2}
    ldr r0, =3
    mov r1, r8
    bl power
    LDM SP, {r1, r2}
    mov r9, r0
    STM SP, {r0, r1, r2}
    mov r0, r7
    ldr r1, =0
    ldr r2, [sp, #4]
    mov r3, r9
    bl fft
    LDMIB SP, {r1, r2}
    Ldr r3, =0
    b bb4_3
bb4_3:
    ldr r4, Addr4_0
    ldr r4, [r4]
    cmp r3, r4
    ldr r8, =0
    ldrlt r8, =1
    cmp r3, r4
    blt bb4_4
    b bb4_5
bb4_4:
    add r4, r3, #0
    ldr r8, Addr4_1
    ldr r1, =4
    mul r0, r4, r1
    add r7, r8, r0
    add r6, r3, #0
    ldr r9, Addr4_1
    ldr r1, =4
    mul r4, r6, r1
    add r0, r9, r4
    ldr r8, [r0]
    add r1, r3, #0
    ldr r6, Addr4_2
    ldr r4, =4
    mul r9, r1, r4
    add r0, r6, r9
    ldr r4, [r0]
    STM SP, {r1, r2, r3}
    mov r0, r8
    mov r1, r4
    bl multiply
    LDM SP, {r1, r2, r3}
    mov r1, r0
    str r1, [r7]
    add r9, r3, #1
    Mov r3, r9
    b bb4_3
bb4_5:
    ldr r7, Addr4_1
    ldr r1, =0
    ldr r9, =4
    mul r6, r1, r9
    add r0, r7, r6
    ldr r4, Addr4_0
    ldr r4, [r4]
    ldr r8, Addr4_0
    ldr r8, [r8]
    ldr r1, =998244352
    sdiv r9, r1, r8
    ldr r6, =998244352
    sub r7, r6, r9
    STM SP, {r0, r1, r2}
    ldr r0, =3
    mov r1, r7
    bl power
    LDMIB SP, {r1, r2}
    mov r1, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2}
    ldr r0, [sp]
    ldr r1, =0
    mov r2, r4
    ldr r3, [sp, #4]
    bl fft
    LDMIB SP, {r1, r2}
    mov r8, r0
    ldr r0, [SP]
    Ldr r6, =0
    b bb4_6
bb4_6:
    b litpool4_1
    .pool
litpool4_1:
    ldr r9, Addr4_0
    ldr r9, [r9]
    cmp r6, r9
    ldr r7, =0
    ldrlt r7, =1
    cmp r6, r9
    blt bb4_7
    b bb4_8
bb4_7:
    add r8, r6, #0
    ldr r9, Addr4_1
    ldr r7, =4
    mul r1, r8, r7
    add r0, r9, r1
    add r4, r6, #0
    ldr r7, Addr4_1
    ldr r8, =4
    mul r1, r4, r8
    add r9, r7, r1
    ldr r8, [r9]
    ldr r4, Addr4_0
    ldr r4, [r4]
    STM SP, {r0, r1, r2}
    mov r0, r4
    ldr r1, =998244351
    bl power
    LDMIB SP, {r1, r2}
    mov r1, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2}
    mov r0, r8
    ldr r1, [sp, #4]
    bl multiply
    LDMIB SP, {r1, r2}
    mov r7, r0
    ldr r0, [SP]
    str r7, [r0]
    add r9, r6, #1
    Mov r6, r9
    b bb4_6
bb4_8:
    add r0, r5, r2
    sub r4, r0, #1
    ldr r1, Addr4_1
    ldr r8, =0
    ldr r9, =4
    mul r7, r8, r9
    add r0, r1, r7
    STM SP, {r0}
    mov r0, r4
    ldr r1, [sp]
    bl put_int_array
    LDM sp, {r0}
    b bb4_9
bb4_9:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool
Addr4_0:
    .long ..d
Addr4_1:
    .long ..a
Addr4_2:
    .long ..b

    .type ..mod, %object
    .section .rodata,"a", %progbits
    .globl ..mod
    .p2align 2
..mod:
    .long 998244353
    .size ..mod, 4

    .type ..d, %object
    .bss
    .globl ..d
    .p2align 2
..d:
    .long 0
    .size ..d, 4

    .type ..maxlen, %object
    .section .rodata,"a", %progbits
    .globl ..maxlen
    .p2align 2
..maxlen:
    .long 2097152
    .size ..maxlen, 4

    .type ..temp, %object
    .comm ..temp, 8388608, 4

    .type ..a, %object
    .comm ..a, 8388608, 4

    .type ..b, %object
    .comm ..b, 8388608, 4

    .type ..c, %object
    .comm ..c, 8388608, 4

