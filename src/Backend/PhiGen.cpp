#include<CodeGen.h>
#include<RegAlloc.h>
#include<queue>
#include<stack>
#include<algorithm>
#include<sstream>
#include<string>

namespace SysYF{
namespace IR{
    void spilt_str(const std::string& s, std::vector<std::string>& sv, const char delim = ' ') {
        sv.clear();
        std::istringstream iss(s);
        std::string temp;
        while (std::getline(iss, temp, delim)) {
            sv.emplace_back(std::move(temp));
        }
        return;
    }

    std::string CodeGen::phi_union(Ptr<BasicBlock> bb, Ptr<Instruction> br_inst){
        if(dynamic_pointer_cast<ReturnInst>(br_inst)){
            std::string code;
            accumulate_line_num += 1;
            if(accumulate_line_num > literal_pool_threshold){
                code += make_lit_pool();
                accumulate_line_num = 0;
            }
            return code + instr_gen(br_inst);
        }
        std::string cmp;
        std::string inst_cmpop;
        std::string succ_code;
        std::string fail_code;
        std::string succ_br;
        std::string fail_br;
        std::string* code = &succ_code;
        bool is_succ = true;
        bool is_cmpbr = false;
        Ptr<BasicBlock> succ_bb;
        Ptr<BasicBlock> fail_bb;

        std::vector<std::string> cmpbr_inst;
        std::string cmpbr_code = instr_gen(br_inst);
        std::string pop_code;
        pop_code += pop_tmp_instr_regs(br_inst);
        pop_code += tmp_reg_restore(br_inst);
        spilt_str(cmpbr_code, cmpbr_inst, IR2asm::endl[0]);
        PtrVec<IR2asm::Location> phi_target;
        PtrVec<IR2asm::Location> phi_src;

        if(br_inst->is_cmpbr()){
            is_cmpbr = true;
            auto cmpbr = dynamic_pointer_cast<CmpBrInst>(br_inst);
            succ_bb = dynamic_pointer_cast<BasicBlock>(cmpbr->get_operand(2));
            fail_bb = dynamic_pointer_cast<BasicBlock>(cmpbr->get_operand(3));
            cmp += cmpbr_inst[0] + IR2asm::endl;
            succ_br += cmpbr_inst[1] + IR2asm::endl;
            inst_cmpop += std::string(1, succ_br[5]);
            inst_cmpop.push_back(succ_br[6]); //bad for debugging
            fail_br += cmpbr_inst[2] + IR2asm::endl;
        }
        else if(br_inst->is_fcmpbr()){
            is_cmpbr = true;
            auto cmpbr = dynamic_pointer_cast<FCmpBrInst>(br_inst);
            succ_bb = dynamic_pointer_cast<BasicBlock>(cmpbr->get_operand(2));
            fail_bb = dynamic_pointer_cast<BasicBlock>(cmpbr->get_operand(3));
            cmp += cmpbr_inst[0] + IR2asm::endl;
            succ_br += cmpbr_inst[1] + IR2asm::endl;
            inst_cmpop += std::string(1, succ_br[5]);
            inst_cmpop.push_back(succ_br[6]); //bad for debugging
            fail_br += cmpbr_inst[2] + IR2asm::endl;
        }
        else{
            succ_bb = dynamic_pointer_cast<BasicBlock>(br_inst->get_operand(0));
            succ_br += cmpbr_inst[0] + IR2asm::endl;
        }
        std::string lit_pool;
        accumulate_line_num += 1 + count(pop_code.begin(), pop_code.end(), IR2asm::endl[0]);//for possible cmp and pop code
        if(accumulate_line_num > literal_pool_threshold){
            lit_pool += make_lit_pool();
            accumulate_line_num = 0;
        }
        for(auto sux:bb->get_succ_basic_blocks()){
            std::string cmpop;
            if(sux == succ_bb){
                code = &succ_code;
                cmpop = inst_cmpop;
            }
            else{
                code = &fail_code;
                cmpop = "";
            }
            //sux_bb_phi.clear();
            //opr2phi.clear();
            phi_src.clear();
            phi_target.clear();
            bool src_reg = false;
            bool src_stack = false;
            bool src_const = false;
            bool target_reg = false;
            bool target_stack = false;
            for(auto inst:sux->get_instructions()){
                if(inst->is_phi()){
                    // std::cout<<"phi:"<<inst->print()<<std::endl;
                    Ptr<Value> lst_val = nullptr;
                    int target_pos = reg_map[inst]->reg_num;
                    // std::cout<<"target_pos:"<<target_pos<<std::endl;
                    Ptr<IR2asm::Location> target_ptr = nullptr;
                    if(target_pos>=0){
                        target_ptr =Ptr<IR2asm::RegLoc>(new IR2asm::RegLoc(target_pos, false));
                    }else{
                        target_ptr = stack_map[inst];
                    }
                    for(auto opr:inst->get_operands()){
                        if(dynamic_pointer_cast<BasicBlock>(opr)){
                            auto this_bb = dynamic_pointer_cast<BasicBlock>(opr);
                            if(this_bb==bb){
                                if(target_pos>=0){
                                    target_reg = true;
                                }else{
                                    target_stack = true;
                                }
                                if(dynamic_pointer_cast<ConstantInt>(lst_val)){
                                    auto const_val = dynamic_pointer_cast<ConstantInt>(lst_val);
                                    auto src = Ptr<IR2asm::RegLoc>(new IR2asm::RegLoc(const_val->get_value(), true));
                                    src_const = true;
                                    phi_src.push_back(src);
                                    phi_target.push_back(target_ptr);
                                }else{
                                    int src_pos = reg_map[lst_val]->reg_num;
                                    if(src_pos>=0){
                                        if(src_pos!=target_pos){
                                            auto src = Ptr<IR2asm::RegLoc>(new IR2asm::RegLoc(src_pos, false));
                                            phi_src.push_back(src);
                                            phi_target.push_back(target_ptr);
                                            src_reg = true;
                                        }
                                    }else{
                                        auto src = stack_map[lst_val];
                                        phi_src.push_back(src);
                                        phi_target.push_back(target_ptr);
                                        src_stack = true;
                                    }
                                }
                            }
                        }else{
                            lst_val = opr;
                        }
                    }
                }else{
                    break;
                }
            }
            if(phi_src.empty()){
                continue;
            }
            //print src dst
            // std::cout<<"phi_union:"<<std::endl;
            // for(int i=0;i<phi_src.size();i++){
            //     std::cout<<phi_src[i]->get_code()<<"->"<<phi_target[i]->get_code()<<std::endl;
            // }
            // std::cout<<std::endl;
            *code += data_move(phi_src, phi_target, cmpop);
        }
        int accumulate_line_num_add = 0;
        accumulate_line_num_add += std::count(succ_br.begin(), succ_br.end(), IR2asm::endl[0]);
        accumulate_line_num_add += std::count(fail_br.begin(), fail_br.end(), IR2asm::endl[0]);
        std::string ret_code = cmp + pop_code + lit_pool + succ_code + succ_br + fail_code + fail_br;
        if(accumulate_line_num + accumulate_line_num_add > literal_pool_threshold){
            if(dynamic_pointer_cast<BranchInst>(bb->get_terminator()) && bb->get_terminator()->get_num_operand() == 1){
                ret_code += make_lit_pool(true);
            }
            else{
                ret_code += make_lit_pool();
            }
            accumulate_line_num = accumulate_line_num;
        }
        else{
            accumulate_line_num += accumulate_line_num;
        }
        return ret_code;
    }
}
}