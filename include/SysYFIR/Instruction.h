#ifndef _SYSYF_INSTRUCTION_H_
#define _SYSYF_INSTRUCTION_H_

#include "User.h"
#include "Type.h"
#include "Constant.h"
#include "BasicBlock.h"

namespace SysYF
{
namespace IR
{
class BasicBlock;
class Function;
class Instruction;

class Instruction : public User
{
public:
    enum OpID
    {
        // Terminator Instructions
        ret,
        br,
        // Standard binary operators
        add,
        sub,
        mul,
        sdiv,
        srem,
        // Float binaru opeartors
        fadd,
        fsub,
        fmul,
        fdiv,
        // Memory operators
        alloca,
        load,
        store,
        // Other operators
        cmp,
        fcmp,
        phi,
        call,
        getelementptr, 
        // Zero extend
        zext,
        // type cast bewteen float and singed integer
        fptosi,
        sitofp,
    };
    inline const Ptr<BasicBlock> get_parent() const { return parent_; }
    inline Ptr<BasicBlock> get_parent() { return parent_; }
    void set_parent(Ptr<BasicBlock> parent) { this->parent_ = parent; }
    // Return the function this instruction belongs to.
    Ptr<Function> get_function();
    Ptr<Module> get_module();

    OpID get_instr_type() { return op_id_; }
    std::string get_instr_op_name() {
        switch (op_id_)
        {
            case ret: return "ret"; break;
            case br: return "br"; break;
            case add: return "add"; break;
            case sub: return "sub"; break;
            case mul: return "mul"; break;
            case sdiv: return "sdiv"; break;
            case srem: return "srem"; break;
            case fadd: return "fadd"; break;
            case fsub: return "fsub"; break;
            case fmul: return "fmul"; break;
            case fdiv: return "fdiv"; break;
            case alloca: return "alloca"; break;
            case load: return "load"; break;
            case store: return "store"; break;
            case cmp: return "cmp"; break;
            case fcmp: return "fcmp"; break;
            case phi: return "phi"; break;
            case call: return "call"; break;
            case getelementptr: return "getelementptr"; break;
            case zext: return "zext"; break;
            case fptosi: return "fptosi"; break;
            case sitofp: return "sitofp"; break;
        
        default: return ""; break;
        }
    }



    bool is_void() { return ((op_id_ == ret) || (op_id_ == br) || (op_id_ == store) || (op_id_ == call && this->get_type()->is_void_type())); }

    bool is_phi() { return op_id_ == phi; }
    bool is_store() { return op_id_ == store; }
    bool is_alloca() { return op_id_ == alloca; }
    bool is_ret() { return op_id_ == ret; }
    bool is_load() { return op_id_ == load; }
    bool is_br() { return op_id_ == br; }

    bool is_add() { return op_id_ == add; }
    bool is_sub() { return op_id_ == sub; }
    bool is_mul() { return op_id_ == mul; }
    bool is_div() { return op_id_ == sdiv; }
    bool is_rem() { return op_id_ == srem; }

    bool is_fadd() { return op_id_ == fadd; }
    bool is_fsub() { return op_id_ == fsub; }
    bool is_fmul() { return op_id_ == fmul; }
    bool is_fdiv() { return op_id_ == fdiv; }

    bool is_cmp() { return op_id_ == cmp; }
    bool is_fcmp() { return op_id_ == fcmp; }

    bool is_call() { return op_id_ == call; }
    bool is_gep() { return op_id_ == getelementptr; }
    bool is_zext() { return op_id_ == zext; }
    bool is_fptosi() { return op_id_ == fptosi; }
    bool is_sitofp() { return op_id_ == sitofp; }

    bool isBinary()
    {
        return (is_add() || is_sub() || is_mul() || is_div() || is_rem() || 
                is_fadd() || is_fsub() || is_fmul() || is_fdiv()) && 
                (get_num_operand() == 2);
    }

    bool isTerminator() { return is_br() || is_ret(); }

    void set_id(int id){id_ = id;}
    int get_id() const{return id_;}

private:
    OpID op_id_;
    int id_;
    unsigned num_ops_;
    Ptr<BasicBlock> parent_;
    // must be called after Instruction() in any derived class
    void insert_to_bb();
    
protected:
    // create instruction, but not insert to bb (insert to bb in method create in the derived class)
    // ty here is result type
    explicit Instruction(Ptr<Type> ty, OpID id, unsigned num_ops, Ptr<BasicBlock> parent = nullptr);
    void init(Ptr<Type> ty, OpID id, unsigned num_ops, Ptr<BasicBlock> parent = nullptr);
};

class BinaryInst : public Instruction
{
private:
    explicit BinaryInst(Ptr<Type> ty, OpID id, Ptr<Value> v1, Ptr<Value> v2,
               Ptr<BasicBlock> bb);

public:
    static Ptr<BinaryInst> create_add(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m);
    static Ptr<BinaryInst> create_sub(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m);
    static Ptr<BinaryInst> create_mul(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m);
    static Ptr<BinaryInst> create_sdiv(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m);
    static Ptr<BinaryInst> create_srem(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m);
    static Ptr<BinaryInst> create_fadd(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m);
    static Ptr<BinaryInst> create_fsub(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m);
    static Ptr<BinaryInst> create_fmul(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m);
    static Ptr<BinaryInst> create_fdiv(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m);

    virtual std::string print() override;

private:
    void init(Ptr<Type> ty, OpID id, Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb);
    void assertValid() {}
};

class CmpInst : public Instruction
{
public:
    enum CmpOp
    {
        EQ, // ==
        NE, // !=
        GT, // >
        GE, // >=
        LT, // <
        LE  // <=
    };

private:
    explicit CmpInst(Ptr<Type> ty, CmpOp op, Ptr<Value> lhs, Ptr<Value> rhs,
            Ptr<BasicBlock> bb);

public:
    static Ptr<CmpInst> create_cmp(CmpOp op, Ptr<Value> lhs, Ptr<Value> rhs,
                               Ptr<BasicBlock> bb, Ptr<Module> m);

    CmpOp get_cmp_op() { return cmp_op_; }

    virtual std::string print() override;

private:
    CmpOp cmp_op_;
    void init(Ptr<Type> ty, CmpOp op, Ptr<Value> lhs, Ptr<Value> rhs, Ptr<BasicBlock> bb);
    void assertValid() {}
};

class FCmpInst : public Instruction
{
public:
    enum CmpOp
    {
        EQ, // ==
        NE, // !=
        GT, // >
        GE, // >=
        LT, // <
        LE  // <=
    };

private:
    explicit FCmpInst(Ptr<Type> ty, CmpOp op, Ptr<Value> lhs, Ptr<Value> rhs,
            Ptr<BasicBlock> bb);
    void init(Ptr<Type> ty, CmpOp op, Ptr<Value> lhs, Ptr<Value> rhs, Ptr<BasicBlock> bb);

public:
    static Ptr<FCmpInst> create_fcmp(CmpOp op, Ptr<Value> lhs, Ptr<Value> rhs,
                               Ptr<BasicBlock> bb, Ptr<Module> m);

    CmpOp get_cmp_op() { return cmp_op_; }

    virtual std::string print() override;

private:
    CmpOp cmp_op_;

    void assertValid() {}
};

class CallInst : public Instruction
{
private:
    explicit CallInst(Ptr<Function> func, PtrVec<Value> args, Ptr<BasicBlock> bb);
    void init(Ptr<Function> func, PtrVec<Value> args, Ptr<BasicBlock> bb);
    explicit CallInst(Ptr<Type> ret_ty, PtrVec<Value> args, Ptr<BasicBlock> bb);
    void init(Ptr<Type> ret_ty, PtrVec<Value> args, Ptr<BasicBlock> bb);

public:
    static Ptr<CallInst> create(Ptr<Function> func, PtrVec<Value> args, Ptr<BasicBlock> bb);
    Ptr<FunctionType> get_function_type() const;

    virtual std::string print() override;

};

class BranchInst : public Instruction
{
private:
    explicit BranchInst(Ptr<Value> cond, Ptr<BasicBlock> if_true, Ptr<BasicBlock> if_false,
               Ptr<BasicBlock> bb);
    void init(Ptr<Value> cond, Ptr<BasicBlock> if_true, Ptr<BasicBlock> if_false,
              Ptr<BasicBlock> bb);
    explicit BranchInst(Ptr<Value> cond, Ptr<BasicBlock> bb);
    void init(Ptr<Value> cond, Ptr<BasicBlock> bb);
    explicit BranchInst(Ptr<BasicBlock> if_true, Ptr<BasicBlock> bb);
    void init(Ptr<BasicBlock> if_true, Ptr<BasicBlock> bb);
    explicit BranchInst(Ptr<BasicBlock> bb);
    void init(Ptr<BasicBlock> bb);

public:
    static Ptr<BranchInst> create_cond_br(Ptr<Value> cond, Ptr<BasicBlock> if_true, Ptr<BasicBlock> if_false,
                                      Ptr<BasicBlock> bb);
    static Ptr<BranchInst> create_br(Ptr<BasicBlock> if_true, Ptr<BasicBlock> bb);

    bool is_cond_br() const;

    virtual std::string print() override;

};

class ReturnInst : public Instruction
{
private:
    explicit ReturnInst(Ptr<Value> val, Ptr<BasicBlock> bb);
    void init(Ptr<Value> val, Ptr<BasicBlock> bb);
    explicit ReturnInst(Ptr<BasicBlock> bb);
    void init(Ptr<BasicBlock> bb);

public:
    static Ptr<ReturnInst> create_ret(Ptr<Value> val, Ptr<BasicBlock> bb);
    static Ptr<ReturnInst> create_void_ret(Ptr<BasicBlock> bb);
    bool is_void_ret() const;

    virtual std::string print() override;

};

class GetElementPtrInst : public Instruction
{
private:
    explicit GetElementPtrInst(Ptr<Value> ptr, PtrVec<Value> idxs, Ptr<BasicBlock> bb);
    void init(Ptr<Value> ptr, PtrVec<Value> idxs, Ptr<BasicBlock> bb);

public:
    static Ptr<Type> get_element_type(Ptr<Value> ptr, PtrVec<Value> idxs);
    static Ptr<GetElementPtrInst> create_gep(Ptr<Value> ptr, PtrVec<Value> idxs, Ptr<BasicBlock> bb);
    Ptr<Type> get_element_type() const;

    virtual std::string print() override;

private:
    Ptr<Type> element_ty_;
};

class StoreInst : public Instruction
{
private:
    explicit StoreInst(Ptr<Value> val, Ptr<Value> ptr, Ptr<BasicBlock> bb);
    void init(Ptr<Value> val, Ptr<Value> ptr, Ptr<BasicBlock> bb);

public:
    static Ptr<StoreInst> create_store(Ptr<Value> val, Ptr<Value> ptr, Ptr<BasicBlock> bb);

    Ptr<Value> get_rval() { return this->get_operand(0); }
    Ptr<Value> get_lval() { return this->get_operand(1); }

    virtual std::string print() override;

};

class LoadInst : public Instruction
{
private:
    explicit LoadInst(Ptr<Type> ty, Ptr<Value> ptr, Ptr<BasicBlock> bb);
    void init(Ptr<Type> ty, Ptr<Value> ptr, Ptr<BasicBlock> bb);

public:
    static Ptr<LoadInst> create_load(Ptr<Type> ty, Ptr<Value> ptr, Ptr<BasicBlock> bb);
    Ptr<Value> get_lval() { return this->get_operand(0); }

    Ptr<Type> get_load_type() const;

    virtual std::string print() override;

};

class AllocaInst : public Instruction
{
private:
    explicit AllocaInst(Ptr<Type> ty, Ptr<BasicBlock> bb);
    void init(Ptr<Type> ty, Ptr<BasicBlock> bb);

public:
    static Ptr<AllocaInst> create_alloca(Ptr<Type> ty, Ptr<BasicBlock> bb);

    Ptr<Type> get_alloca_type() const;

    virtual std::string print() override;

private:
    Ptr<Type> alloca_ty_;
};

class ZextInst : public Instruction
{
private:
    explicit ZextInst(OpID op, Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb);
    void init(OpID op, Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb);

public:
    static Ptr<ZextInst> create_zext(Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb);

    Ptr<Type> get_dest_type() const;

    virtual std::string print() override;

private:
    Ptr<Type> dest_ty_;
};

class FpToSiInst : public Instruction
{
private:
    explicit FpToSiInst(OpID op, Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb);
    void init(OpID op, Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb);

public:
    static Ptr<FpToSiInst> create_fptosi(Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb);

    Ptr<Type> get_dest_type() const;

    virtual std::string print() override;

private:
    Ptr<Type> dest_ty_;
};

class SiToFpInst : public Instruction
{
private:
    explicit SiToFpInst(OpID op, Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb);
    void init(OpID op, Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb);

public:
    static Ptr<SiToFpInst> create_sitofp(Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb);

    Ptr<Type> get_dest_type() const;

    virtual std::string print() override;

private:
    Ptr<Type> dest_ty_;
};

class PhiInst : public Instruction
{
private:
    explicit PhiInst(OpID op, PtrVec<Value> vals, PtrVec<BasicBlock> val_bbs, Ptr<Type> ty, Ptr<BasicBlock> bb);
    void init(OpID op, PtrVec<Value> vals, PtrVec<BasicBlock> val_bbs, Ptr<Type> ty, Ptr<BasicBlock> bb);

public:
    static Ptr<PhiInst> create_phi(Ptr<Type> ty, Ptr<BasicBlock> bb);
    Ptr<Value> get_lval() { return l_val_; }
    void set_lval(Ptr<Value> l_val) { l_val_ = l_val; }
    void add_phi_pair_operand(Ptr<Value> val, Ptr<Value> pre_bb)
    {
        this->add_operand(val);
        this->add_operand(pre_bb);
    }
    virtual std::string print() override;

private:
    Ptr<Value> l_val_;

};

}
}

#endif // _SYSYF_INSTRUCTION_H_
