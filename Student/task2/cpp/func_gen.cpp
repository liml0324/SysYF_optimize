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
    auto module = Module::create("func_gen");
    auto builder = IRStmtBuilder::create(nullptr, module);
    SysYF::Ptr<Type> Int32Type = Type::get_int32_type(module);
    std::vector<SysYF::Ptr<Type>> Ints(2, Int32Type);
    auto addFunTy = FunctionType::create(Int32Type, Ints);
    auto addFun = Function::create(addFunTy, "add", module);
    auto bb = BasicBlock::create(module, "entry", addFun);
    builder->set_insert_point(bb);
    auto retAlloca = builder->create_alloca(Int32Type);
    std::vector<SysYF::Ptr<Value>> args;
    for (auto arg = addFun->arg_begin(); arg != addFun->arg_end(); arg++) {
        args.push_back(*arg);
    }
    auto add = builder->create_isub(builder->create_iadd(args[0], args[1]), CONST_INT(1));
    builder->create_store(add, retAlloca);
    builder->create_ret(builder->create_load(retAlloca));

    auto mainFunTy = FunctionType::create(Int32Type, {});
    auto mainFun = Function::create(mainFunTy, "main", module);
    bb = BasicBlock::create(module, "entry", mainFun);
    builder->set_insert_point(bb);
    auto retAlloca2 = builder->create_alloca(Int32Type);
    auto aAlloca = builder->create_alloca(Int32Type);
    auto bAlloca = builder->create_alloca(Int32Type);
    auto cAlloca = builder->create_alloca(Int32Type);
    builder->create_store(CONST_INT(3), aAlloca);
    builder->create_store(CONST_INT(2), bAlloca);
    builder->create_store(CONST_INT(5), cAlloca);
    auto aLoad = builder->create_load(aAlloca);
    auto bLoad = builder->create_load(bAlloca);
    auto cLoad = builder->create_load(cAlloca);
    auto add1 = builder->create_call(addFun, {aLoad, bLoad});
    auto add2 = builder->create_iadd(add1, cLoad);
    builder->create_store(add2, retAlloca2);
    builder->create_ret(builder->create_load(retAlloca2));
    std::cout << module->print();
    return 0;
}
