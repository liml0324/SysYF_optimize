; ModuleID = 'func_test.sy'
source_filename = "func_test.sy"
; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @add(i32 %0, i32 %1) #0 {
    %3 = add nsw i32 %0, %1 ; a + b
    %4 = sub nsw i32 %3, 1  ; a + b - 1
    ret i32 %4
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
    %1 = alloca i32, align 4        ; alloc a
    %2 = alloca i32, align 4        ; alloc b
    %3 = alloca i32, align 4        ; alloc c
    store i32 3, i32* %1, align 4   ; a=3
    store i32 2, i32* %2, align 4   ; b=2
    store i32 5, i32* %3, align 4   ; c=5
    %4 = load i32, i32* %1, align 4  ; load a
    %5 = load i32, i32* %2, align 4  ; load b
    %6 = call i32 @add(i32 %4, i32 %5)  ; call add(a,b)
    %7 = load i32, i32* %3, align 4  ; load c
    %8 = add nsw i32 %7, %6         ; c + add(a,b)
    ret i32 %8
}