    .arch armv8 
    .text 
    .globl func1
    .p2align 2
    .type func1, %function
func1:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r3, =0
    cmp r2, r3
    ldr r4, =0
    ldreq r4, =1
    ldr r5, =0
    cmp r2, r5
    beq bb0_0
    b bb0_1
bb0_0:
    mul r9, r0, r1
    Mov r8, r9
    b bb0_2
bb0_1:
    sub r6, r1, r2
    STM SP, {r0}
    ldr r0, [sp]
    mov r1, r6
    ldr r2, =0
    bl func1
    mov r7, r0
    ldr r0, [SP]
    Mov r8, r7
    b bb0_2
bb0_2:
    mov r0, r8
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

    .globl func2
    .p2align 2
    .type func2, %function
func2:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r2, =0
    cmp r1, r2
    ldr r3, =0
    ldrne r3, =1
    ldr r4, =0
    cmp r1, r4
    bne bb1_0
    b bb1_1
bb1_0:
    sdiv r6, r0, r1
    mul r7, r6, r1
    sub r8, r0, r7
    mov r0, r8
    ldr r1, =0
    bl func2
    mov r9, r0
    Mov r5, r9
    b bb1_2
bb1_1:
    Mov r5, r0
    b bb1_2
bb1_2:
    mov r0, r5
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

    .globl func3
    .p2align 2
    .type func3, %function
func3:
    push {r4, r5, r6, r7, r8, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    ldr r2, =0
    cmp r1, r2
    ldr r3, =0
    ldreq r3, =1
    ldr r4, =0
    cmp r1, r4
    beq bb2_0
    b bb2_1
bb2_0:
    b litpool2_0
    .pool
litpool2_0:
    add r8, r0, #1
    Mov r7, r8
    b bb2_2
bb2_1:
    add r5, r0, r1
    mov r0, r5
    ldr r1, =0
    bl func3
    mov r6, r0
    Mov r7, r6
    b bb2_2
bb2_2:
    mov r0, r7
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r11, lr}
    bx lr
    .pool

    .globl func4
    .p2align 2
    .type func4, %function
func4:
    push {r4, r5, r6, lr}
    sub sp, sp, #16
    ldr r3, =0
    cmp r0, r3
    ldr r4, =0
    ldrne r4, =1
    ldr r5, =0
    cmp r0, r5
    bne bb3_0
    b bb3_1
bb3_0:
    Mov r6, r1
    b bb3_2
bb3_1:
    Mov r6, r2
    b bb3_2
bb3_2:
    mov r0, r6
    add sp, sp, #16
    pop {r4, r5, r6, lr}
    bx lr
    .pool

    .globl func5
    .p2align 2
    .type func5, %function
func5:
    push {lr}
    sub sp, sp, #16
    rsb r1, r0, #0
    b bb4_0
bb4_0:
    mov r0, r1
    add sp, sp, #16
    pop {lr}
    bx lr
    .pool

    .globl func6
    .p2align 2
    .type func6, %function
func6:
    push {r4, r5, r6, r7, r8, lr}
    sub sp, sp, #16
    ldr r2, =0
    cmp r0, r2
    ldr r3, =0
    ldrne r3, =1
    ldr r4, =0
    cmp r0, r4
    bne bb5_0
    b bb5_1
bb5_0:
    ldr r6, =0
    cmp r1, r6
    ldr r7, =0
    ldrne r7, =1
    ldr r8, =0
    cmp r1, r8
    bne bb5_2
    b bb5_3
bb5_1:
    b litpool5_0
    .pool
litpool5_0:
    Ldr r5, =0
    b bb5_4
bb5_2:
    Ldr r5, =1
    b bb5_4
bb5_3:
    Ldr r5, =0
    b bb5_4
bb5_4:
    mov r0, r5
    add sp, sp, #16
    pop {r4, r5, r6, r7, r8, lr}
    bx lr
    .pool

    .globl func7
    .p2align 2
    .type func7, %function
func7:
    push {r4, lr}
    sub sp, sp, #16
    ldr r1, =0
    cmp r0, r1
    ldr r2, =0
    ldreq r2, =1
    ldr r3, =0
    cmp r0, r3
    beq bb6_0
    b bb6_1
bb6_0:
    Ldr r4, =1
    b bb6_2
bb6_1:
    Ldr r4, =0
    b bb6_2
bb6_2:
    mov r0, r4
    add sp, sp, #16
    pop {r4, lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    ldr lr, =304
    sub sp, sp, lr
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
    STM SP, {r0, r1, r2, r3}
    bl get_int
    LDMIB SP, {r1, r2, r3}
    mov r3, r0
    ldr r0, [SP]
    Ldr r4, =0
    b bb7_0
bb7_0:
    ldr r5, =10
    cmp r4, r5
    ldr r6, =0
    ldrlt r6, =1
    ldr r7, =10
    cmp r4, r7
    blt bb7_1
    b bb7_2
bb7_1:
    add r5, r4, #0
    add r9, sp, #44
    ldr r8, =4
    mul r6, r5, r8
    add r7, r9, r6
    STM SP, {r0, r1, r2, r3}
    bl get_int
    LDMIB SP, {r1, r2, r3}
    mov r8, r0
    ldr r0, [SP]
    str r8, [r7]
    add r5, r4, #1
    Mov r4, r5
    b bb7_0
bb7_2:
    b litpool7_0
    .pool
litpool7_0:
    STM SP, {r0, r1, r2, r3}
    ldr r0, [sp]
    bl func7
    LDMIB SP, {r1, r2, r3}
    mov r8, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2, r3}
    ldr r0, [sp, #4]
    bl func5
    LDMIB SP, {r1, r2, r3}
    mov r9, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2, r3}
    mov r0, r8
    mov r1, r9
    bl func6
    LDMIB SP, {r1, r2, r3}
    mov r5, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2, r3}
    mov r0, r5
    ldr r1, [sp, #8]
    bl func2
    LDMIB SP, {r1, r2, r3}
    mov r7, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2, r3}
    mov r0, r7
    ldr r1, [sp, #12]
    bl func3
    LDMIB SP, {r1, r2, r3}
    mov r6, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2, r3}
    mov r0, r6
    bl func5
    LDMIB SP, {r1, r2, r3}
    mov r8, r0
    ldr r0, [SP]
    add r9, sp, #44
    ldr r5, =0
    ldr r7, =4
    mul r6, r5, r7
    str r0, [sp, #20]
    add r0, r9, r6
    str r0, [sp, #92]
    ldr r0, [sp, #92]
    ldr r5, [r0]
    add r7, sp, #44
    ldr r6, =1
    ldr r9, =4
    mul r0, r6, r9
    str r0, [sp, #96]
    ldr r0, [sp, #96]
    add r0, r7, r0
    str r0, [sp, #100]
    ldr r0, [sp, #100]
    ldr r6, [r0]
    STM SP, {r0, r1, r2, r3}
    mov r0, r6
    bl func5
    LDMIB SP, {r1, r2, r3}
    mov r9, r0
    ldr r0, [SP]
    add r7, sp, #44
    ldr r6, =2
    ldr r0, =4
    str r0, [sp, #272]
    ldr r0, [sp, #272]
    mul r0, r6, r0
    str r0, [sp, #84]
    ldr r0, [sp, #84]
    add r0, r7, r0
    str r0, [sp, #224]
    ldr r0, [sp, #224]
    ldr r6, [r0]
    add r7, sp, #44
    ldr r7, =3
    ldr r0, =4
    str r0, [sp, #272]
    ldr r0, [sp, #272]
    mul r0, r7, r0
    str r0, [sp, #144]
    ldr r0, [sp, #144]
    add r0, r7, r0
    str r0, [sp, #148]
    ldr r0, [sp, #148]
    ldr r7, [r0]
    STM SP, {r0, r1, r2, r3}
    mov r0, r7
    bl func7
    LDMIB SP, {r1, r2, r3}
    str r0, [sp, #172]
    ldr r0, [SP]
    STM SP, {r0, r1, r2, r3}
    mov r0, r6
    ldr r1, [sp, #172]
    bl func6
    LDMIB SP, {r1, r2, r3}
    str r0, [sp, #176]
    ldr r0, [SP]
    add r7, sp, #44
    ldr r6, =4
    ldr r0, =4
    str r0, [sp, #272]
    ldr r0, [sp, #272]
    mul r0, r6, r0
    str r0, [sp, #140]
    ldr r0, [sp, #140]
    add r0, r7, r0
    str r0, [sp, #156]
    ldr r0, [sp, #156]
    ldr r6, [r0]
    add r7, sp, #44
    ldr r7, =5
    ldr r0, =4
    str r0, [sp, #272]
    ldr r0, [sp, #272]
    mul r0, r7, r0
    str r0, [sp, #132]
    ldr r0, [sp, #132]
    add r0, r7, r0
    str r0, [sp, #268]
    ldr r0, [sp, #268]
    ldr r7, [r0]
    STM SP, {r0, r1, r2, r3}
    mov r0, r7
    bl func7
    LDMIB SP, {r1, r2, r3}
    str r0, [sp, #184]
    ldr r0, [SP]
    STM SP, {r0, r1, r2, r3}
    mov r0, r6
    ldr r1, [sp, #184]
    bl func2
    LDMIB SP, {r1, r2, r3}
    str r0, [sp, #188]
    ldr r0, [SP]
    STM SP, {r0, r1, r2, r3}
    mov r0, r9
    ldr r1, [sp, #176]
    ldr r2, [sp, #188]
    bl func4
    LDMIB SP, {r1, r2, r3}
    mov r7, r0
    ldr r0, [SP]
    add r6, sp, #44
    ldr r9, =6
    ldr r0, =4
    str r0, [sp, #272]
    ldr r0, [sp, #272]
    mul r0, r9, r0
    str r0, [sp, #152]
    ldr r0, [sp, #152]
    add r0, r6, r0
    str r0, [sp, #160]
    ldr r0, [sp, #160]
    ldr r9, [r0]
    STM SP, {r0, r1, r2, r3}
    mov r0, r7
    mov r1, r9
    bl func3
    LDMIB SP, {r1, r2, r3}
    mov r6, r0
    ldr r0, [SP]
    add r0, sp, #44
    str r0, [sp, #200]
    ldr r7, =7
    ldr r9, =4
    mul r0, r7, r9
    str r0, [sp, #204]
    str r1, [sp, #24]
    ldr r0, [sp, #200]
    ldr r1, [sp, #204]
    add r0, r0, r1
    str r0, [sp, #196]
    ldr r0, [sp, #196]
    ldr r7, [r0]
    STM SP, {r0, r1, r2, r3}
    mov r0, r6
    mov r1, r7
    bl func2
    LDMIB SP, {r1, r2, r3}
    mov r9, r0
    ldr r0, [SP]
    add r0, sp, #44
    str r0, [sp, #208]
    ldr r6, =8
    ldr r7, =4
    mul r0, r6, r7
    str r0, [sp, #192]
    ldr r1, [sp, #192]
    ldr r0, [sp, #208]
    add r0, r0, r1
    str r0, [sp, #180]
    ldr r0, [sp, #180]
    ldr r6, [r0]
    add r7, sp, #44
    ldr r7, =9
    ldr r0, =4
    str r0, [sp, #272]
    ldr r0, [sp, #272]
    mul r0, r7, r0
    str r0, [sp, #168]
    ldr r0, [sp, #168]
    add r0, r7, r0
    str r0, [sp, #164]
    ldr r0, [sp, #164]
    ldr r7, [r0]
    STM SP, {r0, r1, r2, r3}
    mov r0, r7
    bl func7
    LDMIB SP, {r1, r2, r3}
    str r0, [sp, #216]
    ldr r0, [SP]
    STM SP, {r0, r1, r2, r3}
    mov r0, r6
    ldr r1, [sp, #216]
    bl func3
    LDMIB SP, {r1, r2, r3}
    str r0, [sp, #220]
    ldr r0, [SP]
    ldr r0, [sp, #20]
    STM SP, {r0, r1, r2, r3}
    mov r0, r9
    ldr r1, [sp, #220]
    ldr r2, [sp]
    bl func1
    LDMIB SP, {r1, r2, r3}
    mov r7, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2, r3}
    mov r0, r8
    mov r1, r5
    mov r2, r7
    bl func4
    LDMIB SP, {r1, r2, r3}
    mov r6, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r2, r3}
    ldr r0, [sp, #8]
    bl func7
    LDMIB SP, {r1, r2, r3}
    mov r9, r0
    ldr r0, [SP]
    STM SP, {r0, r1, r3}
    mov r0, r9
    ldr r1, [sp, #8]
    bl func3
    LDMIB SP, {r1, r3}
    mov r8, r0
    ldr r0, [SP]
    ldr r1, [sp, #24]
    STM SP, {r0, r1}
    ldr r0, [sp, #4]
    mov r1, r8
    bl func2
    LDMIB SP, {r1}
    mov r5, r0
    ldr r0, [SP]
    STM SP, {r0}
    mov r0, r6
    mov r1, r5
    bl func3
    mov r7, r0
    ldr r0, [SP]
    add r9, sp, #44
    ldr r8, =0
    ldr r6, =4
    mul r5, r8, r6
    str r0, [sp, #20]
    add r0, r9, r5
    str r0, [sp, #212]
    ldr r0, [sp, #212]
    ldr r8, [r0]
    add r6, sp, #44
    ldr r5, =1
    ldr r9, =4
    mul r0, r5, r9
    str r0, [sp, #248]
    ldr r0, [sp, #248]
    add r0, r6, r0
    str r0, [sp, #240]
    ldr r0, [sp, #240]
    ldr r5, [r0]
    STM SP, {r0}
    mov r0, r7
    mov r1, r8
    mov r2, r5
    bl func1
    mov r9, r0
    ldr r0, [SP]
    add r6, sp, #44
    ldr r7, =2
    ldr r8, =4
    mul r5, r7, r8
    add r0, r6, r5
    str r0, [sp, #236]
    ldr r0, [sp, #236]
    ldr r7, [r0]
    STM SP, {r0}
    mov r0, r9
    mov r1, r7
    bl func2
    mov r8, r0
    ldr r0, [SP]
    add r5, sp, #44
    ldr r6, =3
    ldr r9, =4
    mul r7, r6, r9
    add r0, r5, r7
    str r0, [sp, #232]
    ldr r0, [sp, #232]
    ldr r6, [r0]
    add r9, sp, #44
    ldr r7, =4
    ldr r5, =4
    mul r0, r7, r5
    str r0, [sp, #228]
    ldr r0, [sp, #228]
    add r0, r9, r0
    str r0, [sp, #252]
    ldr r0, [sp, #252]
    ldr r7, [r0]
    add r5, sp, #44
    ldr r9, =5
    ldr r0, =4
    str r0, [sp, #272]
    ldr r0, [sp, #272]
    mul r0, r9, r0
    str r0, [sp, #128]
    ldr r0, [sp, #128]
    add r0, r5, r0
    str r0, [sp, #124]
    ldr r0, [sp, #124]
    ldr r9, [r0]
    STM SP, {r0}
    mov r0, r9
    bl func5
    mov r5, r0
    ldr r0, [SP]
    STM SP, {r0}
    mov r0, r7
    mov r1, r5
    bl func3
    str r0, [sp, #244]
    ldr r0, [SP]
    add r9, sp, #44
    ldr r5, =6
    ldr r7, =4
    mul r0, r5, r7
    str r0, [sp, #112]
    ldr r0, [sp, #112]
    add r0, r9, r0
    str r0, [sp, #88]
    ldr r0, [sp, #88]
    ldr r5, [r0]
    STM SP, {r0}
    mov r0, r5
    bl func5
    mov r7, r0
    ldr r0, [SP]
    STM SP, {r0}
    ldr r0, [sp, #244]
    mov r1, r7
    bl func2
    mov r9, r0
    ldr r0, [SP]
    add r5, sp, #44
    ldr r7, =7
    ldr r0, =4
    str r0, [sp, #272]
    ldr r0, [sp, #272]
    mul r0, r7, r0
    str r0, [sp, #264]
    ldr r0, [sp, #264]
    add r0, r5, r0
    str r0, [sp, #136]
    ldr r0, [sp, #136]
    ldr r7, [r0]
    add r5, sp, #44
    ldr r5, =8
    ldr r0, =4
    str r0, [sp, #272]
    ldr r0, [sp, #272]
    mul r0, r5, r0
    str r0, [sp, #108]
    ldr r0, [sp, #108]
    add r0, r5, r0
    str r0, [sp, #104]
    ldr r0, [sp, #104]
    ldr r5, [r0]
    STM SP, {r0}
    mov r0, r5
    bl func7
    str r0, [sp, #256]
    ldr r0, [SP]
    STM SP, {r0}
    mov r0, r9
    mov r1, r7
    ldr r2, [sp, #256]
    bl func1
    str r0, [sp, #260]
    ldr r0, [SP]
    add r5, sp, #44
    ldr r9, =9
    ldr r7, =4
    mul r0, r9, r7
    str r0, [sp, #116]
    ldr r0, [sp, #116]
    add r0, r5, r0
    str r0, [sp, #120]
    ldr r0, [sp, #120]
    ldr r9, [r0]
    STM SP, {r0}
    mov r0, r9
    bl func5
    mov r7, r0
    ldr r0, [SP]
    STM SP, {r0}
    ldr r0, [sp, #260]
    mov r1, r7
    bl func2
    mov r5, r0
    ldr r0, [SP]
    ldr r0, [sp, #20]
    STM SP, {r0}
    mov r0, r5
    ldr r1, [sp]
    bl func3
    mov r9, r0
    ldr r0, [SP]
    mov r0, r8
    mov r1, r6
    mov r2, r9
    bl func1
    mov r7, r0
    b bb7_3
bb7_3:
    mov r0, r7
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

