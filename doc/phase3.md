[TOC]

---

### 任务描述
**本关任务**：编写`IRBuilder.cpp`文件，实现低级中间代码生成器，为SysYF语言程序生成兼容的LLVM IR代码。

### 相关知识
#### 实验框架
本实训项目提供用C++语言编写的SysYF IR 应用编程库，用于构建 LLVM IR的子集。为了简化你的实验，本实训的实验框架代码已完成了SysYF源程序到 C++ 上的抽象语法树的转换。

##### Scope
在`IRBuilder.h`中，还定义了一个用于存储作用域的类`Scope`。它的作用是在遍历语法树时，辅助管理不同作用域中的变量。它提供了以下接口：
```cpp
// 进入一个新的作用域
void enter();
// 退出一个作用域
void exit();
// 往当前作用域插入新的名字->值映射
bool push(std::string name, Ptr<Value> val);
// 根据名字，以及是否为函数的bool值寻找到对应值
// isfunc 为 true 时为寻找函数，否则为寻找其他变量对应的值
Ptr<Value> find(std::string name, bool isfunc);
// 判断当前是否在全局作用域内
bool in_global();
```
你需要根据语义合理调用`enter`与`exit`，并且在变量声明和使用时正确调用`push`与`find`。在类`SysYFIRBuilder`中，有一个`Scope`类型的成员变量`scope`，它在初始化时已经将特殊函数加入了作用域中。因此，你在进行名字查找时不需要顾虑是否需要对特殊函数进行特殊操作。

##### shared_ptr
为了防止内存泄漏，助教将框架中的裸指针换成了智能指针，相关的类型定义在`include/internal_types`中，其中以下的类型转换方法：
```cpp
using std::static_pointer_cast;
using std::dynamic_pointer_cast;
using std::const_pointer_cast;
```
static_pointer_cast和dynamic_pointer_cast用于智能指针的类型转换，隐式完成了拆包、类型转换、重新包装和内存控制块维护，const_pointer_cast在转换时去除const属性，含义和使用方法类似于static_cast、dynamic_cast和const_cast：
```cpp
std::vector<std::shared_ptr<Duck>> ducks;
ducks.push_back(std::static_pointer_cast<Duck>(std::make_shared<EdibleDuck>()));
```

##### shared_from_this
这是助教在更新代码框架时涉及的部分，在实验中并不会用到，有兴趣的同学了解即可。由于改成了智能指针，我们在使用create方法创建IR中的Value对象时，需要在初始化的时候生成它的智能指针并返回，我们使用了`include/internal_macros.h`中的宏来定义使用了智能指针后新的初始化过程，先创建该对象的智能指针，然后对该智能指针调用init方法，而在init的过程中可能会用到它自身的智能指针，比如`src/SysYFIR\BasicBlock.cpp`中的`parent_->add_basic_block(dynamic_pointer_cast<BasicBlock>(shared_from_this()));`，这时需要用shared_from_this，原因参考[cpp smart pointer](https://www.cyhone.com/articles/right-way-to-use-cpp-smart-pointer/)。

当然，如果你企图直接使用构造函数而不用create方法的话，你会很惊讶地发现你做不到，因为助教已经很贴心地将构造函数设为private或者protected了，所以不用担心不小心的使用，而之所以不在构造函数中使用，原因参考[shared_from_this说明1](https://blog.csdn.net/weixin_38927079/article/details/115505724)和[shared_from_this说明2](https://blog.csdn.net/u012398613/article/details/52243764)

### 本关具体任务
1. 你需要在`src/SysYFIRBuilder`文件夹中，调用SysYF IR应用编程接口，填写`IRBuilder.cpp`文件，以实现 LLVM IR 的自动生成。注意以下几点：
   * a. 创建include/SysYFIR中的对象时，只能通过create方法，而不能直接使用构造函数(原因参考[shared_from_this](#shared_from_this))，如下：
      ```cpp
      auto fun = Function::create(fun_type, node.name, module);
      ```
      而不是：
      ```cpp
      auto fun = new Function(fun_type, node.name, module);
      ```
   * b. 尽量不要使用裸指针，而是使用shared_ptr和相关的类型转换方法，即`include/internal_types`定义的类型和方法
2. 在`report.md`内回答[思考题](#思考题)
3. 在`contribution.md`内由组长填写各组员的贡献比

### 编译、运行与验证

#### 编译运行 SysYFCompiler

```sh
mkdir build
cd build
cmake ..
make
```
请注意，你会发现CMakeLists.txt中的CMAKE_CXX_FLAGS多了很多参数，我们介绍其中一部分(参考[gcc warning options](https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html))：
   * -Wextra：打印一些额外的warning信息
   * -Wno-unused：不警告未使用的变量，框架中一些函数有一些不用的参数
   * -Wshadow：如果一个局部变量隐藏掉了其他的变量、参数等，报告warning
   * -Werror：将所有的warning都视为error，也就是说如果你觉得你的warning并不对程序正确性有影响，你可以把-Werror删除。

编译后会产生 `SysYFCompiler` 程序，它能将SysYF源程序（sy文件）输出为LLVM IR。  
当需要对 sy 文件测试时，可以这样使用：

```sh
SysYFCompiler test.sy -emit-ir -o test.ll
```
得到对应的ll文件。

#### 自动测试

本实训项目提供了自动评测脚本, 在`Student/task3/`目录下执行`python3 test.py`, 即可得到评测信息

### 思考题
请在`report/report.md`中详细回答下述思考题。

3-1. 在`scope`内单独处理`func`的好处有哪些。


### 选做

本实训项目提供了选做内容, 若你能完成选做部分, 将会有额外加分(仅针对本次实验的团队代码得分, 并且分数不能超过该部分得分上限)。

选做部分验收方式为线下验收，你需要在线下检查时提供对应代码通过助教给出的选做部分测试样例，并且讲解你的代码。

选做部分说明如下:（每个班只展示一部分）
   - H班:
      - 多维数组
   - 网安班:
      - 多维数组
      - 将一维数组指针作为参数
      - 逻辑运算(\&\&, \|\|, \!), 重点考察短路计算

#### 多维数组

目前给出的SysYF IR应用编程接口并不支持多维数组的实现，因此你需要修改接口，以实现多维数组的声明、初始化和使用，你可以修改的内容为文件夹`include/SysYFIR`，`include/SysYFIRBuilder`，`src/SysYFIR`，`src/SysYFIRBuilder`内的所有内容

多维数组在目前的接口基础上，一般有两种做法：  
- 直接实现，可以参考 clang 生成的 LLVM IR，修改当前接口使其支持多维的数组类型
- 展平，把高维数组当成一维数组存储，修改当前接口使其能保存一些必要信息

在初始化多维数组时，与一维数组不同的是，存在对齐问题，这里假设多维数组的初始化为完全对齐（在每个大括号处均对齐），以下两种初始化是等价的：  
`int a[5][2] = {1,{2,3},{4},{5,6,7}}`  
`int a[5][2] = {{1,0},{2,3},{4,0},{5,6},{7,0}}`  

#### 数组指针参数 & 逻辑运算

目前给出的SysYF IR接口支持数组指针参数和逻辑运算的短路计算，因此你不需要修改接口。  
注意`pointer`和`array`的区别以及文法中`&&`和`||`的优先级。

### 备注

测试样例除了位于版本库中的公开测例外,还包含不开放的隐藏测例。

平台上第三关的评测只判断公开测例是否完全通过, 第三关的分数由助教线下检查后，根据公开测例和隐藏测例的通过情况确定, 因此请自行设计合法测例测试你们的代码，确保你们的代码考虑了足够多情况以通过尽可能多的隐藏测例。

请将你编写的测例代码上传到`Student/task3/test_stu/`。
