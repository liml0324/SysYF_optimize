#include "LoopCodeMotion.h"

namespace SysYF
{
namespace IR
{
void LoopCodeMotion::execute() {
    for(auto func : module->get_functions()) {
        if(func->get_basic_blocks().empty()) {
            continue;
        }
        else {
            func_ = func;
        }
        for(auto loop : func->get_loops()) {
            PtrSet<Instruction> defs;
            for(auto block : loop->get_blocks()) {
                defs.insert(block->get_instructions().begin(), block->get_instructions().end());
            }
            auto loop_entry = loop->get_loop_entry();
            Ptr<BasicBlock> loop_pre_bb = nullptr;
            for(auto pred : loop_entry->get_pre_basic_blocks()) {
                if(loop->get_blocks().find(pred) == loop->get_blocks().end()) {
                    if(!loop_pre_bb)
                        loop_pre_bb = pred;
                    else {
                        loop_pre_bb = nullptr;
                        std::cout << "loop has more than one pre basic block\n";
                        break;
                    }
                }
            }
            if(!loop_pre_bb) {
                continue;
            }
            std::set<std::pair<Ptr<Instruction>, Ptr<BasicBlock>>> dels;
            for(auto block : loop->get_blocks()) {
                for(auto inst : block->get_instructions()) {
                    if(inst->is_alloca() || inst->is_br() || inst->is_call() || inst->is_load() || inst->is_phi()) {
                        continue;
                    }
                    bool movable = true;
                    for(auto op : inst->get_operands()) {
                        auto inst_ = dynamic_pointer_cast<Instruction>(op);
                        if(!inst_)  continue;
                        if(defs.find(inst_) != defs.end()) {
                            movable = false;
                            break;
                        }
                    }
                    if(movable) {
                        auto br = loop_pre_bb->get_terminator();
                        loop_pre_bb->delete_instr(br);
                        loop_pre_bb->add_instruction(inst);
                        loop_pre_bb->add_instruction(br);
                        dels.insert({inst, block});
                        inst->set_parent(loop_pre_bb);
                    }
                }
            }
            for(auto pair : dels) {
                pair.second->delete_instr(pair.first);
            }
        }
    }
}
}
}