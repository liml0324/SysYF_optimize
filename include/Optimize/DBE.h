#include "Pass.h"
#include "Module.h"

namespace SysYF
{
namespace IR
{
class DBE : public Pass
{
public:
    DBE(Ptr<Module>module) : Pass(module) {}
    void execute() final;
    const std::string get_name() const override {return name;}
private:
    Ptr<Function> func_;
    const std::string name = "DBE";
};
void dfs(Ptr<BasicBlock> block, std::set<Ptr<BasicBlock>> &visited);
}
}