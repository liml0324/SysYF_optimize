#ifndef _SYSYF_GLOBALVARIABLE_H_
#define _SYSYF_GLOBALVARIABLE_H_

#include "Module.h"
#include "User.h"
#include "Constant.h"

namespace SysYF
{
namespace IR
{
class GlobalVariable : public User
{
private:
    bool is_const_ ;
    Ptr<Constant> init_val_;
    explicit GlobalVariable(std::string name, Ptr<Module> m, Ptr<Type>  ty, bool is_const, Ptr<Constant> init_val = nullptr);
    void init(std::string name, Ptr<Module> m, Ptr<Type>  ty, bool is_const, Ptr<Constant> init_val = nullptr);

public:
    static Ptr<GlobalVariable> create(std::string name, Ptr<Module> m, Ptr<Type> ty, bool is_const, Ptr<Constant> init_val);

    Ptr<Constant> get_init() { return init_val_; }
    bool is_const() { return is_const_; }
    std::string print();
};

}
}

#endif //_SYSYF_GLOBALVARIABLE_H_
