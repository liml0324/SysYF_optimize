#include "DCE.h"
#include <fstream>

#include <algorithm>
#define DCE_BLOCK true

namespace SysYF
{
namespace IR
{
void DCE::execute() {
    // 删除死指令
    for(auto &func : this->module->get_functions()) {
        if (func->get_basic_blocks().empty()) {
            continue;
        }
        for(auto &block : func->get_basic_blocks()) {
            PtrVec<Instruction> insts(block->get_instructions().begin(), block->get_instructions().end());
            for(auto inst: insts) {
                if(inst->is_br() || inst->is_ret() || inst->is_call() || inst->is_store()) {
                    continue;
                }
                bool used_in_block = false;
                for(auto &inst2: block->get_instructions()) {
                    for(auto op: inst2->get_operands()) {
                        if(op == inst) {
                            used_in_block = true;
                            break;
                        }
                    }
                }
                if(!used_in_block && block->get_live_out().find(inst) == block->get_live_out().end()) {
                    block->delete_instr(inst);
                }
            }
        }
    }

    if(!DCE_BLOCK) 
        return;
    // 删除无用基本块
    // 目前只能做最简单的删除
    // 好像没起到优化效果，随便吧
    for(auto &func : this->module->get_functions()) {
        if (func->get_basic_blocks().empty()) {
            continue;
        }
        PtrVec<BasicBlock> blocks(func->get_basic_blocks().begin(), func->get_basic_blocks().end());
        for(auto &block : blocks) {
            if(block->get_instructions().empty()) {
                func->remove(block);
            }
            if(block->get_num_of_instr() == 1) {
                auto terminator = block->get_terminator();
                if(!terminator) {
                    continue;
                }
                if(terminator->is_br()) {
                    auto br = std::dynamic_pointer_cast<BranchInst>(terminator);
                    if(block->get_succ_basic_blocks().size() == 1 && block->get_pre_basic_blocks().size() == 1) {
                        auto succ = *(block->get_succ_basic_blocks().begin());
                        auto prev = *(block->get_pre_basic_blocks().begin());
                        auto prev_terminator = prev->get_terminator();
                        if(prev_terminator->get_num_operand() > 1) {
                            continue;
                        }
                        for(auto &op: prev_terminator->get_operands()) {
                            if(op == block) {
                                op = succ;
                            }
                        }
                        prev->remove_succ_basic_block(block);
                        prev->add_succ_basic_block(succ);
                        succ->add_pre_basic_block(prev);

                        for(auto &inst: succ->get_instructions()) {
                            if(!(inst->is_phi())) {
                                break;
                            }
                            auto phi = std::dynamic_pointer_cast<PhiInst>(inst);
                            auto ops = phi->get_operands();
                            for(int i = 0; i < phi->get_operands().size(); i+=2) {
                                auto op = ops[i];
                                auto op_block = std::dynamic_pointer_cast<BasicBlock>(ops[i+1]);
                                if(op_block != block) {
                                    continue;
                                }
                                phi->set_operand(i+1, prev);
                            }
                        }
                        succ->remove_pre_basic_block(block);
                        func->remove(block);
                    }
                }
            }
        }
    }
}
}
}