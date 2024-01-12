#include "ConstCalc.h"
#include <fstream>

#include <algorithm>

#define CONST_CALC_CMP true

namespace SysYF
{
namespace IR
{
void ConstCalc::execute() {
    for(auto &func : this->module->get_functions()) {
        if (func->get_basic_blocks().empty()) {
            continue;
        }
        for(auto &block : func->get_basic_blocks()) {
            for(auto &inst: block->get_instructions()) {
                int int_num;
                float float_num;
                if(inst->is_add() || inst->is_fadd()) {
                    auto op1 = inst->get_operand(0);
                    auto op2 = inst->get_operand(1);
                    if(dynamic_pointer_cast<ConstantInt>(op1) && dynamic_pointer_cast<ConstantInt>(op2)) {
                        int_num = dynamic_pointer_cast<ConstantInt>(op1)->get_value() + dynamic_pointer_cast<ConstantInt>(op2)->get_value();
                        auto new_const = ConstantInt::create(int_num, module);
                        inst->replace_all_use_with(new_const);
                        //block->delete_instr(inst);
                    }
                    else if(dynamic_pointer_cast<ConstantFloat>(op1) && dynamic_pointer_cast<ConstantFloat>(op2)) {
                        float_num = dynamic_pointer_cast<ConstantFloat>(op1)->get_value() + dynamic_pointer_cast<ConstantFloat>(op2)->get_value();
                        auto new_const = ConstantFloat::create(float_num, module);
                        inst->replace_all_use_with(new_const);
                        //block->delete_instr(inst);
                    }
                }
                else if(inst->is_sub() || inst->is_fsub()) {
                    auto op1 = inst->get_operand(0);
                    auto op2 = inst->get_operand(1);
                    if(dynamic_pointer_cast<ConstantInt>(op1) && dynamic_pointer_cast<ConstantInt>(op2)) {
                        int_num = dynamic_pointer_cast<ConstantInt>(op1)->get_value() - dynamic_pointer_cast<ConstantInt>(op2)->get_value();
                        auto new_const = ConstantInt::create(int_num, module);
                        inst->replace_all_use_with(new_const);
                        //block->delete_instr(inst);
                    }
                    else if(dynamic_pointer_cast<ConstantFloat>(op1) && dynamic_pointer_cast<ConstantFloat>(op2)) {
                        float_num = dynamic_pointer_cast<ConstantFloat>(op1)->get_value() - dynamic_pointer_cast<ConstantFloat>(op2)->get_value();
                        auto new_const = ConstantFloat::create(float_num, module);
                        inst->replace_all_use_with(new_const);
                        //block->delete_instr(inst);
                    }
                }
                else if(inst->is_mul() || inst->is_fmul()) {
                    auto op1 = inst->get_operand(0);
                    auto op2 = inst->get_operand(1);
                    if(dynamic_pointer_cast<ConstantInt>(op1) && dynamic_pointer_cast<ConstantInt>(op2)) {
                        int_num = dynamic_pointer_cast<ConstantInt>(op1)->get_value() * dynamic_pointer_cast<ConstantInt>(op2)->get_value();
                        auto new_const = ConstantInt::create(int_num, module);
                        inst->replace_all_use_with(new_const);
                        //block->delete_instr(inst);
                    }
                    else if(dynamic_pointer_cast<ConstantFloat>(op1) && dynamic_pointer_cast<ConstantFloat>(op2)) {
                        float_num = dynamic_pointer_cast<ConstantFloat>(op1)->get_value() * dynamic_pointer_cast<ConstantFloat>(op2)->get_value();
                        auto new_const = ConstantFloat::create(float_num, module);
                        inst->replace_all_use_with(new_const);
                        //block->delete_instr(inst);
                    }
                }
                else if(inst->is_rem()) {
                    auto op1 = inst->get_operand(0);
                    auto op2 = inst->get_operand(1);
                    if(dynamic_pointer_cast<ConstantInt>(op1) && dynamic_pointer_cast<ConstantInt>(op2)) {
                        int_num = dynamic_pointer_cast<ConstantInt>(op1)->get_value() % dynamic_pointer_cast<ConstantInt>(op2)->get_value();
                        auto new_const = ConstantInt::create(int_num, module);
                        inst->replace_all_use_with(new_const);
                        //block->delete_instr(inst);
                    }
                }
                else if(inst -> is_sitofp()) {
                    auto op1 = inst->get_operand(0);
                    if(dynamic_pointer_cast<ConstantInt>(op1)) {
                        float_num = (float)dynamic_pointer_cast<ConstantInt>(op1)->get_value();
                        auto new_const = ConstantFloat::create(float_num, module);
                        inst->replace_all_use_with(new_const);
                        //block->delete_instr(inst);
                    }
                }
                else if(inst -> is_fptosi()) {
                    auto op1 = inst->get_operand(0);
                    if(dynamic_pointer_cast<ConstantFloat>(op1)) {
                        int_num = dynamic_pointer_cast<ConstantFloat>(op1)->get_value();
                        auto new_const = ConstantInt::create(int_num, module);
                        inst->replace_all_use_with(new_const);
                        //block->delete_instr(inst);
                    }
                }
                else if(CONST_CALC_CMP && inst->is_cmp()) {
                    auto const_op1 = dynamic_pointer_cast<ConstantInt>(inst->get_operand(0));
                    auto const_op2 = dynamic_pointer_cast<ConstantInt>(inst->get_operand(1));
                    if(!const_op1 || !const_op2) {
                        continue;
                    }
                    auto cmp_inst = dynamic_pointer_cast<CmpInst>(inst);
                    auto cmp_op = cmp_inst->get_cmp_op();
                    bool is_true;
                    switch (cmp_op)
                    {
                    case CmpInst::CmpOp::EQ:
                        if(const_op1->get_value() == const_op2->get_value()) {
                            is_true = true;
                        }
                        else {
                            is_true = false;
                        }
                        break;
                    case CmpInst::CmpOp::NE:
                        if(const_op1->get_value() != const_op2->get_value()) {
                            is_true = true;
                        }
                        else {
                            is_true = false;
                        }
                        break;
                    case CmpInst::CmpOp::GT:
                        if(const_op1->get_value() > const_op2->get_value()) {
                            is_true = true;
                        }
                        else {
                            is_true = false;
                        }
                        break;
                    case CmpInst::CmpOp::GE:
                        if(const_op1->get_value() >= const_op2->get_value()) {
                            is_true = true;
                        }
                        else {
                            is_true = false;
                        }
                        break;
                    case CmpInst::CmpOp::LT:
                        if(const_op1->get_value() < const_op2->get_value()) {
                            is_true = true;
                        }
                        else {
                            is_true = false;
                        }
                        break;
                    case CmpInst::CmpOp::LE:
                        if(const_op1->get_value() <= const_op2->get_value()) {
                            is_true = true;
                        }
                        else {
                            is_true = false;
                        }
                        break;
                    default:
                        break;
                    }
                    auto use_list = cmp_inst->get_use_list();
                    for(auto use : use_list) {
                        auto br = dynamic_pointer_cast<BranchInst>(use.val_);
                        if(!br) {
                            continue;
                        }
                        auto block = br->get_parent();
                        if(block->get_terminator() != br) {
                            continue;
                        }
                        Ptr<BasicBlock> del_bb;
                        if(is_true) {
                            auto true_bb = dynamic_pointer_cast<BasicBlock>(br->get_operand(1));
                            auto false_bb = dynamic_pointer_cast<BasicBlock>(br->get_operand(2));
                            block->remove_succ_basic_block(true_bb);
                            true_bb->remove_pre_basic_block(block);
                            auto new_br = BranchInst::create_br(true_bb, block);
                            block->delete_instr(br);
                            new_br->set_parent(block);
                            block->remove_succ_basic_block(false_bb);
                            false_bb->remove_pre_basic_block(block);
                            del_bb = false_bb;
                        }
                        else {
                            auto true_bb = dynamic_pointer_cast<BasicBlock>(br->get_operand(1));
                            auto false_bb = dynamic_pointer_cast<BasicBlock>(br->get_operand(2));
                            block->remove_succ_basic_block(false_bb);
                            false_bb->remove_pre_basic_block(block);
                            auto new_br = BranchInst::create_br(false_bb, block);
                            block->delete_instr(br);
                            new_br->set_parent(block);
                            block->remove_succ_basic_block(true_bb);
                            true_bb->remove_pre_basic_block(block);
                            del_bb = true_bb;
                        }
                        for(auto &inst: del_bb->get_instructions()) {// 删除phi指令中对应前驱块的操作数
                            if(!inst->is_phi()) {
                                break;
                            }
                            auto phi = dynamic_pointer_cast<PhiInst>(inst);
                            auto ops = phi->get_operands();
                            for(int i = 0; i < ops.size(); i+=2) {
                                auto op = ops[i];
                                auto op_block = dynamic_pointer_cast<BasicBlock>(ops[i+1]);
                                if(op_block != block) {
                                    continue;
                                }
                                if(phi->get_num_operand() == 4) {// 如果原本就只有两对操作数，那么直接用另一对中的Value替换即可
                                    Ptr<Value> new_op;
                                    if(i == 0) {
                                        new_op = phi->get_operand(2);
                                    }
                                    else {
                                        new_op = phi->get_operand(0);
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
                else if(CONST_CALC_CMP && inst->is_fcmp()) {
                    auto const_op1 = dynamic_pointer_cast<ConstantFloat>(inst->get_operand(0));
                    auto const_op2 = dynamic_pointer_cast<ConstantFloat>(inst->get_operand(1));
                    if(!const_op1 || !const_op2) {
                        continue;
                    }
                    auto cmp_inst = dynamic_pointer_cast<CmpInst>(inst);
                    auto cmp_op = cmp_inst->get_cmp_op();
                    bool is_true;
                    switch (cmp_op)
                    {
                    case CmpInst::CmpOp::EQ:
                        if(const_op1->get_value() == const_op2->get_value()) {
                            is_true = true;
                        }
                        else {
                            is_true = false;
                        }
                        break;
                    case CmpInst::CmpOp::NE:
                        if(const_op1->get_value() != const_op2->get_value()) {
                            is_true = true;
                        }
                        else {
                            is_true = false;
                        }
                        break;
                    case CmpInst::CmpOp::GT:
                        if(const_op1->get_value() > const_op2->get_value()) {
                            is_true = true;
                        }
                        else {
                            is_true = false;
                        }
                        break;
                    case CmpInst::CmpOp::GE:
                        if(const_op1->get_value() >= const_op2->get_value()) {
                            is_true = true;
                        }
                        else {
                            is_true = false;
                        }
                        break;
                    case CmpInst::CmpOp::LT:
                        if(const_op1->get_value() < const_op2->get_value()) {
                            is_true = true;
                        }
                        else {
                            is_true = false;
                        }
                        break;
                    case CmpInst::CmpOp::LE:
                        if(const_op1->get_value() <= const_op2->get_value()) {
                            is_true = true;
                        }
                        else {
                            is_true = false;
                        }
                        break;
                    default:
                        break;
                    }
                    auto use_list = cmp_inst->get_use_list();
                    for(auto use : use_list) {
                        auto br = dynamic_pointer_cast<BranchInst>(use.val_);
                        if(!br) {
                            continue;
                        }
                        auto block = br->get_parent();
                        if(block->get_terminator() != br) {
                            continue;
                        }
                        Ptr<BasicBlock> del_bb;
                        if(is_true) {
                            auto true_bb = dynamic_pointer_cast<BasicBlock>(br->get_operand(1));
                            auto false_bb = dynamic_pointer_cast<BasicBlock>(br->get_operand(2));
                            block->remove_succ_basic_block(true_bb);
                            true_bb->remove_pre_basic_block(block);
                            auto new_br = BranchInst::create_br(true_bb, block);
                            block->delete_instr(br);
                            new_br->set_parent(block);
                            block->remove_succ_basic_block(false_bb);
                            false_bb->remove_pre_basic_block(block);
                            del_bb = false_bb;
                        }
                        else {
                            auto true_bb = dynamic_pointer_cast<BasicBlock>(br->get_operand(1));
                            auto false_bb = dynamic_pointer_cast<BasicBlock>(br->get_operand(2));
                            block->remove_succ_basic_block(false_bb);
                            false_bb->remove_pre_basic_block(block);
                            auto new_br = BranchInst::create_br(false_bb, block);
                            block->delete_instr(br);
                            new_br->set_parent(block);
                            block->remove_succ_basic_block(true_bb);
                            true_bb->remove_pre_basic_block(block);
                            del_bb = true_bb;
                        }
                        for(auto &inst: del_bb->get_instructions()) {
                            if(!inst->is_phi()) {
                                break;
                            }
                            auto phi = dynamic_pointer_cast<PhiInst>(inst);
                            auto ops = phi->get_operands();
                            for(int i = 0; i < ops.size(); i+=2) {
                                auto op = ops[i];
                                auto op_block = dynamic_pointer_cast<BasicBlock>(ops[i+1]);
                                if(op_block != block) {
                                    continue;
                                }
                                if(phi->get_num_operand() == 4) {
                                    Ptr<Value> new_op;
                                    if(i == 0) {
                                        new_op = phi->get_operand(2);
                                    }
                                    else {
                                        new_op = phi->get_operand(0);
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
            }
        }
    }
}
}
}