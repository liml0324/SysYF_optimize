#include "Pass.h"
#include "Module.h"

namespace SysYF
{
namespace IR
{
class FindLoop : public Pass
{
public:
    FindLoop(Ptr<Module>module) : Pass(module) {num_=0;}
    void execute() final;
    const std::string get_name() const override {return name_;}
    void dump();
    std::vector<std::pair<Ptr<BasicBlock>, Ptr<BasicBlock>>> &get_back_edges();
    void add_back_edge(Ptr<BasicBlock> from, Ptr<BasicBlock> to);
    void set_back_edges(std::vector<std::pair<Ptr<BasicBlock>, Ptr<BasicBlock>>> &back_edges) { back_edges_ = back_edges; }
private:
    void dfs(Ptr<BasicBlock> block);
    void reverse_dfs(Ptr<BasicBlock> block, Ptr<Loop> &loop);
    PtrSet<BasicBlock> visited_;
    Ptr<Function> func_;
    const std::string name_ = "FindLoop";
    std::vector<std::pair<Ptr<BasicBlock>, Ptr<BasicBlock>>> back_edges_;
    int num_;
};
const std::string fldump = "find_loop.out";
void find_inner_loop(Ptr<Function> func);
void get_loop_entry(Ptr<Function> func);
void merge_loop(Ptr<Function> func);
}
}