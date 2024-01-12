# 基于LLVM的SysYF进阶优化
[TOC]

## 实验选题

基于LLVM在若干方向对SysYF语言生成的LLVM中间代码进行优化，并进一步完成汇编代码的生成和优化。

## 实验设计

基于可行性和工作量的角度考虑，本实验在PW6中间代码生成和去年PW8的实验框架基础上进行，主要分为以下三个步骤：

- 1. 将去年的代码合并入PW6实验框架
- 2. 添加Pass类的派生类，实现对LLVM IR的各种优化
- 3. 实现Arm汇编代码的生成和优化

注：本实验使用的中间代码生成是第六次实验中李牧龙和徐翊然完成的版本，在其基础上做了一些修改（用PW8框架中的代码替换了一部分）。感谢徐翊然同学的付出。

## 组员分工

李牧龙：将去年框架的中间代码优化部分合并入PW6中，完成LLVM IR的优化。

徐航宇：将去年框架的后端部分合并入PW6中，完成Arm汇编代码的生成和优化。

## 贡献比

TODO

## 具体实现

### 合并实验框架

这一部分的工作主要是将代码文件加入文件目录，修改CMakeLists，并将去年代码中的裸指针改为智能指针，总体并不复杂。值得一提的是在此过程中发现了PW6代码框架的一点小问题：

- 1. 创建`PhiInst`时出现段错误：主要是`PhiInst`的`init`函数中未正确设置`parent_`成员变量所致。
- 2. `Value`类的`replace_all_use_with`方法未正确维护use链。

现在这两个问题均已修复。

### 中间代码优化

中间代码优化采用了Mem2Reg、常量折叠与传播、函数性质分析、局部公共子表达式消除、死代码删除、循环表达式外提这几种优化方式。其中Mem2Reg及其依赖的支配树算法是PW8框架中已有的优化，其余优化均在本次实验中完成。另外，为进行后端代码的寄存器分配，还完成了活跃变量分析。

#### Mem2Reg

TODO

#### 常量折叠与传播

常量折叠与传播，即将部分操作数全为常量的表达式在编译期间进行计算，并用计算结果直接替代该表达式的使用。尽管在IRBuilder中生成中间代码时，我们已经尽可能地将所有常量表达式直接计算为常量，但Mem2Reg优化后还是会产生大量的常量表达式。这为常量折叠与传播提供了可能。

这一部分的实现思路较为简单。对于操作数全为常量的计算表达式（如四则运算和取模，以及强制类型转换），直接计算出结果，创建相应的常数，并调用`replace_all_use_with`方法替换所有引用即可。

值得一提是对条件br语句的常量折叠。如果条件br语句引用的比较语句为常量表达式，那么可以直接确定br语句的跳转方向，可以将条件br换为无条件的跳转。但在这一替换后，另一个分支的基本块少了一个前驱基本块，可能需要对它的phi指令进行维护，相关代码如下：
```C++
for(auto &inst: del_bb->get_instructions()) {// 删除phi指令中对应前驱块的操作数
    if(!inst->is_phi()) {
        break;
    }
    auto phi = dynamic_pointer_cast<PhiInst>(inst);
    auto ops = phi->get_operands();
    for(int i = 0; i < ops.size(); i+=2) {
        auto op = ops[i];
        auto op_block = dynamic_pointer_cast<BasicBlock>(ops[i+1]);
        if(op_block != block) {
            continue;
        }
        if(phi->get_num_operand() == 4) {// 如果原本就只有两对操作数，那么直接用另一对中的Value替换即可
            Ptr<Value> new_op;
            if(i == 0) {
                new_op = phi->get_operand(2);
            }
            else {
                new_op = phi->get_operand(0);
            }
            phi->replace_all_use_with(new_op);
        }
        else {
            phi->remove_operands(i, i+1);
        }
        break;
    }
}
```

这一部分的完整代码在[ConstCalc.h](./include/Optimize/ConstCalc.h)和[ConstCalc.cpp](./src/Optimize/ConstCalc.cpp)中。

#### 函数性质分析

这一部分主要为分析函数是否为纯函数。

在SysYF语言中，我们将纯函数定义为：
- 1. 没有对全局变量的引用；
- 2. 没有对传入的数组参数赋值；
- 3. 如果有函数调用，则调用的函数必须是纯函数。

满足上面这些性质的函数，执行结果仅由传入的参数决定。这样的函数可以为优化带来很多方便。

分析函数的这种性质也非常简单。
- 首先，对于函数体为空的函数，我们认为是外部函数，稳妥起见视为非纯函数。
- 然后扫描函数的所有参数，如果有数组参数则记录下来。
- 最后扫描函数体中所有的指令。如果有引用全局变量的指令、调用非纯函数的函数调用指令或者对上面记录的数组参数进行赋值的语句，则该函数不是纯函数。
- 没有被上述过程记录为非纯函数的函数即为纯函数。

这一部分的完整代码见[FindPureFunc.h](./include/Optimize/FindPureFunc.h)和[FindPureFunc.cpp](./src/Optimize/FindPureFunc.cpp)。

#### 局部公共子表达式消除

在同一基本块内，如果有两个表达式完全相同，那么就可以去掉后面的表达式，将它的结果替换为前面的表达式的结果。这一优化只能对除`alloca`, `br`, `ret`, `store`, `load`以外的语句进行（因为这些表达式的效果不完全在于返回值，或者返回值不能完全由参数决定。

LLVM IR的静态单赋值特性为这一优化的实现带来了方便。因为每个变量只会被赋值一次，因此在一个基本块内，被引用的值不可能在两个引用它的指令之间被再次定值。因此我们可以只比较操作数是否是同一个对象。

比较表达式是否相同也很简单，只需要依次比较类型、操作数数量，每个操作数是否是同一对象即可。这里有两个例外情况：

其中一个是常数，因为在中间代码生成传入常数时，每一个常数都是新建的不同对象，尽管它们的值可能相同。因此比较操作数时，对常数需要特别处理，比较它们的值是否相同。比较操作数的核心代码如下：
```C++
bool compare_op(Ptr<Value> op1, Ptr<Value> op2) {
    if(op1->get_type()->get_type_id() != op2->get_type()->get_type_id()) {
        return false;
    }
    auto const_int1 = dynamic_pointer_cast<ConstantInt>(op1);
    auto const_int2 = dynamic_pointer_cast<ConstantInt>(op2);
    auto const_float1 = dynamic_pointer_cast<ConstantFloat>(op1);
    auto const_float2 = dynamic_pointer_cast<ConstantFloat>(op2);
    if(const_int1 && const_int2) {
        return const_int1->get_value() == const_int2->get_value();
    }
    else if(const_float1 && const_float2) {
        return const_float1->get_value() == const_float2->get_value();
    }
    else {
        return op1 == op2;
    }
}
```

另一个即为函数调用。如果两个表达式调用了相同的纯函数，且传入的参数相同，那么这两个表达式也是公共子表达式。

这一部分的完整代码见[LocalCSE.h](./include/Optimize/LocalCSE.h)和[LocalCSE.cpp](./src/Optimize/LocalCSE.cpp)。

#### 死代码删除

死代码删除即删除不会被执行/执行结果不会被使用的代码。我们将这一部分分为死指令删除和死基本块删除。

**死指令删除**：

死指令删除仅涉及除`br`, `ret`和`store`外的指令。如果一条指令的use链为空，那么这条指令被视为死指令，可以被删除。对于函数调用指令，则额外要求它调用的必须是纯函数。

这一部分的完整代码见[DCE.h](./include/Optimize/DCE.h)和[DCE.cpp](./src/Optimize/DCE.cpp)。

**死基本块删除**：

可以被删除的死基本块分为两类：一种是从entry开始dfs，没有被访问到的基本块；另一种是只有一个前驱和一个后继，且前驱也只有这一个后继，并且内部没有除`br`外的指令的基本块。

对于第一种情况，只需一遍dfs即可找出需要被删除的基本块，非常简单。关键在于像常量折叠中对`br`的处理一样，这一基本块的后继少了一个前驱，其中的`phi`指令可能需要维护。这一部分的代码与常量折叠中的处理类似，不再赘述。

第二种情况，只需对每个基本块检查它的前驱和后继即可。然而由于后继的前驱发生了变化，因此同样可能需要维护其中的`phi`指令。需要将涉及到的`phi`指令中被删除的基本块替换为它的前驱，这一部分的代码如下：
```C++
for(auto &inst: succ->get_instructions()) {// 后继的前驱发生了改变，需要更新phi
    if(!(inst->is_phi())) {
        break;
    }
    auto phi = std::dynamic_pointer_cast<PhiInst>(inst);
    auto ops = phi->get_operands();
    for(int i = 0; i < phi->get_operands().size(); i+=2) {
        auto op = ops[i];
        auto op_block = std::dynamic_pointer_cast<BasicBlock>(ops[i+1]);
        if(op_block != block) {
            continue;
        }
        phi->set_operand(i+1, prev);// 将block对应的操作数修改为它的前驱即可
        block->remove_use(phi);
    }
}
```

还需注意的是，在每一次删除基本块后，都需正确维护其它基本块的前驱和后继，否则可能毒害后续的基本块删除。

死基本块删除的完整代码见[DBE.h](./include/Optimize/DBE.h)和[DBE.cpp](./src/Optimize/DBE.cpp)。

#### 循环表达式外提

TODO

#### 活跃变量分析

TODO

### 后端代码生成与优化

TODO

## 评测结果

TODO