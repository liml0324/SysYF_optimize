#ifndef SYSYF_RDOMINATETREE_H
#define SYSYF_RDOMINATETREE_H

#include <vector>
#include <memory>
#include <set>
#include <map>
#include "Pass.h"
#include "BasicBlock.h"
#include "Module.h"

namespace SysYF
{
namespace IR
{
class RDominateTree : public Pass{//reverse dominate tree
public:
    explicit RDominateTree(Ptr<Module> module): Pass(module){}
    void execute()final;
    void get_revserse_post_order(Ptr<Function> f);
    void get_post_order(Ptr<BasicBlock> bb,PtrSet<BasicBlock>& visited);
    void get_bb_irdom(Ptr<Function> f);
    void get_bb_rdoms(Ptr<Function> f);
    void get_bb_rdom_front(Ptr<Function> f);
    const std::string get_name() const override {return name;}
    Ptr<BasicBlock> intersect(Ptr<BasicBlock> b1, Ptr<BasicBlock> b2);
private:
    Ptr<BasicBlock> exit_block = nullptr;
    PtrList<BasicBlock> reverse_post_order;
    std::map<Ptr<BasicBlock>,int> bb2int;
    PtrVec<BasicBlock> rdoms;
    const std::string name = "RDominateTree";
};
}
}

#endif //SYSYF_RDOMINATETREE_H