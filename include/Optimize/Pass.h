#ifndef SYSYF_PASS_H
#define SYSYF_PASS_H


#include <string>
#include <list>
#include "Module.h"
#include "Type.h"

namespace SysYF
{
namespace IR
{
class Pass{
public:
    explicit Pass(Ptr<Module> m){module = m;}
    virtual void execute() = 0;
    virtual const std::string get_name() const = 0;
protected:
    Ptr<Module> module;
};

template<typename T>
using PassList = PtrList<T>;

class PassMgr{
public:
    explicit PassMgr(Ptr<Module> m){module = m;pass_list = PassList<Pass>();}
    template <typename PassTy> void addPass(){pass_list.push_back(Ptr<PassTy>(new PassTy(module)));}
    void execute() {
        for (auto pass : pass_list) {
            pass->execute();
        }
    }
private:
    Ptr<Module> module;
    PassList<Pass> pass_list;
};
}
}


#endif // SYSYF_PASS_H