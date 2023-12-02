#ifndef _SYSYF_FUNCTION_H_
#define _SYSYF_FUNCTION_H_

#include <iterator>
#include <list>
#include <cstddef>
#include <map>
#ifdef DEBUG
#include <cassert>
#endif
#include <set>

#include "User.h"
#include "Module.h"
#include "BasicBlock.h"
#include "Type.h"

namespace SysYF
{
namespace IR
{
class Module;
class Argument;
class BasicBlock;
class Type;
class FunctionType;

class Function : public Value
{
public:
    ~Function() = default;
    static Ptr<Function> create(Ptr<FunctionType> ty, const std::string &name, Ptr<Module> parent);

    Ptr<FunctionType> get_function_type() const;

    Ptr<Type> get_return_type() const;

    void add_basic_block(Ptr<BasicBlock> bb);

    unsigned get_num_of_args() const;
    unsigned get_num_basic_blocks() const;
    
    Ptr<Module> get_parent() const;

    PtrList<Argument>::iterator arg_begin() { return arguments_.begin(); }
    PtrList<Argument>::iterator arg_end() { return arguments_.end(); }
    
    void remove(Ptr<BasicBlock>  bb);
    Ptr<BasicBlock> get_entry_block() { return *basic_blocks_.begin(); }

    PtrList<BasicBlock> &get_basic_blocks() { return basic_blocks_; }
    PtrList<Argument> &get_args() { return arguments_; }
    std::vector<PtrSet<Value>> &get_vreg_set(){ return vreg_set_;}
    
    bool is_declaration() { return basic_blocks_.empty(); }
    void set_unused_reg_num(std::set<int>& set){unused_reg_num_ = set;}
    std::set<int>& get_unused_reg_num(){return unused_reg_num_;}

    void set_instr_name();
    std::string print();

private:
    explicit Function(Ptr<FunctionType> ty, const std::string &name, Ptr<Module> parent);
    void init(Ptr<FunctionType> ty, const std::string &name, Ptr<Module> parent);
    void build_args();

private:
    PtrList<BasicBlock> basic_blocks_;    // basic blocks
    PtrList<Argument> arguments_;         // arguments
    std::vector<PtrSet<Value>> vreg_set_;
    Ptr<Module> parent_;
    std::set<int> unused_reg_num_;
    unsigned seq_cnt_;
    // unsigned num_args_;
    // We don't need this, all value inside function should be unnamed
    // std::map<std::string, Ptr<Value>> sym_table_;   // Symbol table of args/instructions
};

// Argument of Function, does not contain actual value
class Argument : public Value
{
public:
    static Ptr<Argument> create(Ptr<Type> ty, const std::string &name = "", Ptr<Function> f = nullptr,
                                unsigned arg_no = 0);
    ~Argument() = default;

    inline const Ptr<Function> get_parent() const { return parent_; }
    inline       Ptr<Function> get_parent()       { return parent_; }

    /// For example in "void foo(int a, float b)" a is 0 and b is 1.
    unsigned get_arg_no() const {
#ifdef DEBUG
        assert(parent_ && "can't get number of unparented arg");
#endif
        return arg_no_;
    }

    virtual std::string print() override ;
private:
    // Argument constructor.
    explicit Argument(Ptr<Type> ty, const std::string &name = "", Ptr<Function> f = nullptr,
                    unsigned arg_no = 0)
        : Value(ty, name), parent_(f), arg_no_(arg_no) {}
    Ptr<Function> parent_;
    unsigned arg_no_;  // argument No.
};

}
}
#endif // _SYSYF_FUNCTION_H_
