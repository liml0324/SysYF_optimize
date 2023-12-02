@a = dso_local global i32 0, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
    store i32 10, i32* @a, align 4  ; a = 10
    %1 = load i32, i32* @a, align 4 ; load a
    %2 = icmp sgt i32 %1, 0         ; a > 0
    br i1 %2, label %3, label %4    ; if a > 0 goto 4 else goto 5
3:                                  ; label 4
    ret i32 %1                      ; return a
4:                                  ; label 5
    ret i32 0                       ; return 0
}