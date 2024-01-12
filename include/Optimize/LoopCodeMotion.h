#include "Pass.h"
#include "Module.h"

namespace SysYF
{
namespace IR
{
class LoopCodeMotion : public Pass
{
public:
    LoopCodeMotion(Ptr<Module>module) : Pass(module) {}
    void execute() final;
    const std::string get_name() const override {return name_;}
private:
    const std::string name_ = "LoopCodeMotion";
    Ptr<Function> func_;
};
void find_movable_insts(Ptr<Loop> loop, PtrVec<Instruction> &movable_insts);
}
}