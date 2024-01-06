#include "ConstCalc.h"
#include <fstream>

#include <algorithm>

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
            }
        }
    }
}
}
}