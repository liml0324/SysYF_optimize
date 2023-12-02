#include "Module.h"

namespace SysYF
{
namespace IR
{
Module::Module(std::string name) 
    : module_name_(name)
{
    // init instr_id2string
    instr_id2string_.insert({ Instruction::ret, "ret" }); 
    instr_id2string_.insert({ Instruction::br, "br" }); 
    
    instr_id2string_.insert({ Instruction::add, "add" });
    instr_id2string_.insert({ Instruction::sub, "sub" });
    instr_id2string_.insert({ Instruction::mul, "mul" });
    instr_id2string_.insert({ Instruction::sdiv, "sdiv" });
    instr_id2string_.insert({ Instruction::srem, "srem" });

    instr_id2string_.insert({ Instruction::fadd, "fadd" });
    instr_id2string_.insert({ Instruction::fsub, "fsub" });
    instr_id2string_.insert({ Instruction::fmul, "fmul" });
    instr_id2string_.insert({ Instruction::fdiv, "fdiv" });

    instr_id2string_.insert({ Instruction::alloca, "alloca" });
    instr_id2string_.insert({ Instruction::load, "load" });
    instr_id2string_.insert({ Instruction::store, "store" });
    instr_id2string_.insert({ Instruction::cmp, "icmp" });
    instr_id2string_.insert({ Instruction::fcmp, "fcmp" });
    instr_id2string_.insert({ Instruction::phi, "phi" });
    instr_id2string_.insert({ Instruction::call, "call" });
    instr_id2string_.insert({ Instruction::getelementptr, "getelementptr" });
    instr_id2string_.insert({ Instruction::zext, "zext" });
    instr_id2string_.insert({ Instruction::fptosi, "fptosi" });
    instr_id2string_.insert({ Instruction::sitofp, "sitofp" });
}

void Module::init(std::string name) {
    void_ty_ = Type::create(Type::VoidTyID, shared_from_this());
    label_ty_ = Type::create(Type::LabelTyID, shared_from_this());
    int1_ty_ = IntegerType::create(1, shared_from_this());
    int32_ty_ = IntegerType::create(32, shared_from_this());
    float32_ty_ = FloatType::create(shared_from_this());
}

Ptr<Module> Module::create(std::string name) {
    RET_AFTER_INIT(Module, name);
}

Ptr<Type> Module::get_void_type()
{
    return void_ty_;
}

Ptr<Type> Module::get_label_type()
{
    return label_ty_;
}

Ptr<IntegerType> Module::get_int1_type()
{
    return int1_ty_;
}

Ptr<IntegerType> Module::get_int32_type()
{
    return int32_ty_;
}

Ptr<FloatType> Module::get_float_type()
{
    return float32_ty_;
}

Ptr<PointerType> Module::get_pointer_type(Ptr<Type> contained)
{
    if( pointer_map_.find(contained) == pointer_map_.end() )
    {
        pointer_map_[contained] = PointerType::create(contained);
    }
    return pointer_map_[contained];
}

Ptr<ArrayType> Module::get_array_type(Ptr<Type> contained, unsigned num_elements)
{
    if( array_map_.find({contained, num_elements}) == array_map_.end() )
    {
        array_map_[{contained, num_elements}] = ArrayType::create(contained, num_elements);
    }
    return array_map_[{contained, num_elements}];
}

Ptr<PointerType> Module::get_int32_ptr_type()
{
    return get_pointer_type(int32_ty_);
}

Ptr<PointerType> Module::get_float_ptr_type()
{
    return get_pointer_type(float32_ty_);
}

void Module::add_function(Ptr<Function> f)
{
    function_list_.push_back(f);
}
PtrList<Function> &Module::get_functions(){
    return function_list_;
}
void Module::add_global_variable(Ptr<GlobalVariable> g)
{
    global_list_.push_back(g);
}
PtrList<GlobalVariable> &Module::get_global_variable(){
    return global_list_;
}

void Module::set_print_name()
{
    for (auto func : this->get_functions())
    {
        func->set_instr_name();
    }
    return ;
}

std::string Module::print()
{
    std::string module_ir;
    for ( auto global_val : this->global_list_)
    {
        module_ir += global_val->print();
        module_ir += "\n";
    }
    for ( auto func : this->function_list_)
    {
        module_ir += func->print();
        module_ir += "\n";
    }
    return module_ir;
}

}
}