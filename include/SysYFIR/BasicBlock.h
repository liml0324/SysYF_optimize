#ifndef _SYSYF_BASICBLOCK_H_
#define _SYSYF_BASICBLOCK_H_

#include "Value.h"
#include "Instruction.h"
#include "Module.h"
#include "Function.h"

#include <list>
#include <set>
#include <string>

namespace SysYF
{
namespace IR
{
class Function;
class Instruction;
class Module;

class BasicBlock : public Value
{
public:
    static Ptr<BasicBlock> create(Ptr<Module> m, const std::string &name ,
                            Ptr<Function> parent ) {
        auto prefix = name.empty() ? "" : "label_";
        RET_AFTER_INIT(BasicBlock, m, prefix + name, parent);
    }

    // return parent, or null if none.
    Ptr<Function> get_parent() { return parent_; }
    
    Ptr<Module> get_module();

    /****************api about cfg****************/

    PtrList<BasicBlock> &get_pre_basic_blocks() { return pre_bbs_; }
    PtrList<BasicBlock> &get_succ_basic_blocks() { return succ_bbs_; }
    void add_pre_basic_block(Ptr<BasicBlock> bb) { pre_bbs_.push_back(bb); }
    void add_succ_basic_block(Ptr<BasicBlock> bb) { succ_bbs_.push_back(bb); }

    void remove_pre_basic_block(Ptr<BasicBlock> bb) { pre_bbs_.remove(bb); }
    void remove_succ_basic_block(Ptr<BasicBlock> bb) { succ_bbs_.remove(bb); }

    /****************api about cfg****************/

    /// Returns the terminator instruction if the block is well formed or null
    /// if the block is not well formed.
    const Ptr<Instruction> get_terminator() const;
    Ptr<Instruction> get_terminator() {
        return const_pointer_cast<Instruction>(
            static_pointer_cast<const BasicBlock>(shared_from_this())->get_terminator());
    }
    
    void add_instruction(Ptr<Instruction> instr);
    void add_instruction(PtrList<Instruction>::iterator instr_pos, Ptr<Instruction> instr);
    void add_instr_begin(Ptr<Instruction> instr);

    PtrList<Instruction>::iterator find_instruction(Ptr<Instruction> instr);

    void delete_instr(Ptr<Instruction> instr);
    void delete_instr_without_remove_use(Ptr<Instruction> instr);

    bool empty() { return instr_list_.empty(); }

    int get_num_of_instr() { return instr_list_.size(); }
    PtrList<Instruction> &get_instructions() { return instr_list_; }
    
    void erase_from_parent();
    
    virtual std::string print() override;

        /****************api about dominate tree****************/
    void set_idom(Ptr<BasicBlock> bb){idom_ = bb;}
    Ptr<BasicBlock> get_idom(){return idom_;}
    void add_dom_frontier(Ptr<BasicBlock> bb){dom_frontier_.insert(bb);}
    void add_rdom_frontier(Ptr<BasicBlock> bb){rdom_frontier_.insert(bb);}
    void clear_rdom_frontier(){rdom_frontier_.clear();}
    auto add_rdom(Ptr<BasicBlock> bb){return rdoms_.insert(bb);}
    void clear_rdom(){rdoms_.clear();}
    PtrSet<BasicBlock> &get_dom_frontier(){return dom_frontier_;}
    PtrSet<BasicBlock> &get_rdom_frontier(){return rdom_frontier_;}
    PtrSet<BasicBlock> &get_rdoms(){return rdoms_;}
    void set_live_in(PtrSet<Value> in){live_in = in;}
    void set_live_out(PtrSet<Value> out){live_out = out;}
    PtrSet<Value>& get_live_in(){return live_in;}
    PtrSet<Value>& get_live_out(){return live_out;}

    /****************api about available expression****************/
    void set_avail_expr_in(PtrSet<Value> in){avail_expr_in = in;}
    void set_avail_expr_out(PtrSet<Value> out){avail_expr_out = out; universal = false;}
    PtrSet<Value>& get_avail_expr_in(){return avail_expr_in;}
    PtrSet<Value>& get_avail_expr_out(){return avail_expr_out;}
    bool out_is_universal(){return universal;}

    /****************api about loop****************/
    int get_num(){return num_;}
    void set_num(int num){num_ = num;}

private:
    explicit BasicBlock(Ptr<Module> m, const std::string &name ,
                        Ptr<Function> parent );
    void init(Ptr<Module> m, const std::string &name ,
                        Ptr<Function> parent );
    PtrList<BasicBlock> pre_bbs_;
    PtrList<BasicBlock> succ_bbs_;
    PtrList<Instruction> instr_list_;
    Ptr<Function> parent_;
    PtrSet<BasicBlock> dom_frontier_;
    PtrSet<BasicBlock> rdom_frontier_;
    PtrSet<BasicBlock> rdoms_;
    Ptr<BasicBlock> idom_;
    PtrSet<Value> live_in;
    PtrSet<Value> live_out;
    PtrSet<Value> avail_expr_in;
    PtrSet<Value> avail_expr_out;
    bool universal = true;
    int num_;
};

}
}

#endif // _SYSYF_BASICBLOCK_H_