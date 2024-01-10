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
    if(a->is_alloca() || a->is_br() || a->is_call() || a->is_ret() || a->is_store() || a->is_load()) {
        return false;
    }

    for(int i = 0; i < a->get_num_operand(); i++) {
        auto op = a->get_operand(i);
        if(dynamic_pointer_cast<GlobalVariable>(op)) {
            return false;
        }
    }

    if(a->is_add() || a->is_fadd()) {
        if(a->get_operand(0) == b->get_operand(0) && a->get_operand(1) == b->get_operand(1)) {
            return true;
        }
        if(a->get_operand(0) == b->get_operand(1) && a->get_operand(1) == b->get_operand(0)) {
            return true;
        }
    }
    else if(a->is_mul() || a->is_fmul()) {
        if(a->get_operand(0) == b->get_operand(0) && a->get_operand(1) == b->get_operand(1)) {
            return true;
        }
        if(a->get_operand(0) == b->get_operand(1) && a->get_operand(1) == b->get_operand(0)) {
            return true;
        }
    }
    else {
        for(int i = 0; i < a->get_num_operand(); i++) {
            if(a->get_operand(i) != b->get_operand(i)) {
                return false;
            }
        }
        return true;
    }
}
}
}