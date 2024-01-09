#ifndef SYSYF_MOVCONST_H
#define SYSYF_MOVCONST_H

#include "Module.h"
#include "Pass.h"

namespace SysYF{
namespace IR{
class MovConst : public Pass{
public:
    explicit MovConst(Ptr<Module> module):Pass(module){}
    void execute()override;
    const std::string get_name() const override{return name;}

private:
    static void mov_const(Ptr<BasicBlock> bb);
    const std::string name = "MovConst";
};
}
}
#endif //SYSYF_MOVCONST_H