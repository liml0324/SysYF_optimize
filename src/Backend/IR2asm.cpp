#include<IR2asm.h>

namespace SysYF{
namespace IR{
namespace IR2asm{

std::string ldr_const(Ptr<Reg> rd, Ptr<IR2asm::constant>val, std::string cmpop) {
    std::string asmstr;
    asmstr += space;
    asmstr += "ldr" + cmpop + " ";
    asmstr += rd->get_code();
    asmstr += ", =";
    asmstr += val->get_num();
    asmstr += endl;
    return asmstr;
}

std::string mov(Ptr<Reg> rd, Operand2 *opr2) {
    std::string asmstr;
    asmstr += space;
    asmstr += "mov ";
    asmstr += rd->get_code();
    asmstr += ", ";
    asmstr += opr2->get_code();
    asmstr += endl;
    return asmstr;
}

std::string beq(Ptr<Location>addr) {
    std::string asmstr;
    asmstr += space;
    asmstr += "beq ";
    asmstr += addr->get_code();
    asmstr += endl;
    return asmstr;
}

std::string bne(Ptr<Location>addr) {
    std::string asmstr;
    asmstr += space;
    asmstr += "bne ";
    asmstr += addr->get_code();
    asmstr += endl;
    return asmstr;
}

std::string bgt(Ptr<Location>addr) {
    std::string asmstr;
    asmstr += space;
    asmstr += "bgt ";
    asmstr += addr->get_code();
    asmstr += endl;
    return asmstr;
}

std::string bge(Ptr<Location>addr) {
    std::string asmstr;
    asmstr += space;
    asmstr += "bge ";
    asmstr += addr->get_code();
    asmstr += endl;
    return asmstr;
}

std::string blt(Ptr<Location>addr) {
    std::string asmstr;
    asmstr += space;
    asmstr += "blt ";
    asmstr += addr->get_code();
    asmstr += endl;
    return asmstr;
}

std::string ble(Ptr<Location>addr) {
    std::string asmstr;
    asmstr += space;
    asmstr += "ble ";
    asmstr += addr->get_code();
    asmstr += endl;
    return asmstr;
}

std::string getelementptr(Ptr<Reg> rd, Ptr<Location> ptr){
    std::string asmstr;
    auto regbase = dynamic_pointer_cast<IR2asm::Regbase>(ptr);
    if(regbase){
        if (regbase->get_offset() >= (1<<8) || regbase->get_offset() < 0) {
            asmstr += ldr_const(rd, Ptr<IR2asm::constant>(new IR2asm::constant(regbase->get_offset())));
            asmstr += add(rd, Ptr<IR2asm::Reg>(&regbase->get_reg()), new Operand2(*rd));
        } else {
            asmstr += add(rd, Ptr<IR2asm::Reg>(&regbase->get_reg()), new Operand2(regbase->get_offset()));
        }
    }
    else{
        asmstr += space;
        asmstr += "ldr ";
        asmstr += rd->get_code();
        asmstr += ", ";
        auto labelexpr = dynamic_pointer_cast<label>(ptr);
        asmstr += "";
        asmstr += labelexpr->get_code();
        asmstr += endl;
    }
    return asmstr;
}

std::string call(Ptr<label> fun){
    std::string asmstr;
    asmstr += space;
    asmstr += "bl ";
    asmstr += fun->get_code();
    asmstr += endl;
    return asmstr;
}

std::string ret(Ptr<Location>addr){
    std::string asmstr;
    asmstr += space;
    asmstr += "ldr r0, ";
    asmstr += addr->get_code();
    asmstr += endl;
    // asmstr += space;
    // asmstr += "bx lr" + endl;
    return asmstr;
}

std::string ret(Ptr<Value> retval){
    auto const_retval = dynamic_pointer_cast<IR2asm::constant>(retval);
    std::string asmstr;
    asmstr += space;
    if (const_retval) {
        asmstr += "ldr r0, =";
        asmstr += const_retval->get_num();
    } else {
        asmstr += "mov r0, ";
        asmstr += retval->get_code();
    }
    asmstr += endl;
    // asmstr += space;
    // asmstr += "br lr" + endl;
    return asmstr;
}

std::string ret(){
    std::string asmstr;
    asmstr += space;//TODO:RET NULL STRING NEEDED
    asmstr += "bx lr" + endl;
    return asmstr;
}

std::string br(Ptr<Location> label) {
    return b(label);
}

std::string b(Ptr<Location>addr) {
    std::string asmstr;
    asmstr += space;
    asmstr += "b ";
    asmstr += addr->get_code();
    asmstr += endl;
    return asmstr;
}

std::string cmp(Ptr<Reg> rs, Operand2* opr2) {
    std::string asmstr;
    asmstr += space;
    asmstr += "cmp ";
    asmstr += rs->get_code();
    asmstr += ", ";
    asmstr += opr2->get_code();
    asmstr += endl;
    return asmstr;
}

std::string fcmp(Ptr<Reg> rs, Operand2* opr2) {
    std::string asmstr;
    asmstr += space;
    asmstr += "fcmp ";
    asmstr += rs->get_code();
    asmstr += ", ";
    asmstr += opr2->get_code();
    asmstr += endl;
    return asmstr;
}

std::string add(Ptr<Reg> rd, Ptr<Reg> rs, Operand2* opr2){
    std::string asmstr;
    asmstr += space;
    asmstr += "add ";
    asmstr += rd->get_code();
    asmstr += ", ";
    asmstr += rs->get_code();
    asmstr += ", ";
    asmstr += opr2->get_code();
    asmstr += endl;
    return asmstr;
}

std::string sub(Ptr<Reg> rd, Ptr<Reg> rs, Operand2* opr2){
    std::string asmstr;
    asmstr += space;
    asmstr += "sub ";
    asmstr += rd->get_code();
    asmstr += ", ";
    asmstr += rs->get_code();
    asmstr += ", ";
    asmstr += opr2->get_code();
    asmstr += endl;
    return asmstr;
}

std::string r_sub(Ptr<Reg> rd, Ptr<Reg> rs, Operand2* opr2){
    std::string asmstr;
    asmstr += space;
    asmstr += "rsb ";
    asmstr += rd->get_code();
    asmstr += ", ";
    asmstr += rs->get_code();
    asmstr += ", ";
    asmstr += opr2->get_code();
    asmstr += endl;
    return asmstr;
}

std::string mul(Ptr<Reg> rd, Ptr<Reg> rs, Ptr<Reg> rt){
    std::string asmstr;
    asmstr += space;
    asmstr += "mul ";
    asmstr += rd->get_code();
    asmstr += ", ";
    asmstr += rs->get_code();
    asmstr += ", ";
    asmstr += rt->get_code();
    asmstr += endl;
    return asmstr;
}

std::string sdiv(Ptr<Reg> rd, Ptr<Reg> rs, Ptr<Reg> rt){
    std::string asmstr;
    asmstr += space;
    asmstr += "sdiv ";
    asmstr += rd->get_code();
    asmstr += ", ";
    asmstr += rs->get_code();
    asmstr += ", ";
    asmstr += rt->get_code();
    asmstr += endl;
    return asmstr;
}

std::string srem(Ptr<Reg> rd, Ptr<Reg> rs, Operand2* opr2){
    std::string asmstr;
    asmstr += space;
    asmstr += "srem ";
    asmstr += rd->get_code();
    asmstr += ", ";
    asmstr += rs->get_code();
    asmstr += ", ";
    asmstr += opr2->get_code();
    asmstr += endl;
    return asmstr;
}

std::string load(Ptr<Reg> rd, Ptr<Location> addr, std::string cmpop){
    std::string asmstr;
    asmstr += space;
    asmstr += "ldr" + cmpop + " ";
    asmstr += rd->get_code();
    asmstr += ", ";
    asmstr += addr->get_code();
    asmstr += endl;
    return asmstr;
}

std::string safe_load(Ptr<Reg> rd, Ptr<Location> addr, int sp_extra_ofst, bool long_func, std::string cmpop){
    std::string asmstr;
    bool is_sp_based = false;
    if(dynamic_pointer_cast<IR2asm::Regbase>(addr)){
        Ptr<IR2asm::Regbase> regbase = dynamic_pointer_cast<IR2asm::Regbase>(addr);
        is_sp_based = (regbase->get_reg().get_id() == sp);
        int offset = regbase->get_offset() + ((is_sp_based)?sp_extra_ofst: 0);
        if(abs(offset) > 4095){
            asmstr += space;
            asmstr += "ldr lr, =";
            asmstr += std::to_string(offset);
            asmstr += endl;
            asmstr += space;
            asmstr += "add lr, lr, ";
            asmstr += regbase->get_reg().get_code();
            asmstr += endl;
            asmstr += load(rd, Ptr<IR2asm::Regbase>(new IR2asm::Regbase(Reg(lr), 0)), cmpop);
        }
        else{
            if(is_sp_based){
                Ptr<IR2asm::Regbase> new_regbase = Ptr<IR2asm::Regbase>(new IR2asm::Regbase(*regbase));
                new_regbase->set_offset(offset);
                asmstr += load(rd, new_regbase, cmpop);
            }
            else{
                asmstr += load(rd, addr, cmpop);
            }
        }
    }
    else{
        Ptr<label> labl = dynamic_pointer_cast<label>(addr);
        if(long_func || labl->get_offset()){
            asmstr += space;
            asmstr += "ldr lr, =";
            asmstr += labl->get_code();
            asmstr += endl;
            asmstr += load(rd,Ptr<IR2asm::Regbase>( new IR2asm::Regbase(Reg(lr), 0)), cmpop);
        }
        else{
            asmstr += load(rd, addr, cmpop);
        }
    }
    return asmstr;
}

std::string store(Ptr<Reg> rd, Ptr<Location> addr, std::string cmpop){
    std::string asmstr;
    asmstr += space;
    asmstr += "str" + cmpop + " ";
    asmstr += rd->get_code();
    asmstr += ", ";
    asmstr += addr->get_code();
    asmstr += endl;
    return asmstr;
}

std::string safe_store(Ptr<Reg> rd, Ptr<Location> addr, int sp_extra_ofst, bool long_func, std::string cmpop){
    std::string asmstr;
    bool is_sp_based = false;
    if(dynamic_pointer_cast<IR2asm::Regbase>(addr)){
        Ptr<IR2asm::Regbase> regbase = dynamic_pointer_cast<IR2asm::Regbase>(addr);
        is_sp_based = (regbase->get_reg().get_id() == sp);
        int offset = regbase->get_offset() + ((is_sp_based)?sp_extra_ofst: 0);
        if(abs(offset) > 4095){
            asmstr += space;
            asmstr += "ldr lr, =";
            asmstr += std::to_string(offset);
            asmstr += endl;
            asmstr += space;
            asmstr += "add lr, lr, ";
            asmstr += regbase->get_reg().get_code();
            asmstr += endl;
            asmstr += store(rd, Ptr<IR2asm::Regbase>(new IR2asm::Regbase(Reg(lr), 0)), cmpop);
        }
        else{
            if(is_sp_based){
                Ptr<IR2asm::Regbase> new_regbase = Ptr<IR2asm::Regbase>(new IR2asm::Regbase(*regbase));
                new_regbase->set_offset(offset);
                asmstr += store(rd, new_regbase, cmpop);
            }
            else{
                asmstr += store(rd, addr, cmpop);
            }
        }
    }
    else{
        Ptr<label> labl = dynamic_pointer_cast<label>(addr);
        if(long_func || labl->get_offset()){
            asmstr += space;
            asmstr += "ldr lr, =";
            asmstr += labl->get_code();
            asmstr += endl;
            asmstr += store(rd, Ptr<IR2asm::Regbase>(new IR2asm::Regbase(Reg(lr), 0)), cmpop);
        }
        else{
            asmstr += store(rd, addr, cmpop);
        }
    }
    return asmstr;
}
}
}
}
