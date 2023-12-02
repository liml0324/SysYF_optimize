define i32 @main() {
label_entry:
  %op0 = alloca i32
  %op1 = alloca float
  store float 0x3ffcccccc0000000, float* %op1
  %op2 = alloca [2 x i32]
  %op3 = getelementptr [2 x i32], [2 x i32]* %op2, i32 0, i32 0
  store i32 2, i32* %op3
  %op4 = load i32, i32* %op3
  %op5 = sitofp i32 %op4 to float
  %op6 = load float, float* %op1
  %op7 = fmul float %op5, %op6
  %op8 = getelementptr [2 x i32], [2 x i32]* %op2, i32 0, i32 1
  %op9 = fptosi float %op7 to i32
  store i32 %op9, i32* %op8
  %op10 = load i32, i32* %op8
  store i32 %op10, i32* %op0
  %op11 = load i32, i32* %op0
  ret i32 %op11
}
