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
    auto module = Module::create("if_gen");
    auto builder = IRStmtBuilder::create(nullptr, module);
    SysYF::Ptr<Type> Int32Type = Type::get_int32_type(module);
    auto zero_initializer = ConstantZero::create(Int32Type, module);
    auto a = GlobalVariable::create("a", module, Int32Type, false, zero_initializer);
    auto mainFun = Function::create(FunctionType::create(Int32Type, {}), "main", module);
    auto bb = BasicBlock::create(module, "entry", mainFun);
    builder->set_insert_point(bb);
    builder->create_alloca(Int32Type);
    std::cout << "begin phi" << std::endl;
    auto newphi = PhiInst::create_phi(Int32Type, bb);
    return 0;
}