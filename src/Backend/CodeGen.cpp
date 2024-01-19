#include<CodeGen.h>
#include<RegAlloc.h>
#include<queue>
#include<stack>
#include<algorithm>
#include<sstream>
#include<string>

namespace SysYF{
namespace IR{
    std::string CodeGen::global(std::string name){
        return IR2asm::space + ".globl " + ".." + name + IR2asm::endl;
    }

    bool CodeGen::iszeroinit(Ptr<Constant> init){
        if(dynamic_pointer_cast<ConstantInt>(init)){
            return (dynamic_pointer_cast<ConstantInt>(init)->get_value() == 0);
        }
        else if(dynamic_pointer_cast<ConstantFloat>(init)){
            return (dynamic_pointer_cast<ConstantFloat>(init)->get_value() == 0);
        }
        else{
            auto initalizer = dynamic_pointer_cast<ConstantArray>(init);
            if(initalizer==nullptr) std::cout<<"nullptr"<<std::endl;
            int init_size = initalizer->get_size_of_array();
            for(int i = 0; i < init_size; i++){
                Ptr<Constant> init_iter = initalizer->get_element_value(i);
                if(!iszeroinit(init_iter))return false;
            }
        }
        return true;
    }

    std::string CodeGen::push_regs(std::vector<int> &reg_list, std::string cond) {
        std::string code;
        code += IR2asm::space;
        code += "push" + cond + " {";
        for(auto reg: reg_list){
            code += IR2asm::Reg(reg).get_code();
            if(reg != *reg_list.rbegin())code += ", ";
        }
        code += "}" + IR2asm::endl;
        sp_extra_ofst += reg_list.size() * reg_size;
        return code;
    }

    std::string CodeGen::pop_regs(std::vector<int> &reg_list, std::string cond) {
        std::string code;
        code += IR2asm::space;
        code += "pop" + cond + " {";
        for(auto reg: reg_list){
            code += IR2asm::Reg(reg).get_code();
            if(reg != *reg_list.rbegin())code += ", ";
        }
        code += "}" + IR2asm::endl;
        sp_extra_ofst -= reg_list.size() * reg_size;
        return code;
    }

    std::string CodeGen::global_def_gen(Ptr<Module> module){
        std::string code;
        for(auto var: module->get_global_variable()){
            std::string name = var->get_name();
            bool isconst = var->is_const();
            auto initializer = var->get_init();
            bool isinitialized = (dynamic_pointer_cast<ConstantZero>(initializer) == nullptr);
            bool isarray = (dynamic_pointer_cast<ConstantArray>(initializer) != nullptr);
            int size = var->get_type()->get_size();
            code += IR2asm::space;
            code += ".type .." + name + ", %object" + IR2asm::endl;
            code += IR2asm::space;
            if(isinitialized){  //initialized global var
                bool iszeroinit_ = iszeroinit(initializer);
                if(isconst){
                    code += ".section .rodata,\"a\", %progbits" + IR2asm::endl;
                }
                else{
                    if(iszeroinit_){
                        code += ".bss" + IR2asm::endl;
                    }
                    else{
                        code += ".data" + IR2asm::endl;
                    }
                }
                code += global(name);
                code += IR2asm::space;
                code += ".p2align " + std::to_string(int_p2align) + IR2asm::endl;
                code += ".." + name + ":" + IR2asm::endl;
                code += IR2asm::space;
                if(!isarray){
                    code += ".long ";
                    if(dynamic_pointer_cast<ConstantFloat>(initializer)){
                        code += std::to_string(dynamic_pointer_cast<ConstantFloat>(initializer)->get_value());
                    }
                    else if(dynamic_pointer_cast<ConstantInt>(initializer)){
                        code += std::to_string(dynamic_pointer_cast<ConstantInt>(initializer)->get_value());
                    }
                    code += IR2asm::endl;
                    code += IR2asm::space;
                }
                else{
                    if(iszeroinit_){
                        code += ".zero ";
                        code += std::to_string(size);
                        code += IR2asm::endl;
                        code += IR2asm::space;
                    }
                    else{
                        auto initalizer_ = dynamic_pointer_cast<ConstantArray>(initializer);
                        int init_size = initalizer_->get_size_of_array();
                        for(int i = 0; i < init_size; i++){
                            Ptr<Constant> init_iter = initalizer_->get_element_value(i);
                            code += ".long ";
                            if(dynamic_pointer_cast<ConstantFloat>(initializer)){
                                code += std::to_string(dynamic_pointer_cast<ConstantFloat>(initializer)->get_value());
                            }
                            else if(dynamic_pointer_cast<ConstantInt>(initializer)){
                                code += std::to_string(dynamic_pointer_cast<ConstantInt>(initializer)->get_value());
                            }
                            code += IR2asm::endl;
                            code += IR2asm::space;
                        }
                    }
                }
                code += ".size ";
                code += ".." + name + ", ";
                code += std::to_string(size);
                code += IR2asm::endl;
            }
            else{   //uninitialized global var
                code += ".comm ..";
                code += name;
                code += ", ";
                code += std::to_string(size);
                code += ", " + std::to_string(int_align);  //int align 4
                code += IR2asm::endl;
            }
            code += IR2asm::endl;
        }
        return code;
    }

    void CodeGen::make_global_table(Ptr<Module> module){
        //创建全局变量作用域表global_variable_use：{fun,{vars}}
        for(auto var: module->get_global_variable()){
            for(auto use: var->get_use_list()){
                Ptr<Function> func_;
                func_ = dynamic_pointer_cast<Instruction>(use.val_)->get_parent()->get_parent();
                if(global_variable_use.find(func_) != global_variable_use.end()){
                    global_variable_use.find(func_)->second.insert(var);
                }
                else{
                    global_variable_use.insert({func_, {var}});
                }
            }
        }
    }
    
    std::string CodeGen::print_global_table(){
        std::string code;
        for(auto iter: global_variable_table){
            Ptr<GlobalVariable> var = iter.first;
            IR2asm::label label = *iter.second;
            code += label.get_code();
            code += ":" + IR2asm::endl;
            code += IR2asm::space;
            code += ".long ..";
            code += var->get_name();
            code += IR2asm::endl;
        }
        return code;
    }

    std::string CodeGen::module_gen(Ptr<Module> module){
        std::string code;
        //生成全局变量定义代码
        std::string globaldef;
        globaldef += global_def_gen(module);
        auto driver = new RegAllocDriver(module);
        driver->compute_reg_alloc();
        make_global_table(module);  //创建全局变量作用域表
        func_no = 0;    //函数编号
        code += IR2asm::space + ".arch armv8 " + IR2asm::endl;  //架构声明
        code += IR2asm::space + ".text " + IR2asm::endl;
        for(auto func_: module->get_functions()){
            //为func生成代码
            if(func_->get_basic_blocks().empty())continue;  //空函数跳过
            reg_map = driver->get_reg_alloc_in_func(func_); //获取func_的寄存器分配方案
            code += function_gen(func_) + IR2asm::endl;     //生成func_代码
            func_no++;
        }
        return code + globaldef;
    }

    void CodeGen::make_linear_bb(Ptr<Function> fun,Ptr<RegAllocDriver> driver){
        //sort bb and make bb label, put in CodeGen::bb_label
        //label gen, name mangling as bbx_y for yth bb in function no.x .
        bb_label.clear();
        linear_bb.clear();
        bb_no = -1;
        PtrList<BasicBlock> linear_fun_bb;
        if(driver){
            linear_fun_bb = driver->get_bb_order_in_func(fun);
        }
        else{
            linear_fun_bb = fun->get_basic_blocks();
        }
        Ptr<BasicBlock> ret_bb;
        Ptr<IR2asm::label>newlabel;
        std::string label_str;
        for(auto bb: linear_fun_bb){
        if(bb->get_terminator()==nullptr){
            auto inst = bb->get_instructions();
            std::cout<<"b"<<std::endl;
        }
            if(bb != fun->get_entry_block() && !bb->get_terminator()->is_ret()){
                label_str = "bb" + std::to_string(func_no) + "_" + std::to_string(bb_no);
                newlabel = Ptr<IR2asm::label>(new IR2asm::label(label_str));
                bb_label.insert({bb, newlabel});
            }
            else if(bb == fun->get_entry_block() && bb->get_terminator()->is_ret()){
                bb_label.insert({bb, Ptr<IR2asm::label>(new IR2asm::label(""))});
                linear_bb.push_back(bb);
                return;
            }
            else if(bb == fun->get_entry_block()){
                bb_label.insert({bb, Ptr<IR2asm::label>(new IR2asm::label(""))});
            }
            else{
                ret_bb = bb;
                continue;
            }
            linear_bb.push_back(bb);
            bb_no++;
        }
        label_str = "bb" + std::to_string(func_no) + "_" + std::to_string(bb_no);
        newlabel =Ptr<IR2asm::label>(new IR2asm::label(label_str));
        bb_label.insert({ret_bb, newlabel});
        linear_bb.push_back(ret_bb);
        return;
    }

    void CodeGen::global_label_gen(Ptr<Function> fun){
        //global varibal address store after program(.LCPIx_y), fill in CodeGen::global_variable_table
        if(global_variable_use.find(fun) == global_variable_use.end()){
            global_variable_table.clear();
            return;        
        }
        auto used_global = global_variable_use.find(fun)->second;
        global_variable_table.clear();
        label_no = 0;
        for(auto var: used_global){
            std::string label_str = "Addr" + std::to_string(func_no) + "_" + std::to_string(label_no);
            Ptr<IR2asm::label> new_label = Ptr<IR2asm::label>(new IR2asm::label(label_str));
            label_no++;
            global_variable_table.insert({var, new_label});
        }
    }

    void CodeGen::func_call_check(Ptr<Function> fun){
        max_arg_size = 0;
        have_func_call = false;
        int inst_count = 0;
        for(auto bb: fun->get_basic_blocks()){
            for(auto inst: bb->get_instructions()){
                //TODO: better evaluation instruction cost
                switch(inst->get_instr_type()){
                    case Instruction::OpID::call :{
                        inst_count += dynamic_pointer_cast<CallInst>(inst)->get_num_operand() + 4;
                        break;
                    }
                    case Instruction::OpID::cmpbr :{
                        inst_count += 3;
                        break;
                    }
                    case Instruction::OpID::getelementptr :{
                        inst_count += 2;
                        break;
                    }
                    case Instruction::OpID::phi :{
                        inst_count += (dynamic_pointer_cast<PhiInst>(inst)->get_num_operand() / 2) * bb->get_pre_basic_blocks().size();
                        break;
                    }
                    default: inst_count++;
                }
                auto call = dynamic_pointer_cast<CallInst>(inst);
                if(!call)continue;
                int arg_size = 0;
                auto callee = dynamic_pointer_cast<Function>(call->get_operand(0));
                for(auto arg: callee->get_args()){
                    arg_size += arg->get_type()->get_size();
                }
                if(arg_size > max_arg_size)max_arg_size = arg_size;
                have_func_call = true;
            }
        }
        if(inst_count > 500)long_func = true;
        else{long_func = false;}
        return;
    }

    void CodeGen::reg_use_statistic(Ptr<Function> fun){
        used_reg.second.clear();
        used_reg.first.clear();
        reg2val.clear();
        for(auto iter: reg_map){
            Ptr<Value> vreg = iter.first;
            Ptr<Interval> interval = iter.second;
            //iter使用寄存器
            if(interval->reg_num >= 0){
                //记录使用的寄存器（0~3,o.w.）
                if(interval->reg_num > 3){
                    used_reg.second.insert(interval->reg_num);
                }
                else{
                    used_reg.first.insert(interval->reg_num);
                }
                //构造reg->val映射
                if(reg2val.find(interval->reg_num)!=reg2val.end()){
                    reg2val.find(interval->reg_num)->second.push_back(vreg);
                }
                else{
                    reg2val.insert({interval->reg_num, {vreg}});
                }
                continue;
            }
        }
        if(have_func_call)used_reg.second.insert(IR2asm::frame_ptr);
        return;
    }

    //函数的代码生成
    std::string CodeGen::function_gen(Ptr<Function> fun,Ptr<RegAllocDriver> driver){
        std::string code;
        sp_extra_ofst = 0;
        pool_number = 0;
        cur_tmp_regs.clear();
        tmp_regs_loc.clear();
        free_tmp_pos.clear();
        free_tmp_pos = all_free_tmp_pos;
        global_label_gen(fun);
        make_linear_bb(fun, driver);
        func_call_check(fun);
        reg_use_statistic(fun);
        int stack_size = stack_space_allocation(fun);
        //代码生成
        //函数头部
        code += IR2asm::space + ".globl " + fun->get_name() + IR2asm::endl;
        code += IR2asm::space + ".p2align " + std::to_string(int_p2align) + IR2asm::endl;
        code += IR2asm::space + ".type " + fun->get_name() + ", %function" + IR2asm::endl;
        code += fun->get_name() + ":" + IR2asm::endl;
        //函数体
        //被调用者义务
        code += callee_reg_store(fun);
        if(stack_size)code += callee_stack_operation_in(fun, stack_size);
        code += callee_arg_move(fun);
        //为各个基本块生成代码
        for(auto bb: linear_bb){
            code += bb_gen(bb);
        }
        //被调用者义务
        if(stack_size)code += callee_stack_operation_out(fun, stack_size);
        code += callee_reg_restore(fun);
        //跳到返回地址
        code += IR2asm::space + "bx lr" + IR2asm::endl;
        //TO BE READ
        code += make_lit_pool(true);
        code += print_global_table();
        return code;
    }

    std::string CodeGen::make_lit_pool(bool have_br){
        if(have_br){
            return IR2asm::space + ".pool" + IR2asm::endl;
        }
        std::string code;
        IR2asm::label pool_label("litpool" + std::to_string(func_no) + "_" + std::to_string(pool_number), 0);
        pool_number++;
        code += IR2asm::space;
        code += "b " + pool_label.get_code();
        code += IR2asm::endl;
        code += IR2asm::space + ".pool" + IR2asm::endl;
        code += pool_label.get_code() + ":" + IR2asm::endl;
        return code;
    }

    std::string CodeGen::bb_gen(Ptr<BasicBlock> bb){
        std::string code;
        if(bb_label[bb]->get_code() != ""){
            code += bb_label[bb]->get_code()+":"+IR2asm::endl;
        }
        Ptr<Instruction> br_inst = nullptr;
        for(auto inst : bb->get_instructions()){
            std::string new_code;
            if(inst->isTerminator()){
                br_inst = inst;
                break;
            }
            new_code += ld_tmp_regs(inst);
            if(dynamic_pointer_cast<CallInst>(inst)){
                auto call_inst = dynamic_pointer_cast<CallInst>(inst);
                new_code += caller_reg_store(bb->get_parent(),call_inst);
                new_code += arg_move(call_inst);
                new_code += instr_gen(call_inst);
                new_code += caller_reg_restore(bb->get_parent(),call_inst);
                accumulate_line_num += std::count(new_code.begin(), new_code.end(), IR2asm::endl[0]);
                if(accumulate_line_num > literal_pool_threshold){
                    code += make_lit_pool();
                    accumulate_line_num = 0;
                }
                code += new_code;
            }else if(instr_may_need_push_stack(inst)){

                new_code += push_tmp_instr_regs(inst);

                new_code += instr_gen(inst);

                new_code += pop_tmp_instr_regs(inst);

                accumulate_line_num += std::count(new_code.begin(), new_code.end(), IR2asm::endl[0]);
                if(accumulate_line_num > literal_pool_threshold){
                    code += make_lit_pool();
                    accumulate_line_num = 0;
                }

                code += new_code;
            }else{
                new_code += instr_gen(inst);
                accumulate_line_num += std::count(new_code.begin(), new_code.end(), IR2asm::endl[0]);
                if(accumulate_line_num > literal_pool_threshold){
                    code += make_lit_pool();
                    accumulate_line_num = 0;
                }
                code += new_code;
            }
        }
        std::string new_code;
        new_code += ld_tmp_regs(br_inst);
        if(br_inst->is_cmpbr()){
            new_code += ld_tmp_regs(br_inst);
            new_code += push_tmp_instr_regs(br_inst);
            accumulate_line_num += std::count(new_code.begin(), new_code.end(), IR2asm::endl[0]);
            if(accumulate_line_num > literal_pool_threshold){
                code += make_lit_pool();
                accumulate_line_num = 0;
            }
            code += new_code;
        }
        code += phi_union(bb, br_inst);
        return code;
    }
}
}