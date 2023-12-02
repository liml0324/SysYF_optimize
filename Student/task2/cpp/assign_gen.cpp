#include "BasicBlock.h"
#include "Constant.h"
#include "Function.h"
#include "IRStmtBuilder.h"
#include "Module.h"
#include "Type.h"

#include <iostream>
#include <memory>

#ifdef DEBUG  // 用于调试信息,大家可以在编译过程中通过" -DDEBUG"来开启这一选项
#define DEBUG_OUTPUT std::cout << __LINE__ << std::endl;  // 输出行号的简单示例
#else
#define DEBUG_OUTPUT
#endif

#define CONST_INT(num) \
    ConstantInt::create(num, module)

#define CONST_FP(num) \
    ConstantFloat::create(num, module) // 得到常数值的表示,方便后面多次用到

using namespace SysYF::IR;
int main(){
    auto module = Module::create("assign_gen");
    auto builder = IRStmtBuilder::create(nullptr, module);
    SysYF::Ptr<Type> Int32Type = Type::get_int32_type(module);
    SysYF::Ptr<Type> FType = Type::get_float_type(module);
    //main函数
    auto mainFunTy = FunctionType::create(Int32Type, {});
    auto mainFun = Function::create(mainFunTy, "main", module);
    auto bb = BasicBlock::create(module, "entry", mainFun);
    builder->set_insert_point(bb);
    //float b = 1.8;
    auto retAlloca = builder->create_alloca(Int32Type);
    auto bAlloca = builder->create_alloca(FType);
    builder->create_store(CONST_FP(1.8), bAlloca);
    //int a[2];
    auto arrayType_a = ArrayType::get(Int32Type, 2);
    auto aAlloca = builder->create_alloca(arrayType_a);
    //a[0] = 2;
    auto a0Gep = builder->create_gep(aAlloca, {CONST_INT(0), CONST_INT(0)});
    builder->create_store(CONST_INT(2), a0Gep);
    //(float)a[0]
    auto a0Load = builder->create_load(a0Gep);
    auto a0Fp = builder->create_sitofp(a0Load, FType);
    //(float)a[0] * b
    auto bLoad = builder->create_load(bAlloca);
    auto mul = builder->create_fmul(a0Fp, bLoad);
    //a[1] = (int)(a[0] * b);
    auto a1Gep = builder->create_gep(aAlloca, {CONST_INT(0), CONST_INT(1)});
    auto a1Int = builder->create_fptosi(mul, Int32Type);
    builder->create_store(a1Int, a1Gep);
    //return a[1];
    auto a1Load = builder->create_load(a1Gep);
    builder->create_store(a1Load, retAlloca);
    builder->create_ret(builder->create_load(retAlloca));
    std::cout << module->print();
    return 0;
}
