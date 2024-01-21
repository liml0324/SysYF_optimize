//
// Created by cjb on 7/24/21.
//

#include "RegAlloc.h"
#include <iostream>
#include <fstream>
#include <set>

namespace SysYF
{
namespace IR
{
void Interval::add_range(int from, int to) {
    if(range_list.empty()){
        range_list.push_front(Ptr<Range>(new Range(from, to)));
        return;
    }
    auto top_range = *range_list.begin();
    if(from>=top_range->from && from<=top_range->to){
        top_range->to = to > top_range->to?to:top_range->to;
    }else if(from < top_range->from){
        if(to <= top_range->to && to>=top_range->from){
            top_range->from = from;
        }else{
            auto new_range = new Range(from,to);
            range_list.push_front(Ptr<Range>(new_range));
        }
    }else{
        auto new_range = new Range(from,to);
        range_list.push_front(Ptr<Range>(new_range));
    }
}

bool Interval::covers(int id){
    for(auto range:range_list){
        if(range->from<=id&&range->to>id){
            return true;
        }
    }
    return false;
}

bool Interval::covers(Ptr<Instruction> inst){
    return covers(inst->get_id());
}

bool Interval::intersects(Ptr<Interval>interval) {
    auto target_it = range_list.begin();
    auto with_it = interval->range_list.begin();
    while(with_it!=interval->range_list.end()&&target_it!=range_list.end()){
        auto target_range = *target_it;
        auto with_range = *with_it;
        if(target_range->to<=with_range->from){
            target_it++;
            continue;
        }else if(with_range->to<=target_range->from){
            with_it++;
            continue;
        }else{
            return true;
        }
    }
    return false;
}


struct cmp_range{
    bool operator()(const Ptr<Range> a,const Ptr<Range> b) const {
        return a->from > b->from;
    }
};

void Interval::union_interval(Ptr<Interval>interval) {
    std::priority_queue<Ptr<Range>, PtrVec<Range>, cmp_range> all_range;
    for(auto range:range_list){
        all_range.push(range);
    }
    for(auto range:interval->range_list){
        all_range.push(range);
    }
    if(all_range.empty()){
        return;
    }
    range_list.clear();
    auto cur_range = all_range.top();
    all_range.pop();
    while(!all_range.empty()){
        auto merge_range = all_range.top();
        all_range.pop();
        if(merge_range->from > cur_range->to){
            range_list.push_back(cur_range);
            cur_range = merge_range;
        }else{
            cur_range->to = cur_range->to >= merge_range->to?cur_range->to:merge_range->to;
        }
    }
    range_list.push_back(cur_range);
}


void RegAllocDriver::compute_reg_alloc() {
    for(auto func:module->get_functions()){
        if(func->get_basic_blocks().empty()){
            continue;
        }else{
#ifdef DEBUG
            std::cerr << "function " << func->get_name() << std::endl;
#endif
            auto allocator = new RegAlloc(func);
            allocator->execute();
            reg_alloc[func] = allocator->get_reg_alloc();
            bb_order[func] = allocator->get_block_order();
        }
    }
#ifdef DEBUG
    std::cerr << "finish reg alloc\n";
#endif
}

void RegAlloc::execute() {
    compute_block_order();
    number_operations();
    build_intervals();
    walk_intervals();
    set_unused_reg_num();
    std::ofstream reg_out_file;
}

void RegAlloc::compute_block_order() {
    block_order.clear();
    auto entry = func->get_entry_block();
    PtrSet<BasicBlock> visited = {};
    get_dfs_order(entry,visited);
}

void RegAlloc::get_dfs_order(Ptr<BasicBlock> bb, PtrSet<BasicBlock> &visited) {
    visited.insert(bb);
    block_order.push_back(bb);
    auto children = bb->get_succ_basic_blocks();
    for(auto child : children){
        auto is_visited = visited.find(child);
        if(is_visited == visited.end()){
            get_dfs_order(child,visited);
        }
    }
}

void RegAlloc::number_operations() {
    int next_id = 0;
    for(auto bb:block_order){
        auto instrs = bb->get_instructions();
        for(auto instr:instrs){
            instr->set_id(next_id);
            next_id += 2;
        }
    }
}

void RegAlloc::build_intervals() {
    for(auto iter = block_order.rbegin();iter != block_order.rend();iter++)
    {
        auto bb = *iter;
        auto instrs = bb->get_instructions();
        int block_from = (*(instrs.begin()))->get_id();
        auto lst_instr = instrs.rbegin();
        int block_to = (*(lst_instr))->get_id() + 2;
        for(auto opr:bb->get_live_out()){
            if((!(dynamic_pointer_cast<Instruction>(opr)) && !(dynamic_pointer_cast<Argument>(opr)))||(dynamic_pointer_cast<AllocaInst>(opr))){
                continue;
            }
            if(val2Inter.find(opr)==val2Inter.end()){
                auto new_interval = Ptr<Interval>(new Interval(opr));
                val2Inter[opr] = new_interval;
            }
            val2Inter[opr]->add_range(block_from,block_to);
        }
        for(auto instr_iter = instrs.rbegin();instr_iter!=instrs.rend();instr_iter++){
            auto instr = *instr_iter;

            if(!instr->is_void()){
                if(dynamic_pointer_cast<AllocaInst>(instr))continue;
                if(val2Inter.find(instr)==val2Inter.end()){
                    auto new_interval =Ptr<Interval>(new Interval(instr));
                    new_interval->add_range(block_from,block_to);
                    val2Inter[instr] = new_interval;
                }
                auto cur_inter = val2Inter[instr];
                auto top_range = *(cur_inter->range_list.begin());
                top_range->from = instr->get_id();
                cur_inter->add_use_pos(instr->get_id());
            }

            if(instr->is_phi()){//analyze
                continue;
            }

            for(auto opr:instr->get_operands()){
                if((!(dynamic_pointer_cast<Instruction>(opr)) && !(dynamic_pointer_cast<Argument>(opr)))||(dynamic_pointer_cast<AllocaInst>(opr))){
                    continue;
                }
                if(val2Inter.find(opr)==val2Inter.end()){
                    auto new_interval = Ptr<Interval>(new Interval(opr));
                    val2Inter[opr] = new_interval;
                    new_interval->add_range(block_from,instr->get_id()+2);
                    new_interval->add_use_pos(instr->get_id());
                }
                else{
                    auto cur_inter = val2Inter[opr];
                    cur_inter->add_range(block_from,instr->get_id()+2);
                    cur_inter->add_use_pos(instr->get_id());
                }
            }
        }
    }
    for(auto pair:val2Inter){
#ifdef DEBUG
        std::cerr << "op:" <<pair.first->get_name() << std::endl;
#endif
        add_interval(pair.second);
#ifdef DEBUG
        for(auto range:pair.second->range_list){
            std::cerr << "from: " << range->from << " to: " << range->to << std::endl;
        }
#endif
    }
}

//传统线性扫描法分配寄存器
void RegAlloc::walk_intervals() {

    /*you need to finish this function*/
    used_reg_interval.clear();
    for(auto current_it=interval_list.begin();current_it!=interval_list.end();current_it++){
        current = *current_it;
        //更新最新区间上端点位置
        cur_loc=current->range_list.front()->from;
        //尝试直接分配寄存器
        if(try_alloc_free_reg()){
            continue;
        }
        //尝试分配超出范围的寄存器
        else if(try_alloc_outofuse_reg()){
            continue;
        }
        else if(try_alloc_leastimportant_reg()){
            continue;
        }
        else{
            //分配失败
            current->reg_num = -1;
        }
    }
    for(auto inter:interval_list){
        std::cout<<inter->val->get_name()<<":"<<std::endl;
        std::cout<<"\t-"<<inter->reg_num<<std::endl;
        for(auto range: inter->range_list){
            std::cout<<"\t"<<range->from<<":"<<range->to<<std::endl;
        }
    }
}


void RegAlloc::set_unused_reg_num() {
    func->set_unused_reg_num(unused_reg_id);
}

//--------------Tools----------------

/*释放寄存器
*/
void RegAlloc::add_reg_to_pool(Ptr<Interval> inter){
    //修改unused_reg_id
    unused_reg_id.insert(inter->reg_num);
    //从used_reg_interval中删除interval
    used_reg_interval.erase(inter);
}

/*尝试分配寄存器
reg_num：接收分配的寄存器编号
返回值：是否成功分配
修改unused_reg_id
*/
bool RegAlloc::try_alloc_free_reg(){
    if(unused_reg_id.empty()){
        return false;
    }
    auto reg_num = *unused_reg_id.begin();
    unused_reg_id.erase(unused_reg_id.begin());
    current->reg_num = reg_num;
    used_reg_interval.insert(current);
    return true;
}

/*尝试分配已失效的寄存器
*/
bool RegAlloc::try_alloc_outofuse_reg(){
    //取出to最小的区间
    auto inter=*(used_reg_interval.begin());
    if(inter->range_list.back()->to<cur_loc){
        //该寄存器已失效，可以释放
        auto reg_num = inter->reg_num;
        add_reg_to_pool(inter);
        //将释放出的寄存器交给当前区间
        unused_reg_id.erase(unused_reg_id.begin());
        current->reg_num = reg_num;
        used_reg_interval.insert(current);
        return true;
    }
    else{
        //不存在失效的寄存器，无法释放
        return false;
    }
}

/*尝试调整寄存器分配，将最不重要的寄存器分配给当前区间
*/
bool RegAlloc::try_alloc_leastimportant_reg(){
    //取出to最大的区间
    auto inter=*(used_reg_interval.begin());
    if(inter->range_list.back()->to>current->range_list.back()->to ){
        //当前区间更重要
        auto reg_num = inter->reg_num;
        add_reg_to_pool(inter);
        //将释放出的寄存器交给当前区间
        inter->reg_num = -1;
        unused_reg_id.erase(unused_reg_id.begin());
        current->reg_num = reg_num;
        used_reg_interval.insert(current);
        return true;
    }
    else{
        //不存在失效的寄存器，无法释放
        return false;
    }
}

}
}