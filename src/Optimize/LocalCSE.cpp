#include "LocalCSE.h"
#include <fstream>

#include <algorithm>

namespace SysYF
{
namespace IR
{
void LocalCSE::execute() {
    for (auto &func : this->module->get_functions()) {
        if(func->get_basic_blocks().empty()) {
            continue;
        } else {
            func_ = func;
        }

        for(auto &block: func->get_basic_blocks()) {
            for(auto inst : block->get_instructions()) {
                for(auto inst1: block->get_instructions()) {
                    if(inst == inst1) {
                        break;
                    }
                    if(compare_inst(inst, inst1)) {
                        inst->replace_all_use_with(inst1);
                        break;
                    }
                }
            }
        }
    }
}

bool compare_inst(Ptr<Instruction> a, Ptr<Instruction> b) {
    if(a->get_instr_type() != b->get_instr_type() || a->get_num_operand() != b->get_num_operand()) {
        return false;
    }
    if(a->is_alloca() || a->is_br() || a->is_ret() || a->is_store() || a->is_load()) {
        return false;
    }

    for(int i = 0; i < a->get_num_operand(); i++) {
        auto op = a->get_operand(i);
        if(dynamic_pointer_cast<GlobalVariable>(op)) {
            return false;
        }
    }

    if(a->is_add() || a->is_fadd()) {
        if(compare_op(a->get_operand(0), b->get_operand(0)) && compare_op(a->get_operand(1), b->get_operand(1))) {
            return true;
        }
        if(compare_op(a->get_operand(0), b->get_operand(1)) && compare_op(a->get_operand(1), b->get_operand(0))) {
            return true;
        }
    }
    else if(a->is_mul() || a->is_fmul()) {
        if(compare_op(a->get_operand(0), b->get_operand(0)) && compare_op(a->get_operand(1), b->get_operand(1))) {
            return true;
        }
        if(compare_op(a->get_operand(0), b->get_operand(1)) && compare_op(a->get_operand(1), b->get_operand(0))) {
            return true;
        }
    }
    else if(a->is_call()) {
        auto func = dynamic_pointer_cast<Function>(a->get_operand(0));
        if(!func || !func->is_pure()) {
            return false;
        }
        for(int i = 0; i < a->get_num_operand(); i++) {
            if(!compare_op(a->get_operand(i), b->get_operand(i))) {
                return false;
            }
        }
        return true;
    }
    else {
        for(int i = 0; i < a->get_num_operand(); i++) {
            if(!compare_op(a->get_operand(i), b->get_operand(i))) {
                return false;
            }
        }
        return true;
    }
}
bool compare_op(Ptr<Value> op1, Ptr<Value> op2) {
    if(op1->get_type()->get_type_id() != op2->get_type()->get_type_id()) {
        return false;
    }
    auto const_int1 = dynamic_pointer_cast<ConstantInt>(op1);
    auto const_int2 = dynamic_pointer_cast<ConstantInt>(op2);
    auto const_float1 = dynamic_pointer_cast<ConstantFloat>(op1);
    auto const_float2 = dynamic_pointer_cast<ConstantFloat>(op2);
    if(const_int1 && const_int2) {
        return const_int1->get_value() == const_int2->get_value();
    }
    else if(const_float1 && const_float2) {
        return const_float1->get_value() == const_float2->get_value();
    }
    else {
        return op1 == op2;
    }
}
}
}