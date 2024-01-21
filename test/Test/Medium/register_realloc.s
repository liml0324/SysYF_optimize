    .arch armv8 
    .text 
    .globl func
    .p2align 2
    .type func, %function
func:
    push {r4, r5, r6, r7, r8, r9, lr}
    ldr lr, =248
    sub sp, sp, lr
    add r2, r0, r1
    ldr r3, =1
    add r4, r3, #1
    ldr r5, =2
    add r6, r5, #2
    ldr r7, =3
    add r8, r7, #3
    ldr r9, =4
    add r3, r9, #4
    add r5, r4, #1
    add r7, r6, #2
    add r9, r8, #3
    str r0, [sp]
    add r0, r3, #4
    str r0, [sp, #4]
    add r0, r5, #1
    str r0, [sp, #8]
    add r0, r7, #2
    str r0, [sp, #12]
    add r0, r9, #3
    str r0, [sp, #16]
    ldr r0, [sp, #4]
    add r0, r0, #4
    str r0, [sp, #20]
    ldr r0, [sp, #8]
    add r0, r0, #1
    str r0, [sp, #24]
    ldr r0, [sp, #12]
    add r0, r0, #2
    str r0, [sp, #28]
    ldr r0, [sp, #16]
    add r0, r0, #3
    str r0, [sp, #32]
    ldr r0, [sp, #20]
    add r0, r0, #4
    str r0, [sp, #36]
    ldr r0, [sp, #24]
    add r0, r0, #1
    str r0, [sp, #40]
    ldr r0, [sp, #28]
    add r0, r0, #2
    str r0, [sp, #44]
    ldr r0, [sp, #32]
    add r0, r0, #3
    str r0, [sp, #48]
    ldr r0, [sp, #36]
    add r0, r0, #4
    str r0, [sp, #52]
    ldr r0, [sp, #40]
    add r0, r0, #1
    str r0, [sp, #56]
    ldr r0, [sp, #44]
    add r0, r0, #2
    str r0, [sp, #60]
    ldr r0, [sp, #48]
    add r0, r0, #3
    str r0, [sp, #64]
    ldr r0, [sp, #52]
    add r0, r0, #4
    str r0, [sp, #68]
    ldr r0, [sp, #56]
    add r0, r0, #1
    str r0, [sp, #72]
    ldr r0, [sp, #60]
    add r0, r0, #2
    str r0, [sp, #76]
    ldr r0, [sp, #64]
    add r0, r0, #3
    str r0, [sp, #80]
    ldr r0, [sp, #68]
    add r0, r0, #4
    str r0, [sp, #84]
    ldr r0, [sp, #72]
    add r0, r0, #1
    str r0, [sp, #88]
    ldr r0, [sp, #76]
    add r0, r0, #2
    str r0, [sp, #92]
    ldr r0, [sp, #80]
    add r0, r0, #3
    str r0, [sp, #96]
    ldr r0, [sp, #84]
    add r0, r0, #4
    str r0, [sp, #100]
    ldr r0, [sp]
    str r2, [sp]
    sub r2, r0, r1
    str r2, [sp, #104]
    ldr r2, [sp, #104]
    add r2, r2, #10
    str r2, [sp, #108]
    ldr r2, [sp, #72]
    add r0, r2, #1
    ldr r2, [sp, #76]
    add r1, r2, #2
    ldr r2, [sp, #80]
    add r2, r2, #3
    str r2, [sp, #112]
    ldr r2, [sp, #84]
    add r2, r2, #4
    str r2, [sp, #116]
    ldr r2, [sp, #56]
    add r2, r2, #1
    str r2, [sp, #120]
    ldr r2, [sp, #60]
    add r2, r2, #2
    str r2, [sp, #124]
    ldr r2, [sp, #64]
    add r2, r2, #3
    str r2, [sp, #128]
    ldr r2, [sp, #68]
    add r2, r2, #4
    str r2, [sp, #132]
    ldr r2, [sp, #40]
    add r2, r2, #1
    str r2, [sp, #136]
    ldr r2, [sp, #44]
    add r2, r2, #2
    str r2, [sp, #140]
    ldr r2, [sp, #48]
    add r2, r2, #3
    str r2, [sp, #144]
    ldr r2, [sp, #52]
    add r2, r2, #4
    str r2, [sp, #148]
    ldr r2, [sp, #24]
    add r2, r2, #1
    str r2, [sp, #152]
    ldr r2, [sp, #28]
    add r2, r2, #2
    str r2, [sp, #156]
    ldr r2, [sp, #32]
    add r2, r2, #3
    str r2, [sp, #160]
    ldr r2, [sp, #36]
    add r2, r2, #4
    str r2, [sp, #164]
    ldr r2, [sp, #8]
    add r2, r2, #1
    str r2, [sp, #168]
    ldr r2, [sp, #12]
    add r2, r2, #2
    str r2, [sp, #172]
    ldr r2, [sp, #16]
    add r2, r2, #3
    str r2, [sp, #176]
    ldr r2, [sp, #20]
    add r2, r2, #4
    str r2, [sp, #180]
    add r2, r5, #1
    str r2, [sp, #184]
    add r2, r7, #2
    str r2, [sp, #188]
    add r5, r9, #3
    ldr r2, [sp, #4]
    add r7, r2, #4
    add r9, r4, #1
    add r2, r6, #2
    str r2, [sp, #192]
    add r4, r8, #3
    add r6, r3, #4
    ldr r8, =1
    add r3, r8, #1
    ldr r2, =2
    str r2, [sp, #100]
    ldr r2, [sp, #100]
    add r8, r2, #2
    ldr r3, =3
    add r2, r3, #3
    str r2, [sp, #196]
    ldr r2, =4
    str r2, [sp, #36]
    ldr r2, [sp, #36]
    add r3, r2, #4
    add r8, r0, #1
    add r2, r1, #2
    str r2, [sp, #200]
    ldr r2, [sp, #112]
    add r2, r2, #3
    str r2, [sp, #204]
    ldr r2, [sp, #116]
    add r2, r2, #4
    str r2, [sp, #208]
    ldr r2, [sp, #108]
    add r2, r2, r8
    str r2, [sp, #212]
    str r0, [sp, #4]
    ldr r0, [sp, #200]
    ldr r2, [sp, #212]
    add r2, r2, r0
    str r2, [sp, #216]
    ldr r2, [sp, #204]
    ldr r0, [sp, #216]
    add r8, r0, r2
    ldr r0, [sp, #208]
    add r0, r8, r0
    str r0, [sp, #220]
    ldr r0, [sp, #220]
    sub r0, r0, r3
    str r0, [sp, #224]
    ldr r0, [sp, #224]
    sub r8, r0, r8
    ldr r0, [sp, #196]
    sub r0, r8, r0
    str r0, [sp, #228]
    ldr r0, [sp, #228]
    sub r0, r0, r3
    str r0, [sp, #232]
    ldr r0, [sp, #232]
    add r8, r0, r9
    ldr r0, [sp, #192]
    add r3, r8, r0
    add r9, r3, r4
    add r8, r9, r6
    ldr r0, [sp, #184]
    sub r4, r8, r0
    ldr r0, [sp, #188]
    sub r3, r4, r0
    sub r6, r3, r5
    sub r9, r6, r7
    ldr r0, [sp, #168]
    add r8, r9, r0
    ldr r0, [sp, #172]
    add r4, r8, r0
    ldr r0, [sp, #176]
    add r5, r4, r0
    ldr r0, [sp, #180]
    add r3, r5, r0
    ldr r0, [sp, #152]
    sub r7, r3, r0
    ldr r0, [sp, #156]
    sub r6, r7, r0
    ldr r0, [sp, #160]
    sub r9, r6, r0
    ldr r0, [sp, #164]
    sub r8, r9, r0
    ldr r0, [sp, #136]
    add r4, r8, r0
    ldr r0, [sp, #140]
    add r5, r4, r0
    ldr r0, [sp, #144]
    add r3, r5, r0
    ldr r0, [sp, #148]
    add r7, r3, r0
    ldr r0, [sp, #120]
    sub r6, r7, r0
    ldr r0, [sp, #124]
    sub r9, r6, r0
    ldr r0, [sp, #128]
    sub r8, r9, r0
    ldr r0, [sp, #132]
    sub r4, r8, r0
    ldr r0, [sp, #4]
    add r5, r4, r0
    add r3, r5, r1
    ldr r2, [sp, #112]
    add r7, r3, r2
    ldr r2, [sp, #116]
    add r6, r7, r2
    ldr r2, [sp]
    b bb0_0
bb0_0:
    mov r0, r6
    ldr lr, =248
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
    ldr r0, =1
    add r1, r0, #18
    STM SP, {r1, r2}
    ldr r0, =1
    ldr r1, [sp]
    bl func
    LDM SP, {r1, r2}
    mov r2, r0
    b bb1_0
bb1_0:
    b litpool1_0
    .pool
litpool1_0:
    mov r0, r2
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

