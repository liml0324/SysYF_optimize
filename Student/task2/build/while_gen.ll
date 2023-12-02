@a = global i32 zeroinitializer
@b = global i32 zeroinitializer
define i32 @main() {
label_entry:
  %op0 = alloca i32
  store i32 0, i32* @b
  store i32 3, i32* @a
  %op1 = load i32, i32* @a
  br label %label_cond
label_cond:                                                ; preds = %label_entry, %label_body
  %op2 = load i32, i32* @a
  %op3 = icmp sgt i32 %op2, 0
  br i1 %op3, label %label_body, label %label_end
label_body:                                                ; preds = %label_cond
  %op4 = load i32, i32* @a
  %op5 = load i32, i32* @b
  %op6 = add i32 %op5, %op4
  store i32 %op6, i32* @b
  %op7 = sub i32 %op4, 1
  store i32 %op7, i32* @a
  br label %label_cond
label_end:                                                ; preds = %label_cond
  %op8 = load i32, i32* @b
  store i32 %op8, i32* %op0
  %op9 = load i32, i32* %op0
  ret i32 %op9
}
