#include "DCE.h"
#include <fstream>

#include <algorithm>

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
}
}
}