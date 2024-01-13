#include "Mem2Reg.h"
#include "IRBuilder.h"

namespace SysYF
{
namespace IR
{
void Mem2Reg::execute(){
    for(auto fun: module->get_functions()){
        if(fun->get_basic_blocks().empty())continue;
        func_ = fun;
        lvalue_connection.clear();
        no_union_set.clear();
        insideBlockForwarding();
        
        genPhi();
        
        module->set_print_name();
        
        valueDefineCounting();
        
        valueForwarding(func_->get_entry_block());
        
        removeAlloc();
        
    }
}

void Mem2Reg::insideBlockForwarding(){
    for(auto bb: func_->get_basic_blocks()){
        std::map<Ptr<Value>, Ptr<Instruction>> defined_list;
        std::map<Ptr<Instruction>, Ptr<Value>> forward_list;
        std::map<Ptr<Value>, Ptr<Value>> new_value;
        std::set<Ptr<Instruction>> delete_list;
        for(auto inst: bb->get_instructions()){
            if(!isLocalVarOp(inst))continue;
            if(inst->get_instr_type() == Instruction::OpID::store){
                Ptr<Value> lvalue = static_pointer_cast<StoreInst>(inst)->get_lval();
                Ptr<Value> rvalue = static_pointer_cast<StoreInst>(inst)->get_rval();
                auto load_inst = dynamic_pointer_cast<Instruction>(rvalue);
                if(load_inst && forward_list.find(load_inst) != forward_list.end()){
                    // 该指令是load指令，且其值已经被替换
                    rvalue = forward_list.find(load_inst)->second;
                }
                if(defined_list.find(lvalue) != defined_list.end()){
                    // 该变量已经被定义过，需要删除上一条定义
                    auto pair = defined_list.find(lvalue);
                    delete_list.insert(pair->second);
                    pair->second = inst;
                }
                else{
                    // 该变量未被定义过，直接插入
                    defined_list.insert({lvalue, inst});
                }
                if(new_value.find(lvalue) != new_value.end()){
                    new_value.find(lvalue)->second = rvalue;
                }
                else{
                    new_value.insert({lvalue, rvalue});
                }
            }
            else if(inst->get_instr_type() == Instruction::OpID::load){
                // load指令，记录下需要替换的值
                Ptr<Value> lvalue = static_pointer_cast<LoadInst>(inst)->get_lval();
                Ptr<Value> rvalue = dynamic_pointer_cast<Value>(inst);
                Ptr<Value> value;
                if(defined_list.find(lvalue) == defined_list.end()) {
                    continue;
                }
                else value = new_value.find(lvalue)->second;
                forward_list.insert({inst, value});
            }
        }

        for(auto submap: forward_list){
            // 将load指令替换为对应的值
            Ptr<Instruction> inst = submap.first; 
            Ptr<Value> value = submap.second;
            for(auto use: inst->get_use_list()){
                Ptr<Instruction> use_inst = dynamic_pointer_cast<Instruction>(use.val_);
                use_inst->set_operand(use.arg_no_, value);
            }
            // 删除load指令
            bb->delete_instr(inst);
        } 
        for(auto inst:delete_list){
            // 删除store指令
            bb->delete_instr(inst);
        }       
    }
}

void Mem2Reg::genPhi(){
    std::set<Ptr<Value>> globals;
    std::map<Ptr<Value>, PtrSet<BasicBlock>> defined_in_block;
    for(auto bb: func_->get_basic_blocks()){
        for(auto inst: bb->get_instructions()){
            if(!isLocalVarOp(inst))continue;
            if(inst->get_instr_type() == Instruction::OpID::load){
                // 局部的load上面已经杀掉了，这里剩下的都是引用基本块外名字的load
                Ptr<Value> lvalue = static_pointer_cast<LoadInst>(inst)->get_lval();
                globals.insert(lvalue);
            }
            else if(inst->get_instr_type() == Instruction::OpID::store){
                // 记录该变量在哪些基本块中被定义过
                Ptr<Value> lvalue = static_pointer_cast<StoreInst>(inst)->get_lval();
                if(defined_in_block.find(lvalue) != defined_in_block.end()){
                    defined_in_block.find(lvalue)->second.insert(bb);
                }
                else{
                    defined_in_block.insert({lvalue, {bb}});
                }
            }
        }
    }

    std::map<Ptr<BasicBlock>, std::set<Ptr<Value>>> bb_phi_list;

    
    for(auto var: globals){
        // 处理引用了基本块外变量的load指令

        // 查找被定值的基本块
        auto define_bbs = defined_in_block.find(var)->second;
        
        PtrVec<BasicBlock> queue;
        queue.assign(define_bbs.begin(), define_bbs.end());
        int iter_pointer = 0;
        for(; iter_pointer < queue.size(); iter_pointer++){
            // 对于一个变量的一个定值和一个引用，如果这个定值所在的基本块支配引用所在的基本块，那对于这一对定值引用，
            // 就不需要插入phi指令，否则需要插入phi指令。因此，只需处理该定值所在基本块的迭代支配边界即可。
            // 这是因为，在支配边界中的基本块处插入了phi，那么这个phi可以“管理”所在基本块支配的基本块；只需接着考虑所在
            // 基本块的支配边界，也就是迭代支配边界。
            for(auto bb_domfront: queue[iter_pointer]->get_dom_frontier()){
                
                if(bb_phi_list.find(bb_domfront) != bb_phi_list.end()){// 该基本块已经插入过phi指令
                    
                    auto phis = bb_phi_list.find(bb_domfront);
                    if(phis->second.find(var) == phis->second.end()){// 但是没有对应这个变量的phi指令
                        phis->second.insert(var);
                        auto newphi = PhiInst::create_phi(var->get_type()->get_pointer_element_type(), 
                            bb_domfront);
                        newphi->set_lval(var);
                        bb_domfront->add_instr_begin(newphi);
                        queue.push_back(bb_domfront);
                    }
                }
                else{// 该基本块没有插入过phi指令
                    
                    auto newphi = PhiInst::create_phi(var->get_type()->get_pointer_element_type(), 
                            bb_domfront);
                    newphi->set_lval(var);
                    bb_domfront->add_instr_begin(newphi);            
                    queue.push_back(bb_domfront);
                    bb_phi_list.insert({bb_domfront, {var}});
                }
            }
        }
    }
}

void Mem2Reg::valueDefineCounting(){// 记录每个基本块内有多少定值
    define_var = std::map<Ptr<BasicBlock>, std::vector<Ptr<Value>>>();
    for(auto bb: func_->get_basic_blocks()){
        define_var.insert({bb, {}});
        for(auto inst: bb->get_instructions()){
            if(inst->get_instr_type() == Instruction::OpID::phi){
                auto lvalue = dynamic_pointer_cast<PhiInst>(inst)->get_lval();
                define_var.find(bb)->second.push_back(lvalue);
            }
            else if(inst->get_instr_type() == Instruction::OpID::store){
                if(!isLocalVarOp(inst))continue;
                auto lvalue = dynamic_pointer_cast<StoreInst>(inst)->get_lval();
                define_var.find(bb)->second.push_back(lvalue);
            }
        }
    }
}

std::map<Ptr<Value>, std::vector<Ptr<Value>>> value_status;
PtrSet<BasicBlock> visited;

void Mem2Reg::valueForwarding(Ptr<BasicBlock> bb){
    //这是处理一个bb块内部

    std::set<Ptr<Instruction>> delete_list;
    visited.insert(bb);
    for(auto inst: bb->get_instructions()){//记录每个左值对应的所有phi指令
        if(inst->get_instr_type() != Instruction::OpID::phi)break;
        auto lvalue = dynamic_pointer_cast<PhiInst>(inst)->get_lval();
        auto value_list = value_status.find(lvalue);
        if(value_list != value_status.end()){
            value_list->second.push_back(inst);
        }
        else{
            value_status.insert({lvalue, {inst}});
        }
    }

    for(auto inst: bb->get_instructions()){
        if(inst->get_instr_type() == Instruction::OpID::phi)continue;
        if(!isLocalVarOp(inst))continue;
        if(inst->get_instr_type() == Instruction::OpID::load){
            // 找到一个load，用基本块内最近的对应的phi指令/store右值替换它
            Ptr<Value> lvalue = static_pointer_cast<LoadInst>(inst)->get_lval();
            Ptr<Value> new_value = *(value_status.find(lvalue)->second.end() - 1);
            inst->replace_all_use_with(new_value);
        }
        else if(inst->get_instr_type() == Instruction::OpID::store){
            // 找到一个store，记录下该左值对应的右值
            // 这里主要是处理前一个基本块有store，store的值在基本块内没有被使用，而是在后续基本块被使用的情况
            Ptr<Value> lvalue = static_pointer_cast<StoreInst>(inst)->get_lval();
            Ptr<Value> rvalue = static_pointer_cast<StoreInst>(inst)->get_rval();
            if(value_status.find(lvalue) != value_status.end()){
                value_status.find(lvalue)->second.push_back(rvalue);
            }
            else{
                value_status.insert({lvalue, {rvalue}});
            }
        }
        delete_list.insert(inst);
    }

    for(auto succbb: bb->get_succ_basic_blocks()){
        // 填充后继中的phi指令
        for(auto inst: succbb->get_instructions()){
            if(inst->get_instr_type() == Instruction::OpID::phi){
                auto phi = dynamic_pointer_cast<PhiInst>(inst);
                auto lvalue = phi->get_lval();
                if(value_status.find(lvalue) != value_status.end()){
                    if(value_status.find(lvalue)->second.size() > 0){
                        // 由于是从entry开始dfs，因此如果从entry到这个基本块的路径上有对这个变量的定值，那么
                        // 就一定能找到对应的填充值。否则要么不可能从entry到这个基本块，要么会产生未定义行为。
                        auto new_value = *(value_status.find(lvalue)->second.end() - 1);
                        phi->add_phi_pair_operand(new_value, bb);
                    }
                    else{
                        // std::cout << "undefined value used: " << lvalue->get_name() << "\n";
                        // exit(-1);
                    }
                }
                else{
                    // std::cout << "undefined value used: " << lvalue->get_name() << "\n";
                    // exit(-1);
                }
            }
        }
    }

    for(auto succbb: bb->get_succ_basic_blocks()){// dfs
        if(visited.find(succbb)!=visited.end())continue;
        valueForwarding(succbb);
    }

    // for(auto inst: bb->get_instructions()){
        // 上面已经记录了每个基本块内有多少定值
        // 这里把这个基本块内的定值全部弹出（要返回了）
        auto var_set = define_var.find(bb)->second;
        for(auto var: var_set){
            if(value_status.find(var) == value_status.end())continue;
            if(value_status.find(var)->second.size() == 0)continue;
            value_status.find(var)->second.pop_back();
        }
    // }

    for(auto inst: delete_list){
        bb->delete_instr(inst);
    }
} 

void Mem2Reg::removeAlloc(){
    for(auto bb: func_->get_basic_blocks()){
        std::set<Ptr<Instruction>> delete_list;
        for(auto inst: bb->get_instructions()){
            if(inst->get_instr_type() != Instruction::OpID::alloca)continue;
            auto alloc_inst = dynamic_pointer_cast<AllocaInst>(inst);
            if(alloc_inst->get_alloca_type()->is_integer_type() || alloc_inst->get_alloca_type()->is_float_type() ||
               alloc_inst->get_alloca_type()->is_pointer_type())delete_list.insert(inst);
        }
        for(auto inst: delete_list){
            bb->delete_instr(inst);
        }
    }
}

void Mem2Reg::phiStatistic(){
    // 这个函数没有用到，就不分析了
    std::map<Ptr<Value>, Ptr<Value>> value_map;
    for(auto bb: func_->get_basic_blocks()){
        for(auto inst: bb->get_instructions()){
            if(!inst->is_phi())continue;
            auto phi_value = dynamic_pointer_cast<Value>(inst);
            if(value_map.find(phi_value) == value_map.end()){
                value_map.insert({phi_value, dynamic_pointer_cast<PhiInst>(inst)->get_lval()});
            }
        }
    }
    for(auto bb: func_->get_basic_blocks()){
        for(auto inst: bb->get_instructions()){
            if(!inst->is_phi())continue;
            auto phi_value = dynamic_pointer_cast<Value>(inst);
#ifdef DEBUG
            
#endif
            Ptr<Value> reduced_value;
            if(value_map.find(phi_value) != value_map.end()){
                reduced_value = value_map.find(phi_value)->second;
            }
            else{
                reduced_value = dynamic_pointer_cast<PhiInst>(inst)->get_lval();
                value_map.insert({phi_value, reduced_value});
            }
            for(auto opr: inst->get_operands()){
                if(dynamic_pointer_cast<BasicBlock>(opr))continue;
                if(dynamic_pointer_cast<Constant>(opr))continue;
                if(no_union_set.find(opr) != no_union_set.end())continue;
                if(value_map.find(opr) != value_map.end()){
                    auto opr_reduced_value = value_map.find(opr)->second;
                    if(opr_reduced_value != reduced_value){
#ifdef DEBUG
                        
                        
#endif
                    }
                }
                else{
                    if(lvalue_connection.find(opr)!=lvalue_connection.end()){
                        auto bounded_lval = lvalue_connection.find(opr)->second;
                        if(bounded_lval != reduced_value){
#ifdef DEBUG
                            
                            
#endif
                        }
                        else{
                            value_map.insert({opr, reduced_value});
                        }
                    }
                    else{
                        // value_map.insert({opr, reduced_value});
                    }
                }
            }
        }
    }

    std::map<Ptr<Value>, std::set<Ptr<Value>>> reversed_value_map;

    for(auto map_item: value_map){
        Ptr<Value> vreg = map_item.first;
        Ptr<Value> lvalue = map_item.second;
        if(reversed_value_map.find(lvalue) != reversed_value_map.end()){
            reversed_value_map.find(lvalue)->second.insert(vreg);
        }
        else{
            reversed_value_map.insert({lvalue, {vreg}});
        }
    }

    for(const auto& iter: reversed_value_map){
        func_->get_vreg_set().push_back(iter.second);
    }
}
}
}
