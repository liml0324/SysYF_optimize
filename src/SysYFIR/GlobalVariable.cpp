#include "GlobalVariable.h"
#include "IRPrinter.h"

namespace SysYF
{
namespace IR
{
GlobalVariable::GlobalVariable(std::string name, Ptr<Module> m, Ptr<Type> ty, bool is_const, Ptr<Constant> init_val)
    : User(ty, name, init_val != nullptr), is_const_(is_const), init_val_(init_val) 
{
    
}

void GlobalVariable::init(std::string name, Ptr<Module> m, Ptr<Type> ty, bool is_const, Ptr<Constant> init_val)
{
    m->add_global_variable(dynamic_pointer_cast<GlobalVariable>(shared_from_this()));
    if (init_val) {
        this->set_operand(0, init_val);
    }
}//global操作数为initval

Ptr<GlobalVariable> GlobalVariable::create(std::string name, Ptr<Module> m, Ptr<Type> ty, bool is_const, Ptr<Constant> init_val)
{
    
    RET_AFTER_INIT(GlobalVariable, name, m, PointerType::get(ty), is_const, init_val)
}

std::string GlobalVariable::print()
{
    std::string global_val_ir;
    global_val_ir += print_as_op(shared_from_this(), false);
    global_val_ir += " = ";
    global_val_ir += (this->is_const() ? "constant " : "global ");
    global_val_ir += this->get_type()->get_pointer_element_type()->print();
    global_val_ir += " ";
    global_val_ir += this->get_init()->print();
    return global_val_ir;
}

}
}