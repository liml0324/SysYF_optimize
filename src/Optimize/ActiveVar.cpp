#include "ActiveVar.h"
#include <fstream>

#include <algorithm>

namespace SysYF
{
namespace IR
{
void ActiveVar::execute() {
    //  请不要修改该代码。在被评测时不要在中间的代码中重新调用set_print_name
    module->set_print_name();
    //

    for (auto &func : this->module->get_functions()) {
        if (func->get_basic_blocks().empty()) {
            continue;
        } else {
            func_ = func;  
            
            /*you need to finish this function*/
        }
        
            
        // 由于phi指令的存在，需要记录每个变量可能的活跃性来源
        // 例如bb3中有%op6 = phi i32 [ %op1, %bb1 ], [ %op5, %bb2 ]
        // 那么IN[bb3]中有%op1和%op5，OUT[bb1]中只有%op1，OUT[bb2]中只有%op5
        std::map<Ptr<BasicBlock>, std::map<Ptr<Value>, PtrSet<BasicBlock>>> active_from;
        bool change = true;
        while(change) {
            change = false;
            PtrSet<Value> def_set;// 已经被定值的变量
            for(auto block: func_->get_basic_blocks()) {
                def_set.clear();// 清空
                PtrSet<Value> active_in_old;
                PtrSet<Value> active_out_old;
                active_in_old.insert(block->get_live_in().begin(), block->get_live_in().end());
                active_out_old.insert(block->get_live_out().begin(), block->get_live_out().end());
                // block->get_live_in().clear();
                // 计算IN[block]
                for(auto inst: block->get_instructions()) {
                    if(inst->is_phi()) {
                        auto phi_inst = std::dynamic_pointer_cast<PhiInst>(inst);
                        auto ops = phi_inst->get_operands();
                        for(int i = 0; i < ops.size(); i += 2) {
                            auto op = ops[i];
                            if ((   op->get_type()->is_array_type() || op->get_type()->is_integer_type() || op->get_type()->is_float_type() || op->get_type()->is_pointer_type()) \
                                    && !dynamic_pointer_cast<Constant>(op) && !dynamic_pointer_cast<GlobalVariable>(op)) {
                                auto op_block = std::dynamic_pointer_cast<BasicBlock>(ops[i + 1]);
                                active_from[block][op].insert(op_block);
                                block->get_live_in().insert(op);
                            }
                        }
                        def_set.insert(inst);
                    }
                    else {
                        for(auto op: inst->get_operands()) {
                            if(def_set.find(op) != def_set.end()) {
                                if(block->get_live_in().find(op) != block->get_live_in().end()) {
                                    block->get_live_in().erase(op);
                                }
                                continue;
                            }
                            if ((   op->get_type()->is_array_type() || op->get_type()->is_integer_type() || op->get_type()->is_float_type() || op->get_type()->is_pointer_type()) \
                                    && !dynamic_pointer_cast<Constant>(op) && !dynamic_pointer_cast<GlobalVariable>(op)) {// 只考虑局部变量
                                block->get_live_in().insert(op);
                                for(auto prev_block: block->get_pre_basic_blocks()) {
                                    active_from[block][op].insert(prev_block);
                                }
                            }
                        }
                        def_set.insert(inst);
                    }
                }
                for(auto out_var: block->get_live_out()) {
                    if(def_set.find(out_var) == def_set.end()) {
                        block->get_live_in().insert(out_var);
                    }
                    else {
                        if(block->get_live_in().find(out_var) != block->get_live_in().end()) {
                            block->get_live_in().erase(out_var);
                        }
                    }
                }
                // 计算OUT[block]
                active_out_old.insert(block->get_live_out().begin(), block->get_live_out().end());
                // block->get_live_out().clear();
                for(auto succ_block: block->get_succ_basic_blocks()) {
                    for(auto succ_live_in: succ_block->get_live_in()) {
                        if(active_from[succ_block][succ_live_in].find(block) != active_from[succ_block][succ_live_in].end()) {
                            block->get_live_out().insert(succ_live_in);
                            // 该变量未在block中被定值，那么需要将活跃性传递，以便block的前驱块可以使用
                            // 如：A->B->C，C中引用了%op1，但是B中并没有对%op1进行定值，而是在A中对%op1进行了定值
                            // 那么首先会算出IN[C]中有%op1，然后算出OUT[B]和IN[B]中有%op1
                            // 这时如果不将A加入到active_from[B][%op1]中，那么在计算OUT[A]时，就不会加入%op1
                            if(def_set.find(succ_live_in) == def_set.end()) {
                                for(auto prev_block: block->get_pre_basic_blocks()) {
                                    active_from[block][succ_live_in].insert(prev_block);
                                }
                            }
                        }
                    }
                }
                if(active_in_old != block->get_live_in() || active_out_old != block->get_live_out()) {
                    change = true;
                }
            }
        }
    }

    //  请不要修改该代码，在被评测时不要删除该代码
    dump();
    //
    return ;
}

void ActiveVar::dump() {
    std::fstream f;
    f.open(avdump, std::ios::out);
    for (auto &func: module->get_functions()) {
        for (auto &bb: func->get_basic_blocks()) {
            f << bb->get_name() << std::endl;
            auto &in = bb->get_live_in();
            auto &out = bb->get_live_out();
            auto sorted_in = sort_by_name(in);
            auto sorted_out = sort_by_name(out);
            f << "in:\n";
            for (auto in_v: sorted_in) {
                f << in_v->get_name() << " ";
            }
            f << "\n";
            f << "out:\n";
            for (auto out_v: sorted_out) {
                f << out_v->get_name() << " ";
            }
            f << "\n";
        }
    }
    f.close();
}

bool ValueCmp(Ptr<Value> a, Ptr<Value> b) {
    return a->get_name() < b->get_name();
}

PtrVec<Value> sort_by_name(PtrSet<Value> &val_set) {
    PtrVec<Value> result;
    result.assign(val_set.begin(), val_set.end());
    std::sort(result.begin(), result.end(), ValueCmp);
    return result;
}
}
}