#include "Constant.h"
#include "Module.h"
#include "internal_macros.h"
#include <iostream>
#include <sstream>
#include <string.h>

namespace SysYF
{
namespace IR
{
void ConstantInt::init(Ptr<Type> ty, int val)
{
    Constant::init(ty, "", 0);
}

Ptr<ConstantInt> ConstantInt::create(int val, Ptr<Module> m)
{
    RET_AFTER_INIT(ConstantInt, Type::get_int32_type(m), val);
}

Ptr<ConstantInt> ConstantInt::create(bool val, Ptr<Module> m)
{
    RET_AFTER_INIT(ConstantInt, Type::get_int1_type(m), val?1:0);
}

std::string ConstantInt::print()
{
    std::string const_ir;
    Ptr<Type> ty = this->get_type();
    if ( ty->is_integer_type() && static_pointer_cast<IntegerType>(ty)->get_num_bits() == 1 )
    {
        //int1
        const_ir += (this->get_value() == 0) ? "false" : "true";
    }
    else
    {
        //int32
        const_ir += std::to_string(this->get_value());
    }
    return const_ir;
}

void ConstantFloat::init(Ptr<Type> ty, float val)
{
    Constant::init(ty, "", 0);
}

Ptr<ConstantFloat> ConstantFloat::create(float val, Ptr<Module> m)
{
    RET_AFTER_INIT(ConstantFloat, Type::get_float_type(m), val);
}

std::string ConstantFloat::print()
{
    std::stringstream fp_ir_ss;
    std::string fp_ir;
    double val = this->get_value();
    uint64_t hex_val = 0;
    memcpy(&hex_val, &val, sizeof(double));
    fp_ir_ss << "0x"<< std::hex << hex_val << std::endl;
    fp_ir_ss >> fp_ir; 
    return fp_ir;
}

ConstantArray::ConstantArray(Ptr<ArrayType> ty, const PtrVec<Constant> &val)
    : Constant(ty, "", val.size()) 
{

}

void ConstantArray::init(Ptr<ArrayType> ty, const PtrVec<Constant> &val)
{
    Constant::init(ty, "", val.size());
    for (unsigned int i = 0; i < val.size(); i++)
        set_operand(i, val[i]);
    this->const_array.assign(val.begin(),val.end());
}

Ptr<Constant> ConstantArray::get_element_value(int index) {
    return this->const_array[index];
}

Ptr<ConstantArray> ConstantArray::create(Ptr<ArrayType> ty, const PtrVec<Constant> &val)
{
    RET_AFTER_INIT(ConstantArray, ty, val);
}

std::string ConstantArray::print()
{
    std::string const_ir;
    const_ir += "[";
    const_ir += this->get_type()->get_array_element_type()->print();
    const_ir += " ";
    const_ir += get_element_value(0)->print();
    for (unsigned int i = 1; i < this->get_size_of_array(); i++) {
        const_ir += ", ";
        const_ir += this->get_type()->get_array_element_type()->print();
        const_ir += " ";
        const_ir += get_element_value(i)->print();
    }
    const_ir += "]";
    return const_ir;
}

void ConstantZero::init(Ptr<Type> ty)
{
    Constant::init(ty, "", 0);
}

Ptr<ConstantZero> ConstantZero::create(Ptr<Type> ty, Ptr<Module> m) 
{
    RET_AFTER_INIT(ConstantZero, ty);
}

std::string ConstantZero::print()
{
    return "zeroinitializer";
}

}
}