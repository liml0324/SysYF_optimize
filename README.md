# 编译原理大实验
## 项目介绍
本项目为编译原理大实验，在PW6和去年PW8的实验框架基础上进行基于LLVM的SysYF语言进阶优化

## 实验报告
[report.md](./report.md)

## 编译方法
```bash 
mkdir build         # 创建build文件夹
cd build            # 进入build文件夹
cmake ..            # 生成Makefile
make                # 编译
```

## 运行方法
按上面步骤编译后会在build目录下生成`SysYFCompiler`，使用`/path/to/SysYFCompiler [options] <input-file>`命令即可运行。其中`[options]`为可选参数，`<input-file>`为输入文件路径。
`[options]`有如下几种：
- `-h`/`--help`：显示帮助信息
- `-emit-ast`：打印抽象语法树
- `-emit-ir`：打印LLVM IR
- `-S`：输出汇编代码。这里会默认开启Mem2Reg优化和活跃变量分析
- `-o <file>`：输出文件路径，没有的话会默认输出到命令行
- `-O0`：关闭优化
- `-O`/`-O1`：仅开启Mem2Reg优化
- `-O2`：开启全部优化
- `-av`：进行活跃变量分析，结果会输出到`active_var.out`文件中

main函数中有一些其他参数，是代码框架中自带的。我们并未特意对上面未提到的参数提供支持，不保证其正确性。

## 测试方法

### 中间代码生成
在`test`目录下运行`correctness.py`脚本测试正确性和运行时间。脚本中的`IR_Optimiazation`参数可调整中间代码优化等级，`time_detailed`参数可调整是否输出详细的时间信息，`TEST_DIRS`参数控制输入的测试文件路径。

### 后端代码生成
在`test`目录下运行`backend_build.py`脚本生成arm-v8汇编代码，然后将整个`test`目录复制到支持这一架构的机器上（如树莓派），将`arm_test.py`和`lib1.a`复制到`test`的上一级目录，运行`arm_test.py`脚本测试正确性。