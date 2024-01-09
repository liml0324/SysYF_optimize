#ifndef MHSJ_IR2ASM_H
#define MHSJ_IR2ASM_H

#include<RegAlloc.h>
#include<ValueGen.h>
#include<Instruction.h>
#include<Module.h>
#include<LIR.h>

namespace SysYF{
namespace IR{
namespace IR2asm{
    const std::string space = std::string(4, ' ');
    const std::string endl = "\n";


    // Ptr<RegAllocDriver> reg_alloc;
    // Ptr<Module> m_;
    // Ptr<Function> func_;

    enum CmpOp {
    EQ, // ==
    NE, // !=
    GT, // >
    GE, // >=
    LT, // <
    LE, // <=
    NOP
    };

    std::string ldr_const(Ptr<Reg> rd, Ptr<IR2asm::constant>val, std::string cmpop = "");
    std::string mov(Ptr<Reg> rd, Operand2 *opr2);
    std::string getelementptr(Ptr<Reg> rd, Ptr<Location> ptr);
    std::string ret();
    std::string ret(Ptr<Value> retval);
    std::string ret(Ptr<Location>addr);
    std::string beq(Ptr<Location>addr);
    std::string bne(Ptr<Location>addr);
    std::string bgt(Ptr<Location>addr);
    std::string bge(Ptr<Location>addr);
    std::string blt(Ptr<Location>addr);
    std::string ble(Ptr<Location>addr);
    std::string b(Ptr<Location> label);
    std::string br(Ptr<Location> label);
    std::string cmp(Ptr<Reg> rs, Operand2* opr2);
    std::string add(Ptr<Reg> rd, Ptr<Reg> rs, Operand2* opr2);
    std::string sub(Ptr<Reg> rd, Ptr<Reg> rs, Operand2* opr2);
    std::string r_sub(Ptr<Reg> rd, Ptr<Reg> rs, Operand2* opr2);
    std::string mul(Ptr<Reg> rd, Ptr<Reg> rs, Ptr<Reg> rt);
    std::string sdiv(Ptr<Reg> rd, Ptr<Reg> rs, Ptr<Reg> rt);
    std::string srem(Ptr<Reg> rd, Ptr<Reg> rs, Operand2* opr2);
    std::string load(Ptr<Reg> rd, Ptr<Location> addr, std::string cmpop = "");
    std::string safe_load(Ptr<Reg> rd, Ptr<Location> addr, int sp_extra_ofst, bool long_func, std::string cmpop = "");
    std::string store(Ptr<Reg> rs, Ptr<Location> addr, std::string cmpop = "");
    std::string safe_store(Ptr<Reg> rd, Ptr<Location> addr, int sp_extra_ofst, bool long_func, std::string cmpop = "");
    std::string call(Ptr<label> fun);
}
}
}
#endif