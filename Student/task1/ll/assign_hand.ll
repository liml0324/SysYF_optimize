; ModuleID = 'assign_test.sy'
source_filename = "assign_test.sy"
; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
    %1 = alloca float, align 4  ;alloc b
    store float 0x3FFCCCCCC0000000, float* %1, align 4
    %2 = alloca [2 x i32], align 4  ;alloc a
    %3 = getelementptr inbounds [2 x i32], [2 x i32]* %2, i32 0, i32 0  ;*a[0]
    store i32 2, i32* %3, align 4  ;a[0] = 2
    %4 = getelementptr inbounds [2 x i32], [2 x i32]* %2, i32 0, i32 1  ;*a[1]
    store i32 2, i32* %4, align 4  ;a[1] = 2
    %5 = load i32, i32* %3, align 4     ;a[0]
    %6 = sitofp i32 %5 to float         ;(float)a[0]
    %7 = load float, float* %1, align 4 ;b
    %8 = fmul float %6, %7              ;a[0] * b
    %9 = getelementptr inbounds [2 x i32], [2 x i32]* %2, i32 0, i32 1  ;*a[1]
    %10 = fptosi float %8 to i32         ;(int)(a[0] * b)
    store i32 %10, i32* %9, align 4      ;a[1] = (int)(a[0] * b)
    ;TODO: return
    ret i32 %10
}