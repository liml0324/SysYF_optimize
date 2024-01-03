#ifndef SYSYF_DOMINATETREE_H
#define SYSYF_DOMINATETREE_H

#include <list>
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
class DominateTree : public Pass{
public:
    explicit DominateTree(Ptr<Module> module): Pass(module){}
    void execute()final;
    void get_revserse_post_order(Ptr<Function> f);
    void get_post_order(Ptr<BasicBlock> bb,PtrSet<BasicBlock>& visited);
    void get_bb_idom(Ptr<Function> f);
    void get_bb_dom_front(Ptr<Function> f);
    Ptr<BasicBlock> intersect(Ptr<BasicBlock> b1, Ptr<BasicBlock> b2);
    const std::string get_name() const override {return name;}
private:
    PtrList<BasicBlock> reverse_post_order;
    std::map<Ptr<BasicBlock>,int> bb2int;
    PtrVec<BasicBlock> doms;
    const std::string name = "DominateTree";
};
}
}

#endif // SYSYF_DOMINATETREE_H
