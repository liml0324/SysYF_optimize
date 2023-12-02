define i32 @add(i32 %arg0, i32 %arg1) {
label_entry:
  %op2 = alloca i32
  %op3 = add i32 %arg0, %arg1
  %op4 = sub i32 %op3, 1
  store i32 %op4, i32* %op2
  %op5 = load i32, i32* %op2
  ret i32 %op5
}
define i32 @main() {
label_entry:
  %op0 = alloca i32
  %op1 = alloca i32
  %op2 = alloca i32
  %op3 = alloca i32
  store i32 3, i32* %op1
  store i32 2, i32* %op2
  store i32 5, i32* %op3
  %op4 = load i32, i32* %op1
  %op5 = load i32, i32* %op2
  %op6 = load i32, i32* %op3
  %op7 = call i32 @add(i32 %op4, i32 %op5)
  %op8 = add i32 %op7, %op6
  store i32 %op8, i32* %op0
  %op9 = load i32, i32* %op0
  ret i32 %op9
}
