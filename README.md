# 编译原理大实验
## 项目介绍
本项目为编译原理大实验，在PW6和去年PW8的实验框架基础上进行SysYF语言LLVM IR的优化。

## 实验报告
[report.md](./report.md)

## 发现问题与解决
|问题|发现时间|原因|解决方式|解决时间|
|:---:|:---:|:---:|:---:|:---:|
|合并去年框架后出现段错误|**2024.1.3**|这一版框架中`PhiInst`的`init`函数中先调用了父类`Instruction`类的初始化函数，然后再设置parent。`Instruction`类的`init`函数在向`parent_`中插入指令时出现段错误。|修改了`Instruction.cpp`中`PhiInst`类的`init`函数|**2024.1.4**|
|`genPhi`函数运行后出现`undefined value used`问题|**2024.1.4**|推测是由于基本块不规范，一个基本块中存在多个br语句导致|||

## 优化效果
|版本号|添加的优化|IRBuild总时间(s)|ExeGen总时间|Exe运行总时间(s)|
|:---:|:---:|:---:|
|不开启-O2|无                   |-|-|-|
|ce0db9d|MemtoReg               |-|-|-|
|3b474fd|ActiveVar,ConstCalc,DCE|-|-|-|

## 计划采用的优化方式
原始IR --> Mem2Reg --> 常量表达式计算/常量传播 --> 复写传播 --> 活跃变量分析 --> 死代码删除

## 优化方式的实现

### Mem2Reg（已完成）
代码框架中已有，主要是将局部非数组变量的alloca和load、store指令改为寄存器指令。

### 常量表达式计算/常量传播（TODO）
进行完Mem2Reg后，会出现大量的常量表达式，如`add i32 1, 2`，这是因为许多原本由load操作取得的操作数被Mem2Reg优化为了对应的常量值。这些常量表达式可以直接计算出结果，然后该常量表达式的引用处替换为对应的常量值。

### 复写传播（TODO）
首先给出一个定义：如果一个函数中未使用全局变量，那么这个函数被称为“好函数”。
目前计划的复写传播是将同一基本块内重复计算的表达式/用相同的参数重复调用的好函数进行替换。
如：
```llvm
%op1 = add i32 1, 2
%op2 = add i32 1, 2
```
则所有引用`%op2`的地方都可以替换为`%op1`。
或者:
```llvm
%op1 = call i32 @func(i32 1, i32 2)
%op2 = call i32 @func(i32 1, i32 2)
```
则所有引用`%op2`的地方同样都可以替换为`%op1`。

### 活跃变量分析（已完成）
利用数据流方程，分析每个基本块出口和入口处的活跃变量，为死代码删除做准备。

### 死代码删除（TODO）
经过上面的几步优化之后，会出现相当多的死代码。在这里将死代码删除分为两步：死指令删除和死基本块删除。
**死指令删除：** 死指令删除仅涉及除`alloca`和`store`之外的指令。由于LLVM IR是静态单赋值的，因此如果一条指令定值的变量在它所在的基本块内没有被使用，并且在该基本块的出口处也不是活跃变量，那就可以被删除。
**死基本块删除：** 如果一个基本块内只有一个指向一个`label`的`br`指令，那么这个基本块就是死基本块。可以将它所有的前驱基本块中跳转到它的位置替换为跳转到它的后续基本块，然后将这个基本块删除。死基本块删除应该在死指令删除之后执行，可以从entry开始向后遍历所有基本块。