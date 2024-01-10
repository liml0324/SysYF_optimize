#include "Pass.h"
#include "Module.h"

namespace SysYF
{
namespace IR
{
class AvailableExpr : public Pass
{
public:
    AvailableExpr(Ptr<Module>module) : Pass(module) {}
    void execute() final;
    const std::string get_name() const override {return name;}
    void dump();
private:
    Ptr<Function> func_;
    const std::string name = "AvailableExpr";
};
}
}