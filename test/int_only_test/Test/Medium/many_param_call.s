    .arch armv8 
    .text 
    .globl testParam8
    .p2align 2
    .type testParam8, %function
testParam8:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #32
    ldr r4, [sp, #44]
    ldr r5, [sp, #48]
    ldr r6, [sp, #52]
    ldr r7, [sp, #56]
    add r8, r0, r1
    sub r9, r8, r2
    sub r0, r9, r3
    sub r1, r0, r4
    add r2, r1, r5
    add r8, r2, r6
    add r3, r8, r7
    b bb0_0
bb0_0:
    mov r0, r3
    add sp, sp, #32
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl testParam16
    .p2align 2
    .type testParam16, %function
testParam16:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #64
    STMDB SP, {r2, r3}
    Ldr r8, [sp, #-8]
    Ldr r9, [sp, #-4]
    ldr r2, [sp, #100]
    ldr r3, [sp, #104]
    ldr r4, [sp, #108]
    ldr r5, [sp, #112]
    ldr r6, [sp, #116]
    ldr r7, [sp, #120]
    str r2, [sp]
    add r2, r0, r1
    str r2, [sp, #40]
    ldr r2, [sp, #40]
    add r2, r2, r8
    str r2, [sp, #44]
    ldr r2, [sp, #44]
    add r0, r2, r9
    ldr r2, [sp, #76]
    add r1, r0, r2
    ldr r2, [sp, #80]
    add r8, r1, r2
    ldr r2, [sp, #84]
    add r9, r8, r2
    ldr r2, [sp, #88]
    add r0, r9, r2
    ldr r2, [sp, #92]
    sub r1, r0, r2
    ldr r2, [sp, #96]
    add r8, r1, r2
    ldr r2, [sp]
    add r9, r8, r2
    add r0, r9, r3
    add r1, r0, r4
    add r2, r1, r5
    add r8, r2, r6
    add r3, r8, r7
    b bb1_0
bb1_0:
    mov r0, r3
    add sp, sp, #64
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl testParam32
    .p2align 2
    .type testParam32, %function
testParam32:
    push {r4, r5, r6, r7, r8, r9, lr}
    ldr lr, =140
    sub sp, sp, lr
    STMDB SP, {r2, r3}
    str r2, [sp, #132]
    str r3, [sp, #136]
    ldr r2, [sp, #176]
    ldr r3, [sp, #180]
    ldr r4, [sp, #184]
    ldr r5, [sp, #188]
    ldr r6, [sp, #192]
    ldr r7, [sp, #196]
    ldr r8, [sp, #200]
    ldr r9, [sp, #204]
    str r2, [sp]
    add r2, r0, r1
    str r2, [sp, #104]
    str r0, [sp, #4]
    ldr r0, [sp, #132]
    ldr r2, [sp, #104]
    add r2, r2, r0
    str r2, [sp, #108]
    str r1, [sp, #4]
    ldr r1, [sp, #136]
    ldr r2, [sp, #108]
    add r0, r2, r1
    ldr r2, [sp, #152]
    add r1, r0, r2
    ldr r2, [sp, #156]
    add r2, r1, r2
    str r2, [sp, #112]
    str r1, [sp, #4]
    ldr r1, [sp, #160]
    ldr r2, [sp, #112]
    add r0, r2, r1
    ldr r2, [sp, #164]
    add r1, r0, r2
    ldr r2, [sp, #168]
    add r2, r1, r2
    str r2, [sp, #116]
    str r1, [sp, #4]
    ldr r1, [sp, #172]
    ldr r2, [sp, #116]
    add r0, r2, r1
    ldr r2, [sp]
    add r1, r0, r2
    str r0, [sp]
    add r0, r1, r3
    str r0, [sp, #120]
    ldr r0, [sp, #120]
    sub r2, r0, r4
    sub r0, r2, r5
    sub r3, r0, r6
    sub r1, r3, r7
    sub r4, r1, r8
    sub r5, r4, r9
    str r0, [sp]
    ldr r0, [sp, #208]
    sub r2, r5, r0
    ldr r0, [sp, #212]
    sub r6, r2, r0
    str r1, [sp]
    ldr r1, [sp, #216]
    sub r0, r6, r1
    ldr r1, [sp, #220]
    sub r7, r0, r1
    ldr r1, [sp, #224]
    add r3, r7, r1
    ldr r1, [sp, #228]
    add r8, r3, r1
    str r0, [sp]
    ldr r0, [sp, #232]
    add r1, r8, r0
    ldr r0, [sp, #236]
    add r9, r1, r0
    ldr r0, [sp, #240]
    add r4, r9, r0
    ldr r0, [sp, #244]
    add r5, r4, r0
    ldr r0, [sp, #248]
    add r2, r5, r0
    ldr r0, [sp, #252]
    add r6, r2, r0
    str r1, [sp]
    ldr r1, [sp, #256]
    add r0, r6, r1
    ldr r1, [sp, #260]
    add r7, r0, r1
    ldr r1, [sp]
    b bb2_0
bb2_0:
    mov r0, r7
    ldr lr, =140
    add sp, sp, lr
    pop {r4, r5, r6, r7, r8, r9, lr}
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
    ldr r12 ,=7
    push {r12}
    ldr r12 ,=6
    push {r12}
    ldr r12 ,=5
    push {r12}
    ldr r12 ,=4
    push {r12}
    ldr r0, =0
    ldr r1, =1
    ldr r2, =2
    ldr r3, =3
    bl testParam8
    ADD sp, sp, #16
    STM SP, {r0}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r0}
    STM SP, {r0, r1}
    ldr r12 ,=5
    push {r12}
    ldr r12 ,=4
    push {r12}
    ldr r12 ,=3
    push {r12}
    ldr r12 ,=2
    push {r12}
    ldr r12 ,=1
    push {r12}
    ldr r12 ,=0
    push {r12}
    ldr r12 ,=9
    push {r12}
    ldr r12 ,=8
    push {r12}
    ldr r12 ,=7
    push {r12}
    ldr r12 ,=6
    push {r12}
    ldr r12 ,=5
    push {r12}
    ldr r12 ,=4
    push {r12}
    ldr r0, [sp, #48]
    ldr r1, =1
    ldr r2, =2
    ldr r3, =3
    bl testParam16
    ADD sp, sp, #48
    LDMIB SP, {r1}
    mov r1, r0
    ldr r0, [SP]
    STM SP, {r1}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r1}
    STM SP, {r1, r2}
    ldr r12 ,=1
    push {r12}
    ldr r12 ,=0
    push {r12}
    ldr r12 ,=9
    push {r12}
    ldr r12 ,=8
    push {r12}
    ldr r12 ,=7
    push {r12}
    ldr r12 ,=6
    push {r12}
    ldr r12 ,=5
    push {r12}
    ldr r12 ,=4
    push {r12}
    ldr r12 ,=3
    push {r12}
    ldr r12 ,=2
    push {r12}
    ldr r12 ,=1
    push {r12}
    ldr r12 ,=0
    push {r12}
    ldr r12 ,=9
    push {r12}
    ldr r12 ,=8
    push {r12}
    ldr r12 ,=7
    push {r12}
    ldr r12 ,=6
    push {r12}
    ldr r12 ,=5
    push {r12}
    ldr r12 ,=4
    push {r12}
    ldr r12 ,=3
    push {r12}
    ldr r12 ,=2
    push {r12}
    ldr r12 ,=1
    push {r12}
    ldr r12 ,=0
    push {r12}
    ldr r12 ,=9
    push {r12}
    ldr r12 ,=8
    push {r12}
    ldr r12 ,=7
    push {r12}
    ldr r12 ,=6
    push {r12}
    ldr r12 ,=5
    push {r12}
    ldr r12 ,=4
    push {r12}
    ldr r0, [sp, #112]
    ldr r1, =1
    ldr r2, =2
    ldr r3, =3
    bl testParam32
    ADD sp, sp, #112
    LDM SP, {r1, r2}
    mov r2, r0
    STM SP, {r2}
    ldr r0, [sp]
    bl put_int
    LDM sp, {r2}
    b bb3_0
bb3_0:
    ldr r0, =0
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

