#include "Pass.h"
#include "Module.h"

namespace SysYF
{
namespace IR
{

class ConstCalc : public Pass
{
public:
    ConstCalc(Ptr<Module>module) : Pass(module) {}
    void execute() final;
    const std::string get_name() const override {return name;}
private:
    Ptr<Function> func_;
    const std::string name = "ConstCalc";
};
}
}