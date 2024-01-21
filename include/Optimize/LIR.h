#ifndef SYSYF_LIR_H
#define SYSYF_LIR_H

#include "Module.h"
#include "Pass.h"
namespace SysYF{
namespace IR{
class LIR:public Pass
{
public:
    explicit LIR(Ptr<Module> module): Pass(module){}
    void execute() final;
    void merge_cmp_br(Ptr<BasicBlock> bb);
    void split_gep(Ptr<BasicBlock> bb);
    void split_srem(Ptr<BasicBlock> bb);
    const std::string get_name() const override {return name;}
private:
    std::string name = "LIR";
};
}
}
#endif // SYSYF_LIR_H