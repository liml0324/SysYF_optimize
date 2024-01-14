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
            PtrVec<Instruction> movable_insts;
            find_movable_insts(loop, movable_insts);
            if(movable_insts.empty()) {
                continue;
            }
            // else {
            //     std::cout << "find movable" << std::endl;
            // }
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
                auto new_bb = BasicBlock::create(module, "", func);
                auto new_br = BranchInst::create_br(loop_entry, new_bb);
                PtrVec<BasicBlock> preds(loop_entry->get_pre_basic_blocks().begin(), loop_entry->get_pre_basic_blocks().end());
                for(auto block : preds) {
                    if(loop->get_blocks().find(block) != loop->get_blocks().end()) {
                        continue;
                    }
                    auto br = block->get_terminator();
                    for(int i = 0; i < br->get_num_operand(); i++) {
                        if(br->get_operand(i) == loop_entry) {
                            br->set_operand(i, new_bb);
                            loop_entry->remove_use(br);
                        }
                    }
                    block->remove_succ_basic_block(loop_entry);
                    block->add_succ_basic_block(new_bb);
                    new_bb->add_pre_basic_block(block);
                    loop_entry->remove_pre_basic_block(block);
                }
                new_bb->add_instruction(new_br);
                loop_pre_bb = new_bb;
                PtrVec<Instruction> insts(loop_entry->get_instructions().begin(), loop_entry->get_instructions().end());
                for(auto inst : insts) {
                    if(!inst->is_phi()) {
                        break;
                    }
                    auto phi = std::dynamic_pointer_cast<PhiInst>(inst);
                    std::set<std::pair<Ptr<Value>, Ptr<BasicBlock>>> in_entry, in_pre;
                    for(int i = 0; i < phi->get_num_operand(); i+=2) {
                        auto op = phi->get_operand(i);
                        auto op_block = std::dynamic_pointer_cast<BasicBlock>(phi->get_operand(i+1));
                        if(loop->get_blocks().find(op_block) != loop->get_blocks().end()) {// 这一对操作数包含循环内的基本块，留在循环入口
                            in_entry.insert({op, op_block});
                        }
                        else {// 这一对操作数用到了循环外的基本块，应该被移到循环前的新基本块里
                            in_pre.insert({op, op_block});
                        }
                        if(in_entry.empty()) {// 没有用到循环内的基本块，直接移到pre中
                            loop_entry->delete_instr(phi);
                            loop_pre_bb->add_instr_begin(phi);
                        }
                        else if(in_pre.size()) {// 既有循环内的基本块，又有循环外的基本块
                            if(in_pre.size() == 1) {// 这种情况需要在entry里创建新的phi
                                auto new_phi = PhiInst::create_phi(phi->get_type(), loop_entry);
                                for(auto pair : in_entry)
                                    new_phi->add_phi_pair_operand(pair.first, pair.second);
                                new_phi->add_phi_pair_operand(in_pre.begin()->first, in_pre.begin()->second);
                                phi->replace_all_use_with(new_phi);
                                loop_entry->delete_instr(phi);
                                loop_entry->add_instr_begin(new_phi);
                            }
                            else {// 这种情况需要把原来的phi拆成2部分，一部分在entry里，一部分在pre里
                                auto pre_phi = PhiInst::create_phi(phi->get_type(), loop_pre_bb);
                                for(auto pair : in_pre) {
                                    pre_phi->add_phi_pair_operand(pair.first, pair.second);
                                }
                                loop_pre_bb->add_instr_begin(pre_phi);
                                auto entry_phi = PhiInst::create_phi(phi->get_type(), loop_entry);
                                for(auto pair : in_entry) {
                                    entry_phi->add_phi_pair_operand(pair.first, pair.second);
                                }
                                entry_phi->add_phi_pair_operand(pre_phi, loop_pre_bb);
                                phi->replace_all_use_with(entry_phi);
                                loop_entry->delete_instr(phi);
                                loop_entry->add_instr_begin(entry_phi);
                            }
                        }
                    }
                }
            }
            std::set<std::pair<Ptr<Instruction>, Ptr<BasicBlock>>> dels;
            for(auto inst : movable_insts) {
                // std::cout << inst->print() << std::endl;
                auto br = loop_pre_bb->get_terminator();
                auto block = inst->get_parent();
                block->delete_instr_without_remove_use(inst);
                auto term_pos = loop_pre_bb->find_instruction(br);
                loop_pre_bb->add_instruction(term_pos, inst);
                // dels.insert({inst, block});
                inst->set_parent(loop_pre_bb);
                // std::cout << loop_pre_bb->print() << std::endl;
            }
            // for(auto pair : dels) {
            //     pair.second->delete_instr(pair.first);
            // }
        }
    }
}
void find_movable_insts(Ptr<Loop> loop, PtrVec<Instruction> &movable_insts) {
    PtrSet<Instruction> defs;
    PtrSet<Instruction> movable_insts_set;
    for(auto block : loop->get_blocks()) {
        defs.insert(block->get_instructions().begin(), block->get_instructions().end());
    }
    for(auto block : loop->get_blocks()) {
        for(auto inst : block->get_instructions()) {
            if(inst->is_alloca() || inst->is_br() || inst->is_load() || inst->is_phi() || inst->is_store()) {
                continue;
            }
            bool movable = true;
            if(inst->is_call()) {
                auto call_func = std::dynamic_pointer_cast<Function>(inst->get_operand(0));
                if(!call_func || !call_func->is_pure()) {
                    movable = false;
                }
            }
            for(auto op : inst->get_operands()) {
                auto inst_ = dynamic_pointer_cast<Instruction>(op);
                auto gv = dynamic_pointer_cast<GlobalVariable>(op);
                if(inst_ && defs.find(inst_) != defs.end() && movable_insts_set.find(inst_) == movable_insts_set.end()) {
                    movable = false;
                    break;
                }
                else if(gv && !gv->is_const()) {
                    movable = false;
                    break;
                }
            }
            if(movable) {
                movable_insts.push_back(inst);
                movable_insts_set.insert(inst);
            }
        }
    }
}
}
}