    .arch armv8 
    .text 
    .globl long_array
    .p2align 2
    .type long_array, %function
long_array:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    ldr lr, =120227
    sub sp, sp, lr
    Ldr r1, =0
    b bb0_0
bb0_0:
    ldr r2, =10000
    cmp r1, r2
    ldr r3, =0
    ldrlt r3, =1
    ldr r4, =10000
    cmp r1, r4
    blt bb0_1
    b bb0_2
bb0_1:
    add r9, r1, #0
    add r2, sp, #36
    ldr r3, =4
    mul r6, r9, r3
    add r8, r2, r6
    mul r7, r1, r1
    ldr r5, =10
    sdiv r4, r7, r5
    ldr r9, =10
    mul r3, r4, r9
    sub r2, r7, r3
    str r2, [r8]
    add r6, r1, #1
    Mov r1, r6
    b bb0_0
bb0_2:
    Ldr r5, =0
    b bb0_3
bb0_3:
    ldr r6, =10000
    cmp r5, r6
    ldr r7, =0
    ldrlt r7, =1
    ldr r8, =10000
    cmp r5, r8
    blt bb0_4
    b bb0_5
bb0_4:
    add r7, r5, #0
    ldr r3, =40036
    add r3, sp, r3
    ldr r6, =4
    mul r2, r7, r6
    add r8, r3, r2
    add r9, r5, #0
    add r4, sp, #36
    ldr r6, =4
    mul r7, r9, r6
    add r2, r4, r7
    ldr r3, [r2]
    add r6, r5, #0
    add r9, sp, #36
    ldr r7, =4
    mul r4, r6, r7
    add r2, r9, r4
    ldr r7, [r2]
    mul r6, r3, r7
    ldr r4, =10
    sdiv r9, r6, r4
    ldr r2, =10
    mul r3, r9, r2
    sub r7, r6, r3
    str r7, [r8]
    add r4, r5, #1
    Mov r5, r4
    b bb0_3
bb0_5:
    Ldr r9, =0
    b bb0_6
bb0_6:
    b litpool0_0
    .pool
litpool0_0:
    ldr r2, =10000
    cmp r9, r2
    ldr r3, =0
    ldrlt r3, =1
    ldr r4, =10000
    cmp r9, r4
    blt bb0_7
    b bb0_8
bb0_7:
    add r7, r9, #0
    ldr r3, =80036
    add r3, sp, r3
    ldr r6, =4
    mul r8, r7, r6
    add r2, r3, r8
    add r4, r9, #0
    ldr r6, =40036
    add r6, sp, r6
    ldr r7, =4
    mul r8, r4, r7
    add r3, r6, r8
    ldr r7, [r3]
    add r4, r9, #0
    ldr r8, =40036
    add r8, sp, r8
    ldr r6, =4
    mul r3, r4, r6
    str r0, [sp, #20]
    add r0, r8, r3
    ldr lr, =120179
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120179
    add lr, lr, sp
    ldr r0, [lr]
    ldr r6, [r0]
    mul r4, r7, r6
    ldr r3, =100
    sdiv r8, r4, r3
    ldr r7, =100
    mul r6, r8, r7
    sub r3, r4, r6
    add r8, r9, #0
    add r7, sp, #36
    ldr r6, =4
    mul r4, r8, r6
    add r0, r7, r4
    ldr lr, =120183
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120183
    add lr, lr, sp
    ldr r0, [lr]
    ldr r6, [r0]
    add r8, r3, r6
    str r8, [r2]
    add r4, r9, #1
    ldr r0, [sp, #20]
    Mov r9, r4
    b bb0_6
bb0_8:
    Ldr r2, =0
    Ldr r7, =0
    b bb0_9
bb0_9:
    ldr r4, =10000
    cmp r2, r4
    ldr r3, =0
    ldrlt r3, =1
    str r0, [sp, #20]
    ldr r0, =10000
    ldr lr, =120081
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120081
    add lr, lr, sp
    ldr r0, [lr]
    cmp r2, r0
    ldr r0, [sp, #20]
    blt bb0_10
    b bb0_11
bb0_10:
    ldr r4, =10
    cmp r2, r4
    ldr r3, =0
    ldrlt r3, =1
    str r0, [sp, #20]
    ldr r0, =10
    ldr lr, =120061
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120061
    add lr, lr, sp
    ldr r0, [lr]
    cmp r2, r0
    ldr r0, [sp, #20]
    blt bb0_12
    b bb0_13
bb0_11:
    b litpool0_1
    .pool
litpool0_1:
    b bb0_30
bb0_12:
    add r3, r2, #0
    str r0, [sp, #20]
    ldr r0, =80036
    add r0, sp, r0
    ldr lr, =120052
    add lr, lr, sp
    str r0, [lr]
    ldr r0, =4
    ldr lr, =120061
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120061
    add lr, lr, sp
    ldr r0, [lr]
    mul r0, r3, r0
    ldr lr, =120195
    add lr, lr, sp
    str r0, [lr]
    str r1, [sp, #24]
    ldr lr, =120052
    add lr, lr, sp
    ldr r0, [lr]
    ldr lr, =120195
    add lr, lr, sp
    ldr r1, [lr]
    add r0, r0, r1
    ldr lr, =120215
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120215
    add lr, lr, sp
    ldr r0, [lr]
    ldr r3, [r0]
    add r0, r7, r3
    ldr lr, =120056
    add lr, lr, sp
    str r0, [lr]
    ldr r0, =1333
    ldr lr, =120048
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120048
    add lr, lr, sp
    ldr r1, [lr]
    ldr lr, =120056
    add lr, lr, sp
    ldr r0, [lr]
    sdiv r7, r0, r1
    ldr r3, =1333
    mul r0, r7, r3
    ldr lr, =120095
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120056
    add lr, lr, sp
    ldr r0, [lr]
    ldr lr, =120095
    add lr, lr, sp
    ldr r1, [lr]
    sub r0, r0, r1
    ldr lr, =120089
    add lr, lr, sp
    str r0, [lr]
    STM SP, {r0, r2}
    ldr lr, =120089
    add lr, lr, sp
    ldr r0, [lr]
    bl put_int
    LDM sp, {r0, r2}
    ldr r0, [sp, #20]
    ldr r1, [sp, #24]
    ldr lr, =120163
    add lr, lr, sp
    str r6, [lr]
    Mov r3, r8
    ldr lr, =120089
    add lr, lr, sp
    ldr r4, [lr]
    b bb0_14
bb0_13:
    ldr r4, =20
    cmp r2, r4
    ldr r3, =0
    ldrlt r3, =1
    str r0, [sp, #20]
    ldr r0, =20
    ldr lr, =120044
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120044
    add lr, lr, sp
    ldr r0, [lr]
    cmp r2, r0
    ldr r0, [sp, #20]
    blt bb0_15
    b bb0_16
bb0_14:
    str r0, [sp, #20]
    add r0, r2, #1
    ldr lr, =120147
    add lr, lr, sp
    str r0, [lr]
    ldr r0, [sp, #20]
    ldr lr, =120147
    add lr, lr, sp
    ldr r2, [lr]
    ldr lr, =120163
    add lr, lr, sp
    ldr r6, [lr]
    Mov r7, r4
    Mov r8, r3
    b bb0_9
bb0_15:
    Mov r3, r7
    Ldr r4, =5000
    b bb0_18
bb0_16:
    b litpool0_2
    .pool
litpool0_2:
    ldr r4, =30
    cmp r2, r4
    ldr r3, =0
    ldrlt r3, =1
    str r0, [sp, #20]
    ldr r0, =30
    ldr lr, =120040
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120040
    add lr, lr, sp
    ldr r0, [lr]
    cmp r2, r0
    ldr r0, [sp, #20]
    blt bb0_21
    b bb0_22
bb0_17:
    ldr lr, =120159
    add lr, lr, sp
    ldr r12, [lr]
    ldr lr, =120163
    add lr, lr, sp
    str r12, [lr]
    b bb0_14
bb0_18:
    ldr r3, =10000
    str r0, [sp, #20]
    cmp r4, r3
    ldr r0, =0
    ldrlt r0, =1
    ldr lr, =120060
    add lr, lr, sp
    str r0, [lr]
    ldr r0, =10000
    ldr lr, =120199
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120199
    add lr, lr, sp
    ldr r0, [lr]
    cmp r4, r0
    ldr r0, [sp, #20]
    blt bb0_19
    b bb0_20
bb0_19:
    add r3, r2, #0
    str r0, [sp, #20]
    ldr r0, =80036
    add r0, sp, r0
    ldr lr, =120061
    add lr, lr, sp
    str r0, [lr]
    ldr r0, =4
    ldr lr, =120195
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120195
    add lr, lr, sp
    ldr r0, [lr]
    mul r0, r3, r0
    ldr lr, =120219
    add lr, lr, sp
    str r0, [lr]
    str r1, [sp, #24]
    ldr lr, =120061
    add lr, lr, sp
    ldr r0, [lr]
    ldr lr, =120219
    add lr, lr, sp
    ldr r1, [lr]
    add r0, r0, r1
    ldr lr, =120187
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120187
    add lr, lr, sp
    ldr r0, [lr]
    ldr r3, [r0]
    add r0, r3, r3
    ldr lr, =120065
    add lr, lr, sp
    str r0, [lr]
    add r0, r4, #0
    ldr lr, =120073
    add lr, lr, sp
    str r0, [lr]
    add r3, sp, #36
    ldr r3, =4
    ldr lr, =120073
    add lr, lr, sp
    ldr r0, [lr]
    mul r0, r0, r3
    ldr lr, =120191
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120191
    add lr, lr, sp
    ldr r0, [lr]
    add r0, r3, r0
    ldr lr, =120207
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120207
    add lr, lr, sp
    ldr r0, [lr]
    ldr r3, [r0]
    ldr lr, =120065
    add lr, lr, sp
    ldr r0, [lr]
    sub r0, r0, r3
    ldr lr, =120077
    add lr, lr, sp
    str r0, [lr]
    add r0, r4, #1
    ldr lr, =120081
    add lr, lr, sp
    str r0, [lr]
    ldr r0, [sp, #20]
    ldr r1, [sp, #24]
    ldr lr, =120077
    add lr, lr, sp
    ldr r3, [lr]
    ldr lr, =120081
    add lr, lr, sp
    ldr r4, [lr]
    b bb0_18
bb0_20:
    STM SP, {r0, r2, r3}
    ldr r0, [sp, #8]
    bl put_int
    LDM sp, {r0, r2, r3}
    ldr lr, =120159
    add lr, lr, sp
    str r6, [lr]
    Mov r10, r4
    Mov r4, r3
    Mov r3, r10
    b bb0_17
bb0_21:
    Ldr r3, =5000
    Mov r4, r7
    b bb0_24
bb0_22:
    b litpool0_3
    .pool
litpool0_3:
    add r4, r2, #0
    ldr r3, =80036
    add r3, sp, r3
    str r0, [sp, #20]
    ldr r0, =4
    ldr lr, =120219
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120219
    add lr, lr, sp
    ldr r0, [lr]
    mul r0, r4, r0
    ldr lr, =120044
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120044
    add lr, lr, sp
    ldr r0, [lr]
    add r0, r3, r0
    ldr lr, =120036
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120036
    add lr, lr, sp
    ldr r0, [lr]
    ldr r4, [r0]
    ldr r0, [sp, #20]
    mul r3, r4, r0
    str r0, [sp, #20]
    add r0, r7, r3
    ldr lr, =120139
    add lr, lr, sp
    str r0, [lr]
    ldr r4, =99988
    ldr lr, =120139
    add lr, lr, sp
    ldr r0, [lr]
    sdiv r3, r0, r4
    ldr r0, =99988
    ldr lr, =120203
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120203
    add lr, lr, sp
    ldr r0, [lr]
    mul r4, r3, r0
    ldr lr, =120139
    add lr, lr, sp
    ldr r0, [lr]
    sub r0, r0, r4
    ldr lr, =120040
    add lr, lr, sp
    str r0, [lr]
    ldr r0, [sp, #20]
    Mov r3, r6
    ldr lr, =120040
    add lr, lr, sp
    ldr r4, [lr]
    b bb0_23
bb0_23:
    ldr lr, =120159
    add lr, lr, sp
    str r3, [lr]
    Mov r3, r8
    b bb0_17
bb0_24:
    ldr r4, =10000
    str r0, [sp, #20]
    cmp r3, r4
    ldr r0, =0
    ldrlt r0, =1
    ldr lr, =120093
    add lr, lr, sp
    str r0, [lr]
    ldr r0, =10000
    ldr lr, =120207
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120207
    add lr, lr, sp
    ldr r0, [lr]
    cmp r3, r0
    ldr r0, [sp, #20]
    blt bb0_25
    b bb0_26
bb0_25:
    ldr r4, =2233
    str r0, [sp, #20]
    cmp r3, r4
    ldr r0, =0
    ldrgt r0, =1
    ldr lr, =120094
    add lr, lr, sp
    str r0, [lr]
    ldr r0, =2233
    ldr lr, =120040
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120040
    add lr, lr, sp
    ldr r0, [lr]
    cmp r3, r0
    ldr r0, [sp, #20]
    bgt bb0_27
    b bb0_28
bb0_26:
    b litpool0_4
    .pool
litpool0_4:
    STM SP, {r0, r2, r3}
    mov r0, r4
    bl put_int
    LDM sp, {r0, r2, r3}
    b bb0_23
bb0_27:
    str r0, [sp, #20]
    add r0, r2, #0
    ldr lr, =120099
    add lr, lr, sp
    str r0, [lr]
    ldr r4, =40036
    add r4, sp, r4
    ldr r4, =4
    ldr lr, =120099
    add lr, lr, sp
    ldr r0, [lr]
    mul r0, r0, r4
    ldr lr, =120048
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120048
    add lr, lr, sp
    ldr r0, [lr]
    add r0, r4, r0
    ldr lr, =120069
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120069
    add lr, lr, sp
    ldr r0, [lr]
    ldr r4, [r0]
    add r0, r4, r4
    ldr lr, =120103
    add lr, lr, sp
    str r0, [lr]
    add r0, r3, #0
    ldr lr, =120107
    add lr, lr, sp
    str r0, [lr]
    add r4, sp, #36
    ldr r4, =4
    ldr lr, =120107
    add lr, lr, sp
    ldr r0, [lr]
    mul r0, r0, r4
    ldr lr, =120203
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120203
    add lr, lr, sp
    ldr r0, [lr]
    add r0, r4, r0
    ldr lr, =120199
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120199
    add lr, lr, sp
    ldr r0, [lr]
    ldr r4, [r0]
    ldr lr, =120103
    add lr, lr, sp
    ldr r0, [lr]
    sub r0, r0, r4
    ldr lr, =120111
    add lr, lr, sp
    str r0, [lr]
    add r0, r3, #1
    ldr lr, =120115
    add lr, lr, sp
    str r0, [lr]
    ldr r0, [sp, #20]
    ldr lr, =120115
    add lr, lr, sp
    ldr r12, [lr]
    ldr lr, =120155
    add lr, lr, sp
    str r12, [lr]
    ldr lr, =120111
    add lr, lr, sp
    ldr r4, [lr]
    b bb0_29
bb0_28:
    add r4, r2, #0
    str r0, [sp, #20]
    add r0, sp, #36
    ldr lr, =120119
    add lr, lr, sp
    str r0, [lr]
    ldr r0, =4
    ldr lr, =120211
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120211
    add lr, lr, sp
    ldr r0, [lr]
    mul r0, r4, r0
    ldr lr, =120167
    add lr, lr, sp
    str r0, [lr]
    str r1, [sp, #24]
    ldr lr, =120119
    add lr, lr, sp
    ldr r0, [lr]
    ldr lr, =120167
    add lr, lr, sp
    ldr r1, [lr]
    add r0, r0, r1
    ldr lr, =120171
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120171
    add lr, lr, sp
    ldr r0, [lr]
    ldr r4, [r0]
    add r0, r4, r4
    ldr lr, =120123
    add lr, lr, sp
    str r0, [lr]
    add r0, r3, #0
    ldr lr, =120127
    add lr, lr, sp
    str r0, [lr]
    ldr r4, =80036
    add r4, sp, r4
    ldr r4, =4
    ldr lr, =120127
    add lr, lr, sp
    ldr r0, [lr]
    mul r0, r0, r4
    ldr lr, =120151
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120151
    add lr, lr, sp
    ldr r0, [lr]
    add r0, r4, r0
    ldr lr, =120085
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120085
    add lr, lr, sp
    ldr r0, [lr]
    ldr r4, [r0]
    ldr lr, =120123
    add lr, lr, sp
    ldr r0, [lr]
    add r0, r0, r4
    ldr lr, =120131
    add lr, lr, sp
    str r0, [lr]
    ldr r0, =13333
    ldr lr, =120183
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120131
    add lr, lr, sp
    ldr r0, [lr]
    ldr lr, =120183
    add lr, lr, sp
    ldr r1, [lr]
    sdiv r4, r0, r1
    ldr r0, =13333
    ldr lr, =120211
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120211
    add lr, lr, sp
    ldr r0, [lr]
    mul r0, r4, r0
    ldr lr, =120211
    add lr, lr, sp
    str r0, [lr]
    ldr lr, =120131
    add lr, lr, sp
    ldr r0, [lr]
    ldr lr, =120211
    add lr, lr, sp
    ldr r1, [lr]
    sub r0, r0, r1
    ldr lr, =120175
    add lr, lr, sp
    str r0, [lr]
    add r4, r3, #2
    ldr r0, [sp, #20]
    ldr r1, [sp, #24]
    ldr lr, =120155
    add lr, lr, sp
    str r4, [lr]
    ldr lr, =120175
    add lr, lr, sp
    ldr r4, [lr]
    b bb0_29
bb0_29:
    ldr lr, =120155
    add lr, lr, sp
    ldr r3, [lr]
    b bb0_24
bb0_30:
    b litpool0_5
    .pool
litpool0_5:
    mov r0, r7
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
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
    ldr r0, =9
    bl long_array
    b bb1_0
bb1_0:
    mov sp, r11
    pop {r11, lr}
    bx lr
    .pool

    .type ..N, %object
    .section .rodata,"a", %progbits
    .globl ..N
    .p2align 2
..N:
    .long 10000
    .size ..N, 4

