    .arch armv8 
    .text 
    .globl main
    .p2align 2
    .type main, %function
main:
    push {r4, r5, r6, r7, r8, r9, r11, lr}
    mov r11, sp
    ldr lr, =1202
    sub sp, sp, lr
    ldr r0, =524
    add r0, sp, r0
    ldr r1, =0
    ldr r2, =4
    mul r3, r1, r2
    add r4, r0, r3
    ldr r5, =1
    str r5, [r4]
    ldr r6, =524
    add r6, sp, r6
    ldr r7, =1
    ldr r8, =4
    mul r9, r7, r8
    add r1, r6, r9
    ldr r2, =2
    str r2, [r1]
    ldr r3, =524
    add r3, sp, r3
    ldr r0, =2
    ldr r4, =4
    mul r5, r0, r4
    add r7, r3, r5
    ldr r8, =3
    str r8, [r7]
    ldr r9, =524
    add r9, sp, r9
    ldr r6, =3
    ldr r1, =4
    mul r2, r6, r1
    add r0, r9, r2
    ldr r4, =4
    str r4, [r0]
    ldr r5, =524
    add r5, sp, r5
    ldr r3, =4
    ldr r7, =4
    mul r8, r3, r7
    add r6, r5, r8
    ldr r1, =5
    str r1, [r6]
    ldr r9, =524
    add r9, sp, r9
    ldr r2, =5
    ldr r0, =4
    mul r4, r2, r0
    add r3, r9, r4
    ldr r7, =6
    str r7, [r3]
    ldr r5, =524
    add r5, sp, r5
    ldr r8, =6
    ldr r6, =4
    mul r1, r8, r6
    add r2, r5, r1
    ldr r0, =7
    str r0, [r2]
    ldr r9, =524
    add r9, sp, r9
    ldr r4, =7
    ldr r3, =4
    mul r7, r4, r3
    add r8, r9, r7
    ldr r6, =8
    str r6, [r8]
    ldr r5, =524
    add r5, sp, r5
    ldr r1, =8
    ldr r2, =4
    mul r0, r1, r2
    add r4, r5, r0
    ldr r3, =9
    str r3, [r4]
    ldr r9, =524
    add r9, sp, r9
    ldr r7, =9
    ldr r8, =4
    mul r6, r7, r8
    add r1, r9, r6
    ldr r2, =0
    str r2, [r1]
    ldr r5, =524
    add r5, sp, r5
    ldr r0, =10
    ldr r4, =4
    mul r3, r0, r4
    add r7, r5, r3
    ldr r8, =1
    str r8, [r7]
    ldr r9, =524
    add r9, sp, r9
    ldr r6, =11
    ldr r1, =4
    mul r2, r6, r1
    add r0, r9, r2
    ldr r4, =2
    str r4, [r0]
    ldr r5, =524
    add r5, sp, r5
    ldr r3, =12
    ldr r7, =4
    mul r8, r3, r7
    add r6, r5, r8
    ldr r1, =3
    str r1, [r6]
    ldr r9, =524
    add r9, sp, r9
    ldr r2, =13
    ldr r0, =4
    mul r4, r2, r0
    add r3, r9, r4
    ldr r7, =4
    str r7, [r3]
    ldr r5, =524
    add r5, sp, r5
    ldr r8, =14
    ldr r6, =4
    mul r1, r8, r6
    add r2, r5, r1
    ldr r0, =5
    str r0, [r2]
    ldr r9, =524
    add r9, sp, r9
    ldr r4, =15
    ldr r3, =4
    mul r7, r4, r3
    add r8, r9, r7
    ldr r6, =6
    str r6, [r8]
    ldr r5, =524
    add r5, sp, r5
    ldr r1, =16
    ldr r2, =4
    mul r0, r1, r2
    add r4, r5, r0
    ldr r3, =7
    str r3, [r4]
    ldr r9, =524
    add r9, sp, r9
    ldr r7, =17
    ldr r8, =4
    mul r6, r7, r8
    add r1, r9, r6
    ldr r2, =8
    str r2, [r1]
    ldr r5, =524
    add r5, sp, r5
    ldr r0, =18
    ldr r4, =4
    mul r3, r0, r4
    add r7, r5, r3
    ldr r8, =9
    str r8, [r7]
    ldr r9, =524
    add r9, sp, r9
    ldr r6, =19
    ldr r1, =4
    mul r2, r6, r1
    add r0, r9, r2
    ldr r4, =0
    str r4, [r0]
    ldr r5, =604
    add r5, sp, r5
    ldr r3, =0
    ldr r7, =4
    mul r8, r3, r7
    add r6, r5, r8
    ldr r1, =2
    str r1, [r6]
    ldr r9, =604
    add r9, sp, r9
    ldr r2, =1
    ldr r0, =4
    mul r4, r2, r0
    add r3, r9, r4
    ldr r7, =3
    str r7, [r3]
    ldr r5, =604
    add r5, sp, r5
    ldr r8, =2
    ldr r6, =4
    mul r1, r8, r6
    add r2, r5, r1
    ldr r0, =4
    str r0, [r2]
    ldr r9, =604
    add r9, sp, r9
    ldr r4, =3
    ldr r3, =4
    mul r7, r4, r3
    add r8, r9, r7
    ldr r6, =2
    str r6, [r8]
    ldr r5, =604
    add r5, sp, r5
    ldr r1, =4
    ldr r2, =4
    mul r0, r1, r2
    add r4, r5, r0
    ldr r3, =5
    str r3, [r4]
    ldr r9, =604
    add r9, sp, r9
    ldr r7, =5
    ldr r8, =4
    mul r6, r7, r8
    add r1, r9, r6
    ldr r2, =7
    str r2, [r1]
    ldr r5, =604
    add r5, sp, r5
    ldr r0, =6
    ldr r4, =4
    mul r3, r0, r4
    add r7, r5, r3
    ldr r8, =9
    str r8, [r7]
    ldr r9, =604
    add r9, sp, r9
    ldr r6, =7
    ldr r1, =4
    mul r2, r6, r1
    add r0, r9, r2
    ldr r4, =9
    str r4, [r0]
    ldr r5, =604
    add r5, sp, r5
    ldr r3, =8
    ldr r7, =4
    mul r8, r3, r7
    add r6, r5, r8
    ldr r1, =0
    str r1, [r6]
    ldr r9, =604
    add r9, sp, r9
    ldr r2, =9
    ldr r0, =4
    mul r4, r2, r0
    add r3, r9, r4
    ldr r7, =1
    str r7, [r3]
    ldr r5, =604
    add r5, sp, r5
    ldr r8, =10
    ldr r6, =4
    mul r1, r8, r6
    add r2, r5, r1
    ldr r0, =9
    str r0, [r2]
    ldr r9, =604
    add r9, sp, r9
    ldr r4, =11
    ldr r3, =4
    mul r7, r4, r3
    add r8, r9, r7
    ldr r6, =8
    str r6, [r8]
    ldr r5, =604
    add r5, sp, r5
    ldr r1, =12
    ldr r2, =4
    mul r0, r1, r2
    add r4, r5, r0
    ldr r3, =7
    str r3, [r4]
    ldr r9, =604
    add r9, sp, r9
    ldr r7, =13
    ldr r8, =4
    mul r6, r7, r8
    add r1, r9, r6
    ldr r2, =6
    str r2, [r1]
    ldr r5, =604
    add r5, sp, r5
    ldr r0, =14
    ldr r4, =4
    mul r3, r0, r4
    add r7, r5, r3
    ldr r8, =4
    str r8, [r7]
    ldr r6, =604
    add r6, sp, r6
    ldr r9, =15
    ldr r1, =4
    mul r2, r9, r1
    add r0, r6, r2
    ldr r4, =3
    str r4, [r0]
    ldr r3, =604
    add r3, sp, r3
    ldr r5, =16
    ldr r7, =4
    mul r8, r5, r7
    add r9, r3, r8
    ldr r1, =2
    str r1, [r9]
    ldr r2, =604
    add r2, sp, r2
    ldr r6, =17
    ldr r0, =4
    mul r4, r6, r0
    add r5, r2, r4
    ldr r7, =1
    str r7, [r5]
    ldr r8, =604
    add r8, sp, r8
    ldr r3, =18
    ldr r9, =4
    mul r1, r3, r9
    add r6, r8, r1
    ldr r0, =2
    str r0, [r6]
    ldr r4, =604
    add r4, sp, r4
    ldr r2, =19
    ldr r5, =4
    mul r7, r2, r5
    add r3, r4, r7
    ldr r9, =2
    str r9, [r3]
    ldr r1, =884
    add r1, sp, r1
    ldr r8, =0
    ldr r6, =4
    mul r0, r8, r6
    add r2, r1, r0
    ldr r5, =0
    str r5, [r2]
    ldr r7, =884
    add r7, sp, r7
    ldr r4, =1
    ldr r3, =4
    mul r9, r4, r3
    add r8, r7, r9
    ldr r6, =0
    str r6, [r8]
    ldr r0, =884
    add r0, sp, r0
    ldr r1, =2
    ldr r2, =4
    mul r5, r1, r2
    add r4, r0, r5
    ldr r3, =0
    str r3, [r4]
    ldr r9, =884
    add r9, sp, r9
    ldr r7, =3
    ldr r8, =4
    mul r6, r7, r8
    add r1, r9, r6
    ldr r2, =0
    str r2, [r1]
    ldr r5, =884
    add r5, sp, r5
    ldr r0, =4
    ldr r4, =4
    mul r3, r0, r4
    add r7, r5, r3
    ldr r8, =0
    str r8, [r7]
    ldr r6, =884
    add r6, sp, r6
    ldr r9, =5
    ldr r1, =4
    mul r2, r9, r1
    add r0, r6, r2
    ldr r4, =0
    str r4, [r0]
    ldr r3, =884
    add r3, sp, r3
    ldr r5, =6
    ldr r7, =4
    mul r8, r5, r7
    add r9, r3, r8
    ldr r1, =0
    str r1, [r9]
    ldr r2, =884
    add r2, sp, r2
    ldr r6, =7
    ldr r0, =4
    mul r4, r6, r0
    add r5, r2, r4
    ldr r7, =0
    str r7, [r5]
    ldr r8, =884
    add r8, sp, r8
    ldr r3, =8
    ldr r9, =4
    mul r1, r3, r9
    add r6, r8, r1
    ldr r0, =0
    str r0, [r6]
    ldr r4, =884
    add r4, sp, r4
    ldr r2, =9
    ldr r5, =4
    mul r7, r2, r5
    add r3, r4, r7
    ldr r9, =0
    str r9, [r3]
    ldr r1, =884
    add r1, sp, r1
    ldr r8, =10
    ldr r6, =4
    mul r0, r8, r6
    add r2, r1, r0
    ldr r5, =0
    str r5, [r2]
    ldr r7, =884
    add r7, sp, r7
    ldr r4, =11
    ldr r3, =4
    mul r9, r4, r3
    add r8, r7, r9
    ldr r6, =0
    str r6, [r8]
    ldr r0, =884
    add r0, sp, r0
    ldr r1, =12
    ldr r2, =4
    mul r5, r1, r2
    add r4, r0, r5
    ldr r3, =0
    str r3, [r4]
    ldr r9, =884
    add r9, sp, r9
    ldr r7, =13
    ldr r8, =4
    mul r6, r7, r8
    add r1, r9, r6
    ldr r2, =0
    str r2, [r1]
    ldr r5, =884
    add r5, sp, r5
    ldr r0, =14
    ldr r4, =4
    mul r3, r0, r4
    add r7, r5, r3
    ldr r8, =0
    str r8, [r7]
    ldr r6, =884
    add r6, sp, r6
    ldr r9, =15
    ldr r1, =4
    mul r2, r9, r1
    add r0, r6, r2
    ldr r4, =0
    str r4, [r0]
    ldr r3, =884
    add r3, sp, r3
    ldr r5, =16
    ldr r7, =4
    mul r8, r5, r7
    add r9, r3, r8
    ldr r1, =0
    str r1, [r9]
    ldr r2, =884
    add r2, sp, r2
    ldr r6, =17
    ldr r0, =4
    mul r4, r6, r0
    add r5, r2, r4
    ldr r7, =0
    str r7, [r5]
    ldr r8, =884
    add r8, sp, r8
    ldr r3, =18
    ldr r9, =4
    mul r1, r3, r9
    add r6, r8, r1
    ldr r0, =0
    str r0, [r6]
    ldr r4, =884
    add r4, sp, r4
    ldr r2, =19
    ldr r5, =4
    mul r7, r2, r5
    add r3, r4, r7
    ldr r9, =0
    str r9, [r3]
    ldr r1, =884
    add r1, sp, r1
    ldr r8, =20
    ldr r6, =4
    mul r0, r8, r6
    add r2, r1, r0
    ldr r5, =0
    str r5, [r2]
    ldr r7, =884
    add r7, sp, r7
    ldr r4, =21
    ldr r3, =4
    mul r9, r4, r3
    add r8, r7, r9
    ldr r6, =0
    str r6, [r8]
    ldr r0, =884
    add r0, sp, r0
    ldr r1, =22
    ldr r2, =4
    mul r5, r1, r2
    add r4, r0, r5
    ldr r3, =0
    str r3, [r4]
    ldr r9, =884
    add r9, sp, r9
    ldr r7, =23
    ldr r8, =4
    mul r6, r7, r8
    add r1, r9, r6
    ldr r2, =0
    str r2, [r1]
    ldr r5, =884
    add r5, sp, r5
    ldr r0, =24
    ldr r4, =4
    mul r3, r0, r4
    add r7, r5, r3
    ldr r8, =0
    str r8, [r7]
    ldr r6, =884
    add r6, sp, r6
    ldr r9, =25
    ldr r1, =4
    mul r2, r9, r1
    add r0, r6, r2
    ldr r4, =0
    str r4, [r0]
    ldr r3, =884
    add r3, sp, r3
    ldr r5, =26
    ldr r7, =4
    mul r8, r5, r7
    add r9, r3, r8
    ldr r1, =0
    str r1, [r9]
    ldr r2, =884
    add r2, sp, r2
    ldr r6, =27
    ldr r0, =4
    mul r4, r6, r0
    add r5, r2, r4
    ldr r7, =0
    str r7, [r5]
    ldr r8, =884
    add r8, sp, r8
    ldr r3, =28
    ldr r9, =4
    mul r1, r3, r9
    add r6, r8, r1
    ldr r0, =0
    str r0, [r6]
    ldr r4, =884
    add r4, sp, r4
    ldr r2, =29
    ldr r5, =4
    mul r7, r2, r5
    add r3, r4, r7
    ldr r9, =0
    str r9, [r3]
    ldr r1, =884
    add r1, sp, r1
    ldr r8, =30
    ldr r6, =4
    mul r0, r8, r6
    add r2, r1, r0
    ldr r5, =0
    str r5, [r2]
    ldr r7, =884
    add r7, sp, r7
    ldr r4, =31
    ldr r3, =4
    mul r9, r4, r3
    add r8, r7, r9
    ldr r6, =0
    str r6, [r8]
    ldr r0, =884
    add r0, sp, r0
    ldr r1, =32
    ldr r2, =4
    mul r5, r1, r2
    add r4, r0, r5
    ldr r3, =0
    str r3, [r4]
    ldr r9, =884
    add r9, sp, r9
    ldr r7, =33
    ldr r8, =4
    mul r6, r7, r8
    add r1, r9, r6
    ldr r2, =0
    str r2, [r1]
    ldr r5, =884
    add r5, sp, r5
    ldr r0, =34
    ldr r4, =4
    mul r3, r0, r4
    add r7, r5, r3
    ldr r8, =0
    str r8, [r7]
    ldr r6, =884
    add r6, sp, r6
    ldr r9, =35
    ldr r1, =4
    mul r2, r9, r1
    add r0, r6, r2
    ldr r4, =0
    str r4, [r0]
    ldr r3, =884
    add r3, sp, r3
    ldr r5, =36
    ldr r7, =4
    mul r8, r5, r7
    add r9, r3, r8
    ldr r1, =0
    str r1, [r9]
    ldr r2, =884
    add r2, sp, r2
    ldr r6, =37
    ldr r0, =4
    mul r4, r6, r0
    add r5, r2, r4
    ldr r7, =0
    str r7, [r5]
    ldr r8, =884
    add r8, sp, r8
    ldr r3, =38
    ldr r9, =4
    mul r1, r3, r9
    add r6, r8, r1
    ldr r0, =0
    str r0, [r6]
    ldr r4, =884
    add r4, sp, r4
    ldr r2, =39
    ldr r5, =4
    mul r7, r2, r5
    add r3, r4, r7
    ldr r9, =0
    str r9, [r3]
    Ldr r1, =0
    b bb0_0
bb0_0:
    b litpool0_0
    .pool
litpool0_0:
    ldr r8, =20
    cmp r1, r8
    ldr r6, =0
    ldrlt r6, =1
    ldr r0, =20
    cmp r1, r0
    blt bb0_1
    b bb0_2
bb0_1:
    add r0, r1, #0
    ldr r7, =684
    add r7, sp, r7
    ldr r8, =4
    mul r6, r0, r8
    add r5, r7, r6
    add r3, r1, #0
    ldr r4, =524
    add r4, sp, r4
    ldr r2, =4
    mul r9, r3, r2
    add r0, r4, r9
    ldr r8, [r0]
    str r8, [r5]
    add r7, r1, #1
    Mov r1, r7
    b bb0_0
bb0_2:
    Ldr r2, =0
    b bb0_3
bb0_3:
    ldr r5, =20
    cmp r2, r5
    ldr r7, =0
    ldrlt r7, =1
    ldr r4, =20
    cmp r2, r4
    blt bb0_4
    b bb0_5
bb0_4:
    add r6, r2, #0
    ldr r3, =784
    add r3, sp, r3
    ldr r5, =4
    mul r9, r6, r5
    add r4, r3, r9
    add r0, r2, #0
    ldr r8, =604
    add r8, sp, r8
    ldr r7, =4
    mul r6, r0, r7
    add r5, r8, r6
    ldr r3, [r5]
    str r3, [r4]
    add r9, r2, #1
    Mov r2, r9
    b bb0_3
bb0_5:
    ldr r3, =20
    add r9, r3, #20
    sub r8, r9, #1
    Ldr r0, =0
    b bb0_6
bb0_6:
    b litpool0_1
    .pool
litpool0_1:
    cmp r0, r8
    ldr r6, =0
    ldrle r6, =1
    cmp r0, r8
    ble bb0_7
    b bb0_8
bb0_7:
    add r7, r0, #0
    ldr r3, =884
    add r3, sp, r3
    ldr r6, =4
    mul r5, r7, r6
    add r9, r3, r5
    ldr r4, =0
    str r4, [r9]
    add r7, r0, #1
    Mov r0, r7
    b bb0_6
bb0_8:
    ldr r5, =20
    sub r7, r5, #1
    Mov r3, r8
    Ldr r4, =0
    Mov r5, r7
    Ldr r6, =0
    Ldr r9, =0
    b bb0_9
bb0_9:
    ldr r7, =-1
    str r0, [sp, #20]
    cmp r5, r7
    ldr r0, =0
    ldrgt r0, =1
    str r0, [sp, #1044]
    ldr r0, =-1
    str r0, [sp, #1170]
    ldr r0, [sp, #1170]
    cmp r5, r0
    ldr r0, [sp, #20]
    bgt bb0_10
    b bb0_11
bb0_10:
    add r6, r5, #0
    ldr r9, =784
    add r9, sp, r9
    ldr r7, =4
    str r0, [sp, #20]
    mul r0, r6, r7
    str r0, [sp, #1090]
    ldr r0, [sp, #1090]
    add r0, r9, r0
    str r0, [sp, #1094]
    ldr r0, [sp, #1094]
    ldr r6, [r0]
    ldr r7, =20
    sub r9, r7, #1
    ldr r0, [sp, #20]
    Mov r7, r4
    Mov r4, r9
    Mov r9, r3
    b bb0_12
bb0_11:
    ldr r7, =0
    add r9, r7, #0
    ldr r6, =884
    add r6, sp, r6
    ldr r7, =4
    str r0, [sp, #20]
    mul r0, r9, r7
    str r0, [sp, #1098]
    ldr r0, [sp, #1098]
    add r0, r6, r0
    str r0, [sp, #1102]
    ldr r0, [sp, #1102]
    ldr r9, [r0]
    ldr r7, =0
    cmp r9, r7
    ldr r6, =0
    ldrne r6, =1
    ldr r0, =0
    str r0, [sp, #1170]
    ldr r0, [sp, #1170]
    cmp r9, r0
    ldr r0, [sp, #20]
    bne bb0_18
    b bb0_19
bb0_12:
    ldr r3, =-1
    str r0, [sp, #20]
    cmp r4, r3
    ldr r0, =0
    ldrgt r0, =1
    str r0, [sp, #1045]
    ldr r0, =-1
    str r0, [sp, #1170]
    ldr r0, [sp, #1170]
    cmp r4, r0
    ldr r0, [sp, #20]
    bgt bb0_13
    b bb0_14
bb0_13:
    b litpool0_2
    .pool
litpool0_2:
    add r3, r9, #0
    ldr r7, =884
    add r7, sp, r7
    str r0, [sp, #20]
    ldr r0, =4
    str r0, [sp, #1170]
    ldr r0, [sp, #1170]
    mul r0, r3, r0
    str r0, [sp, #1106]
    ldr r0, [sp, #1106]
    add r0, r7, r0
    str r0, [sp, #1110]
    ldr r0, [sp, #1110]
    ldr r3, [r0]
    add r7, r4, #0
    ldr r0, =684
    add r0, sp, r0
    str r0, [sp, #1046]
    ldr r0, =4
    str r0, [sp, #1170]
    ldr r0, [sp, #1170]
    mul r0, r7, r0
    str r0, [sp, #1114]
    str r1, [sp, #24]
    ldr r0, [sp, #1046]
    ldr r1, [sp, #1114]
    add r0, r0, r1
    str r0, [sp, #1118]
    ldr r0, [sp, #1118]
    ldr r7, [r0]
    mul r0, r6, r7
    str r0, [sp, #1050]
    ldr r0, [sp, #1050]
    add r0, r3, r0
    str r0, [sp, #1054]
    ldr r7, =10
    ldr r0, [sp, #1054]
    cmp r0, r7
    ldr r3, =0
    ldrge r3, =1
    ldr r0, =10
    str r0, [sp, #1170]
    ldr r0, [sp, #1054]
    ldr r1, [sp, #1170]
    cmp r0, r1
    ldr r0, [sp, #20]
    ldr r1, [sp, #24]
    bge bb0_15
    b bb0_16
bb0_14:
    add r3, r9, #20
    str r0, [sp, #20]
    sub r0, r3, #1
    str r0, [sp, #1078]
    sub r0, r5, #1
    str r0, [sp, #1082]
    ldr r0, [sp, #20]
    ldr r3, [sp, #1078]
    ldr r5, [sp, #1082]
    Mov r9, r6
    Mov r6, r4
    Mov r4, r7
    b bb0_9
bb0_15:
    str r0, [sp, #20]
    add r0, r9, #0
    str r0, [sp, #1058]
    ldr r7, =884
    add r7, sp, r7
    ldr r3, =4
    ldr r0, [sp, #1058]
    mul r0, r0, r3
    str r0, [sp, #1122]
    ldr r0, [sp, #1122]
    add r0, r7, r0
    str r0, [sp, #1126]
    str r1, [sp, #24]
    ldr r0, [sp, #1054]
    ldr r1, [sp, #1126]
    str r0, [r1]
    sub r3, r9, #1
    add r7, r3, #0
    ldr r0, =884
    add r0, sp, r0
    str r0, [sp, #1062]
    ldr r3, =4
    mul r0, r7, r3
    str r0, [sp, #1130]
    ldr r0, [sp, #1062]
    ldr r1, [sp, #1130]
    add r0, r0, r1
    str r0, [sp, #1134]
    sub r7, r9, #1
    add r3, r7, #0
    ldr r0, =884
    add r0, sp, r0
    str r0, [sp, #1066]
    ldr r7, =4
    mul r0, r3, r7
    str r0, [sp, #1138]
    ldr r0, [sp, #1066]
    ldr r1, [sp, #1138]
    add r0, r0, r1
    str r0, [sp, #1142]
    ldr r0, [sp, #1142]
    ldr r3, [r0]
    ldr r7, =10
    ldr r0, [sp, #1054]
    sdiv r0, r0, r7
    str r0, [sp, #1070]
    ldr r0, [sp, #1070]
    add r0, r3, r0
    str r0, [sp, #1074]
    ldr r0, [sp, #1074]
    ldr r1, [sp, #1134]
    str r0, [r1]
    ldr r0, [sp, #20]
    ldr r1, [sp, #24]
    b bb0_17
bb0_16:
    add r7, r9, #0
    ldr r3, =884
    add r3, sp, r3
    str r0, [sp, #20]
    ldr r0, =4
    str r0, [sp, #1170]
    ldr r0, [sp, #1170]
    mul r0, r7, r0
    str r0, [sp, #1146]
    ldr r0, [sp, #1146]
    add r0, r3, r0
    str r0, [sp, #1150]
    str r1, [sp, #24]
    ldr r0, [sp, #1054]
    ldr r1, [sp, #1150]
    str r0, [r1]
    ldr r0, [sp, #20]
    ldr r1, [sp, #24]
    b bb0_17
bb0_17:
    b litpool0_3
    .pool
litpool0_3:
    sub r7, r4, #1
    sub r3, r9, #1
    Mov r4, r7
    ldr r7, [sp, #1054]
    Mov r9, r3
    b bb0_12
bb0_18:
    ldr r6, =0
    add r7, r6, #0
    ldr r9, =884
    add r9, sp, r9
    ldr r6, =4
    str r0, [sp, #20]
    mul r0, r7, r6
    str r0, [sp, #1154]
    ldr r0, [sp, #1154]
    add r0, r9, r0
    str r0, [sp, #1158]
    ldr r0, [sp, #1158]
    ldr r7, [r0]
    mov r0, r7
    bl put_int
    ldr r0, [sp, #20]
    b bb0_19
bb0_19:
    Ldr r7, =1
    b bb0_20
bb0_20:
    ldr r9, =20
    add r6, r9, #20
    str r0, [sp, #20]
    sub r0, r6, #1
    str r0, [sp, #1086]
    ldr r0, [sp, #1086]
    cmp r7, r0
    ldr r9, =0
    ldrle r9, =1
    ldr r0, [sp, #1086]
    cmp r7, r0
    ldr r0, [sp, #20]
    ble bb0_21
    b bb0_22
bb0_21:
    add r6, r7, #0
    ldr r9, =884
    add r9, sp, r9
    str r0, [sp, #20]
    ldr r0, =4
    str r0, [sp, #1170]
    ldr r0, [sp, #1170]
    mul r0, r6, r0
    str r0, [sp, #1162]
    ldr r0, [sp, #1162]
    add r0, r9, r0
    str r0, [sp, #1166]
    ldr r0, [sp, #1166]
    ldr r6, [r0]
    mov r0, r6
    bl put_int
    add r9, r7, #1
    ldr r0, [sp, #20]
    Mov r7, r9
    b bb0_20
bb0_22:
    b bb0_23
bb0_23:
    ldr r0, =0
    mov sp, r11
    pop {r4, r5, r6, r7, r8, r9, r11, lr}
    bx lr
    .pool

    .type ..len, %object
    .section .rodata,"a", %progbits
    .globl ..len
    .p2align 2
..len:
    .long 20
    .size ..len, 4

