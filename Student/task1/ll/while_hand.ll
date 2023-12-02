@a = dso_local global i32 0, align 4
@b = dso_local global i32 0, align 4
; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
    store i32 0, i32* @b, align 4       ; b = 0
    store i32 3, i32* @a, align 4       ; a = 3
    br label %1
1:
    %2 = load i32, i32* @a, align 4     ; a
    %3 = icmp sgt i32 %2, 0             ; a > 0
    br i1 %3, label %4, label %10
4:
    %5 = load i32, i32* @b, align 4     ; b
    %6 = load i32, i32* @a, align 4     ; a
    %7 = add nsw i32 %5, %6             ; b + a
    store i32 %7, i32* @b, align 4      ; b = b + a
    %8 = load i32, i32* @a, align 4     ; a
    %9 = sub nsw i32 %8, 1              ; a - 1
    store i32 %9, i32* @a, align 4      ; a = a - 1
    br label %1
10: 
    %11 = load i32, i32* @b, align 4    ; b
    ret i32 %11                         ; return b
}