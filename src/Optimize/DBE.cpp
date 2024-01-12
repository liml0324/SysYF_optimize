#include "DBE.h"
#include <fstream>

#include <algorithm>

namespace SysYF
{
namespace IR
{
void DBE::execute() {
    // 删除无用基本块
    for(auto &func : this->module->get_functions()) {
        if (func->get_basic_blocks().empty()) {
            continue;
        }
        PtrVec<BasicBlock> blocks(func->get_basic_blocks().begin(), func->get_basic_blocks().end());
        //为了方便分成两遍进行
        //第一遍删除永远不会被执行的基本块（即从entry开始dfs，无法到达的基本块）
        //第二遍删除只有一个前驱和一个后继，前驱也只有一个后继，且除了br外没有其他语句的基本块
        std::set<Ptr<BasicBlock>> visited;
        dfs(func->get_entry_block(), visited);
        std::set<Ptr<BasicBlock>> to_delete;
        for(auto &block : blocks) {
            if(visited.find(block) == visited.end()) {
                to_delete.insert(block);
            }
            else {
                continue;
            }
            for(auto succ : block->get_succ_basic_blocks()) {
                for(auto inst : succ->get_instructions()) {
                    if(!inst->is_phi()) {
                        break;
                    }
                    auto phi = std::dynamic_pointer_cast<PhiInst>(inst);
                    auto ops = phi->get_operands();
                    for(int i = 0; i < ops.size(); i+=2) {
                        auto op = ops[i];
                        auto op_block = std::dynamic_pointer_cast<BasicBlock>(ops[i+1]);
                        if(op_block != block) {
                            continue;
                        }
                        if(phi->get_num_operand() == 4) {
                            Ptr<Value> new_op;
                            if(i == 0) {
                                new_op = ops[2];
                            }
                            else {
                                new_op = ops[0];
                            }
                            phi->replace_all_use_with(new_op);
                        }
                        else {
                            phi->remove_operands(i, i+1);
                        }
                        break;
                    }
                }
            }
        }
        for(auto &block : to_delete) {
            func->remove(block);
        }
        //第二遍
        blocks.clear();
        blocks.insert(blocks.end(), func->get_basic_blocks().begin(), func->get_basic_blocks().end());
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

                        for(auto &inst: succ->get_instructions()) {// 后继的前驱发生了改变，需要更新phi
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
                                phi->set_operand(i+1, prev);// 将block对应的操作数修改为它的前驱即可
                                block->remove_use(phi);
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
void dfs(Ptr<BasicBlock> block, std::set<Ptr<BasicBlock>> &visited) {
    visited.insert(block);
    for(auto &succ: block->get_succ_basic_blocks()) {
        if(visited.find(succ) == visited.end()) {
            dfs(succ, visited);
        }
    }
}
}
}