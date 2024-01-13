#ifndef _SYSYF_REGALLOC_H_
#define _SYSYF_REGALLOC_H_

#include "Value.h"
#include "Module.h"
#include <map>
#include <set>
#include <queue>


namespace SysYF{
namespace IR{

class Interval;
class RegAlloc;


struct Range{
    Range(int f,int t):from(f),to(t){}
    int from;
    int to;
};


class Interval{
public:
    explicit Interval(Ptr<Value> value):val(value){}
    int reg_num = -1;
    Ptr<Value> val;
    PtrList<Range> range_list;
    std::list<int> position_list;
    void add_range(int from,int to);
    void add_use_pos(int pos){position_list.push_front(pos);}
    bool covers(int id);
    bool covers(Ptr<Instruction> inst);
    bool intersects(Ptr<Interval> interval);
    void union_interval(Ptr<Interval> interval);
};


struct cmp_interval{
    bool operator()(const Ptr<Interval> a, const Ptr<Interval> b) const {
        auto a_from = (*(a->range_list.begin()))->from;
        auto b_from = (*(b->range_list.begin()))->from;
        if(a_from!=b_from){
            return a_from < b_from;
        }else{
            return a->val->get_name() < b->val->get_name();
        }
    }
};

struct cmp_interval_by_end{
    bool operator()(const Ptr<Interval> a, const Ptr<Interval> b) const {
        auto a_to = (*(a->range_list.rbegin()))->to;
        auto b_to = (*(b->range_list.rbegin()))->to;
        if(a_to!=b_to){
            return a_to < b_to;
        }else{
            return a->val->get_name() < b->val->get_name();
        }
    }
};

const int priority[] = {
        5,//r0
        4,//r1
        3,//r2
        2,//r3
        12,//r4
        11,//r5
        10,//r6
        9,//r7
        8,//r8
        7,//r9
        6,//r10
        -1,//r11
        1//r12
};


struct cmp_reg {
    bool operator()(const int reg1,const int reg2)const{
#ifdef DEBUG
        assert(reg1>=0&&reg1<=12&&reg2<=12&&reg2>=0&&"invalid reg id");
#endif
        return priority[reg1] > priority[reg2];
    }
};

// const std::vector<int> all_reg_id = {0,1,2,3,4,5,6,7,8,9,10,12};
const std::vector<int> all_reg_id = {0,1,2,3,4,5,6,7,8,9};//10,12专用于phi(To Be Optimized)

class RegAllocDriver{
public:
    explicit RegAllocDriver(Ptr<Module> m):module(m){}
    void compute_reg_alloc();
    std::map<Ptr<Value>, Ptr<Interval>>& get_reg_alloc_in_func(Ptr<Function> f){return reg_alloc[f];}
    PtrList<BasicBlock>& get_bb_order_in_func(Ptr<Function> f){return bb_order[f];}
private:
    std::map<Ptr<Function>, PtrList<BasicBlock>> bb_order;
    std::map<Ptr<Function>,std::map<Ptr<Value>,Ptr<Interval>>> reg_alloc;
    Ptr<Module> module;
};

/*****************Linear Scan Register Allocation*******************/

class RegAlloc{
public:
    explicit RegAlloc(Ptr<Function> f):func(f){}
    void execute();
    std::map<Ptr<Value>,Ptr<Interval>>& get_reg_alloc(){return val2Inter;}
    PtrList<BasicBlock>& get_block_order(){return block_order;}
private:
    void compute_block_order();
    void number_operations();
    void build_intervals();
    void walk_intervals();
    void set_unused_reg_num();
    void get_dfs_order(Ptr<BasicBlock> bb,PtrSet<BasicBlock>& visited);
    void add_interval(Ptr<Interval> interval){interval_list.insert(interval);}
    void add_reg_to_pool(Ptr<Interval> inter);
    bool try_alloc_free_reg();
    bool try_alloc_outofuse_reg();
    bool try_alloc_leastimportant_reg();
    std::set<int> unused_reg_id = {all_reg_id.begin(),all_reg_id.end()};
    Ptr<Interval> current = nullptr;
    int cur_loc;
    std::map<Ptr<Value>, Ptr<Interval>> val2Inter;
    Ptr<Function> func;
    PtrList<BasicBlock> block_order={};
    //已按照区间开始的先后顺序排好序（升序）
    std::set<Ptr<Interval>,cmp_interval> interval_list;
    //已按照区间结束的先后顺序排好序（升序）
    std::set<Ptr<Interval>,cmp_interval_by_end> used_reg_interval={};
};
    
    }
    }

#endif // _SYSYF_REGALLOC_H_