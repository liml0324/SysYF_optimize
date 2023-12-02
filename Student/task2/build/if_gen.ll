@a = global i32 zeroinitializer
define i32 @main() {
label_entry:
  %op0 = alloca i32
  store i32 10, i32* @a
  %op1 = load i32, i32* @a
  %op2 = icmp sgt i32 %op1, 0
  br i1 %op2, label %label_true, label %label_false
label_true:                                                ; preds = %label_entry
  store i32 %op1, i32* %op0
  %op3 = load i32, i32* %op0
  ret i32 %op3
  br label %label_false
label_false:                                                ; preds = %label_entry, %label_true
  store i32 0, i32* %op0
  %op4 = load i32, i32* %op0
  ret i32 %op4
}
