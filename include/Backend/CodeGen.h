#ifndef MHSJ_CODEGEN_H
#define MHSJ_CODEGEN_H

#include<Module.h>
#include<IR2asm.h>
#include<Value.h>
#include<Instruction.h>
#include<RegAlloc.h>
namespace SysYF{
namespace IR{

class CodeGen{
    const int int_align = 4;
    const int int_size = 4;
    const int int_p2align = 2;
    const int reg_size = 4;
    const int max_func_reg = 3;

    std::map<Ptr<Value>, Ptr<IR2asm::Regbase>> stack_map;
    PtrVec<IR2asm::Regbase> arg_on_stack;
    std::map<Ptr<GlobalVariable>, Ptr<IR2asm::label>> global_variable_table;
    std::map<Ptr<Function>, PtrSet<GlobalVariable>> global_variable_use;
    std::pair<std::set<int>, std::set<int>> used_reg;
    // std::map<int, std::vector<Ptr<Value>>> reg2value;
    std::map<Ptr<Value>, Ptr<Interval>> reg_map;//当前函数的寄存器分配方案
    std::map<Ptr<IR2asm::Location>,PtrVec<IR2asm::Location>> depend_graph;
    int func_no = 0;
    int bb_no = 0;
    int label_no = 0;
    int max_arg_size = 0;
    int pool_number = 0;
    int accumulate_line_num = 0;
    int temp_reg_store_num = 4;
    const std::set<int> all_free_tmp_pos = {0,1,2,3};//TODO:TOGETHER WITH temp_reg_store_num;
    int caller_saved_reg_num = 5;
    int literal_pool_threshold = 950;
    PtrVec<BasicBlock> linear_bb;
    std::map<Ptr<BasicBlock>, Ptr<IR2asm::label>> bb_label;
    bool have_func_call = true;
    bool long_func = false;
    bool have_temp_reg = true;
    std::map<int, std::vector<Ptr<Value>>> reg2val;
    std::vector<int> to_save_reg;
    int sp_extra_ofst = 0;
    int func_param_extra_offset = 0;
    std::map<int,int> caller_saved_pos;
    std::vector<int> store_list;
    PtrSet<Value> to_store_set;
    PtrSet<Interval> interval_set;
    std::set<int> free_tmp_pos = {0,1,2,3};//FIXME:4 TMP REG
    std::set<int> cur_tmp_regs;
    std::map<int, Ptr<IR2asm::Regbase>> tmp_regs_loc;
public:
    std::string tmp_reg_restore(Ptr<Instruction> inst);
    std::string ld_tmp_regs(Ptr<Instruction> inst);
    std::string push_tmp_instr_regs(Ptr<Instruction> inst);
    std::string pop_tmp_instr_regs(Ptr<Instruction> inst);
    void make_linear_bb(Ptr<Function> fun, Ptr<RegAllocDriver> driver = nullptr);
    void func_call_check(Ptr<Function> fun);
    void reg_use_statistic(Ptr<Function> fun);
    std::string make_lit_pool(bool have_br = false);
    std::string push_regs(std::vector<int> &reg_list, std::string cond = "");
    std::string pop_regs(std::vector<int> &reg_list, std::string cond = "");
    std::string global(std::string name);
    bool iszeroinit(Ptr<Constant> init);
    std::string module_gen(Ptr<Module> module);
    std::string global_def_gen(Ptr<Module> module);
    void make_global_table(Ptr<Module> module);
    std::string function_gen(Ptr<Function> function, Ptr<RegAllocDriver> driver = nullptr);
    int stack_space_allocation(Ptr<Function> fun);
    std::string callee_reg_store(Ptr<Function> fun);
    std::string callee_stack_operation_in(Ptr<Function> fun, int stack_size);
    std::string arg_move(Ptr<CallInst> call);
    std::string callee_arg_move(Ptr<Function> fun);
    std::string callee_reg_restore(Ptr<Function> fun);
    std::string callee_stack_operation_out(Ptr<Function> fun, int stack_size);
    std::string caller_reg_store(Ptr<Function> fun,Ptr<CallInst> call);
    std::string caller_reg_restore(Ptr<Function> fun, Ptr<CallInst> call);
    void global_label_gen(Ptr<Function> fun);
    std::string print_global_table();
    std::string bb_gen(Ptr<BasicBlock> bb);
    std::string instr_gen(Ptr<Instruction> inst);
    std::string phi_union(Ptr<BasicBlock> bb, Ptr<Instruction> br_inst);
    std::string single_data_move(Ptr<IR2asm::Location> src_loc, Ptr<IR2asm::Location> target_loc, Ptr<IR2asm::Reg>reg_tmp, std::string cmpop = "");
    std::string data_move(PtrVec<IR2asm::Location> &src, std::vector<Ptr<IR2asm::Location>> &dst, std::string cmpop = "");
    std::map<Ptr<IR2asm::Location>,PtrVec<IR2asm::Location>> create_dep_graph(PtrVec<IR2asm::Location> &src,PtrVec<IR2asm::Location> &dst);
    Ptr<IR2asm::Reg>get_asm_reg(Ptr<Value>val){
        if ((reg_map).find(val) != reg_map.end())
            return Ptr<IR2asm::Reg>(new IR2asm::Reg((reg_map).find(val)->second->reg_num));
        else exit(7);
    }
    Ptr<IR2asm::constant> get_asm_const(Ptr<Constant>val){if (dynamic_pointer_cast<ConstantZero>(val)) return Ptr<IR2asm::constant>(new IR2asm::constant(0));
                                                    else if(dynamic_pointer_cast<ConstantInt>(val)){
                                                        auto const_val = dynamic_pointer_cast<ConstantInt>(val);
                                                        if (const_val) return Ptr<IR2asm::constant>(new IR2asm::constant(const_val->get_value()));
                                                    }
                                                    else{
                                                        auto const_val = dynamic_pointer_cast<ConstantFloat>(val);
                                                        if (const_val) return Ptr<IR2asm::constant>(new IR2asm::constant(0,true,const_val->get_value()));
                                                    }
                                                    }
    std::string ret_mov(Ptr<CallInst> call);
    bool instr_may_need_push_stack(Ptr<Instruction>instr) { return !(instr->is_ret() || instr->is_phi());}
private:
    struct cmp_out_num{
        bool operator()(const Ptr<IR2asm::Location> a, const Ptr<IR2asm::Location> b) const {
            auto a_size=a->out_deg;
            auto b_size=b->out_deg;
            if(a_size!=b_size) return a_size<b_size;
            else return a->get_code()<b->get_code();
        }
    };
};
}
}
#endif