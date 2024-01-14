#include "FindPureFunc.h"
#include <algorithm>

namespace SysYF
{
namespace IR
{
void FindPureFunc::execute() {
    for(auto &func : this->module->get_functions()) {
        if(func->get_basic_blocks().empty()) {
            // 函数体是空的说明是外部函数，认为是不纯的
            func->set_pure(false);
            continue;
        }
        else {
            func_ = func;
        }
        auto args = func->get_args();
        PtrSet<Value> pointer_set;
        for(auto arg : args) {
            if(arg->get_type()->is_pointer_type()) {
                func->set_pure(false);
                break;
                // pointer_set.insert(arg);
            }
        }
        if(!func->is_pure()) {
            continue;
        }
        for(auto block : func->get_basic_blocks()) {
            for(auto inst : block->get_instructions()) {
                if(inst->is_call()) {
                    auto call_func = dynamic_pointer_cast<Function>(inst->get_operand(0));
                    if(call_func && call_func->is_pure()) {
                        ;
                    }
                    else {
                        func->set_pure(false);
                        break;
                    }
                }
                // else if(inst->is_store()) {
                //     auto gep = dynamic_pointer_cast<GetElementPtrInst>(inst->get_operand(1));
                //     if(gep) {
                //         auto base = gep->get_operand(0);
                //         if(pointer_set.find(base) != pointer_set.end()) {
                //             func->set_pure(false);
                //             break;
                //         }
                //     }
                // }
                for(auto op : inst->get_operands()) {
                    if(dynamic_pointer_cast<GlobalVariable>(op)) {
                        func->set_pure(false);
                        break;
                    }
                }
                if(!func->is_pure()) {
                    break;
                }
            }
            if(!func->is_pure()) {
                break;
            }
        }
    }

    // for(auto func : this->module->get_functions()) {
    //     if(func->is_pure()) {
    //         std::cout << func->get_name() << std::endl;
    //     }
    // }
}
}
}