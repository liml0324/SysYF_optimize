    .arch armv8 
    .text 
    .globl foo
    .p2align 2
    .type foo, %function
foo:
    push {r4, r5, r6, r7, r8, r9, lr}
    sub sp, sp, #80
    add r0, sp, #4
    ldr r1, =0
    ldr r2, =4
    mul r3, r1, r2
    add r4, r0, r3
    ldr r5, =0
    str r5, [r4]
    add r6, sp, #4
    ldr r7, =1
    ldr r8, =4
    mul r9, r7, r8
    add r1, r6, r9
    ldr r2, =1
    str r2, [r1]
    add r0, sp, #4
    ldr r3, =2
    ldr r4, =4
    mul r5, r3, r4
    add r7, r0, r5
    ldr r8, =2
    str r8, [r7]
    add r6, sp, #4
    ldr r9, =3
    ldr r1, =4
    mul r2, r9, r1
    add r3, r6, r2
    ldr r4, =3
    str r4, [r3]
    add r0, sp, #4
    ldr r5, =4
    ldr r7, =4
    mul r8, r5, r7
    add r9, r0, r8
    ldr r1, =0
    str r1, [r9]
    add r6, sp, #4
    ldr r2, =5
    ldr r3, =4
    mul r4, r2, r3
    add r5, r6, r4
    ldr r7, =1
    str r7, [r5]
    add r0, sp, #4
    ldr r8, =6
    ldr r9, =4
    mul r1, r8, r9
    add r2, r0, r1
    ldr r3, =2
    str r3, [r2]
    add r4, sp, #4
    ldr r6, =7
    ldr r5, =4
    mul r7, r6, r5
    add r8, r4, r7
    ldr r9, =3
    str r9, [r8]
    add r1, sp, #4
    ldr r0, =8
    ldr r2, =4
    mul r3, r0, r2
    add r6, r1, r3
    ldr r5, =0
    str r5, [r6]
    add r7, sp, #4
    ldr r4, =9
    ldr r8, =4
    mul r9, r4, r8
    add r0, r7, r9
    ldr r2, =1
    str r2, [r0]
    add r1, sp, #4
    ldr r3, =10
    ldr r6, =4
    mul r5, r3, r6
    add r4, r1, r5
    ldr r8, =2
    str r8, [r4]
    add r7, sp, #4
    ldr r9, =11
    ldr r0, =4
    mul r2, r9, r0
    add r3, r7, r2
    ldr r6, =3
    str r6, [r3]
    add r1, sp, #4
    ldr r5, =12
    ldr r4, =4
    mul r8, r5, r4
    add r9, r1, r8
    ldr r0, =0
    str r0, [r9]
    add r7, sp, #4
    ldr r2, =13
    ldr r3, =4
    mul r6, r2, r3
    add r5, r7, r6
    ldr r4, =1
    str r4, [r5]
    add r8, sp, #4
    ldr r1, =14
    ldr r9, =4
    mul r0, r1, r9
    add r2, r8, r0
    ldr r3, =2
    str r3, [r2]
    add r6, sp, #4
    ldr r7, =15
    ldr r5, =4
    mul r4, r7, r5
    add r1, r6, r4
    ldr r9, =3
    str r9, [r1]
    add r0, sp, #4
    ldr r8, =3
    ldr r2, =4
    mul r3, r8, r2
    add r7, r0, r3
    ldr r5, [r7]
    add r4, r5, #71
    b bb0_0
bb0_0:
    mov r0, r4
    add sp, sp, #80
    pop {r4, r5, r6, r7, r8, r9, lr}
    bx lr
    .pool

    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r11, lr}
    mov r11, sp
    sub sp, sp, #36
    STM SP, {r0}
    bl foo
    add r1, r0, #30
    STM SP, {r1, r2}
    bl foo
    LDM SP, {r1, r2}
    mov r2, r0
    add r3, r2, #41
    add r4, r1, r3
    add r5, r4, #35
    mov r0, r5
    bl put_int
    ldr r0, =10
    bl put_char
    b bb1_0
bb1_0:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r11, lr}
    bx lr
    .pool

