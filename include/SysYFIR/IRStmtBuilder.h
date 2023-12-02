#ifndef _SYSYF_IRSTMTBUILDER_H_
#define _SYSYF_IRSTMTBUILDER_H_

#include "BasicBlock.h"
#include "Instruction.h"
#include "Value.h"

namespace SysYF
{
namespace IR
{
class IRStmtBuilder {
private:
    Ptr<BasicBlock> BB_; 
    Ptr<Module> m_;
    explicit IRStmtBuilder(Ptr<BasicBlock> bb, Ptr<Module> m) : BB_(bb), m_(m) {};
    void init(Ptr<BasicBlock> bb, Ptr<Module> m) {}
public:
    static Ptr<IRStmtBuilder> create(Ptr<BasicBlock> bb, Ptr<Module> m) { RET_AFTER_INIT(IRStmtBuilder, bb, m); }
    ~IRStmtBuilder() = default;
    Ptr<Module> get_module(){return m_;}
    Ptr<BasicBlock> get_insert_block() { return this->BB_; }
    void set_insert_point(Ptr<BasicBlock> bb) { this->BB_ = bb; } //在某个基本块中插入指令
    Ptr<BinaryInst> create_iadd( Ptr<Value> lhs, Ptr<Value> rhs){ return BinaryInst::create_add( lhs, rhs, this->BB_, m_);}   //创建加法指令（以及其他算术指令）
    Ptr<BinaryInst> create_isub( Ptr<Value> lhs, Ptr<Value> rhs){ return BinaryInst::create_sub( lhs, rhs, this->BB_, m_);}
    Ptr<BinaryInst> create_imul( Ptr<Value> lhs, Ptr<Value> rhs){ return BinaryInst::create_mul( lhs, rhs, this->BB_, m_);}
    Ptr<BinaryInst> create_isdiv( Ptr<Value> lhs, Ptr<Value> rhs){ return BinaryInst::create_sdiv( lhs, rhs, this->BB_, m_);}
    Ptr<BinaryInst> create_isrem( Ptr<Value> lhs, Ptr<Value> rhs){ return BinaryInst::create_srem( lhs, rhs, this->BB_, m_);}

    Ptr<CmpInst> create_icmp_eq( Ptr<Value> lhs, Ptr<Value> rhs){ return CmpInst::create_cmp(CmpInst::EQ, lhs, rhs, this->BB_, m_); }
    Ptr<CmpInst> create_icmp_ne( Ptr<Value> lhs, Ptr<Value> rhs){ return CmpInst::create_cmp(CmpInst::NE, lhs, rhs, this->BB_, m_); }
    Ptr<CmpInst> create_icmp_gt( Ptr<Value> lhs, Ptr<Value> rhs){ return CmpInst::create_cmp(CmpInst::GT, lhs, rhs, this->BB_, m_); }
    Ptr<CmpInst> create_icmp_ge( Ptr<Value> lhs, Ptr<Value> rhs){ return CmpInst::create_cmp(CmpInst::GE, lhs, rhs, this->BB_, m_); }
    Ptr<CmpInst> create_icmp_lt( Ptr<Value> lhs, Ptr<Value> rhs){ return CmpInst::create_cmp(CmpInst::LT, lhs, rhs, this->BB_, m_); }
    Ptr<CmpInst> create_icmp_le( Ptr<Value> lhs, Ptr<Value> rhs){ return CmpInst::create_cmp(CmpInst::LE, lhs, rhs, this->BB_, m_); }

    Ptr<BinaryInst> create_fadd( Ptr<Value> lhs, Ptr<Value> rhs){ return BinaryInst::create_fadd( lhs, rhs, this->BB_, m_);}
    Ptr<BinaryInst> create_fsub( Ptr<Value> lhs, Ptr<Value> rhs){ return BinaryInst::create_fsub( lhs, rhs, this->BB_, m_);}
    Ptr<BinaryInst> create_fmul( Ptr<Value> lhs, Ptr<Value> rhs){ return BinaryInst::create_fmul( lhs, rhs, this->BB_, m_);}
    Ptr<BinaryInst> create_fdiv( Ptr<Value> lhs, Ptr<Value> rhs){ return BinaryInst::create_fdiv( lhs, rhs, this->BB_, m_);}
    
    Ptr<FCmpInst> create_fcmp_eq( Ptr<Value> lhs, Ptr<Value> rhs){ return FCmpInst::create_fcmp(FCmpInst::EQ, lhs, rhs, this->BB_, m_); }
    Ptr<FCmpInst> create_fcmp_ne( Ptr<Value> lhs, Ptr<Value> rhs){ return FCmpInst::create_fcmp(FCmpInst::NE, lhs, rhs, this->BB_, m_); }
    Ptr<FCmpInst> create_fcmp_gt( Ptr<Value> lhs, Ptr<Value> rhs){ return FCmpInst::create_fcmp(FCmpInst::GT, lhs, rhs, this->BB_, m_); }
    Ptr<FCmpInst> create_fcmp_ge( Ptr<Value> lhs, Ptr<Value> rhs){ return FCmpInst::create_fcmp(FCmpInst::GE, lhs, rhs, this->BB_, m_); }
    Ptr<FCmpInst> create_fcmp_lt( Ptr<Value> lhs, Ptr<Value> rhs){ return FCmpInst::create_fcmp(FCmpInst::LT, lhs, rhs, this->BB_, m_); }
    Ptr<FCmpInst> create_fcmp_le( Ptr<Value> lhs, Ptr<Value> rhs){ return FCmpInst::create_fcmp(FCmpInst::LE, lhs, rhs, this->BB_, m_); }

    Ptr<CallInst> create_call(Ptr<Value> func, PtrVec<Value> args)
    {
#ifdef DEBUG
        assert( dynamic_pointer_cast<Function>(func) && "func must be Ptr<Function> type");
#endif
        return CallInst::create(static_pointer_cast<Function>(func) ,args, this->BB_); 
    }
    
    Ptr<BranchInst> create_br(Ptr<BasicBlock> if_true){ return BranchInst::create_br(if_true, this->BB_); }
    Ptr<BranchInst> create_cond_br(Ptr<Value> cond, Ptr<BasicBlock> if_true, Ptr<BasicBlock> if_false){ return BranchInst::create_cond_br(cond, if_true, if_false,this->BB_); }
    
    Ptr<ReturnInst> create_ret(Ptr<Value> val) { return ReturnInst::create_ret(val,this->BB_); }
    Ptr<ReturnInst> create_void_ret() { return ReturnInst::create_void_ret(this->BB_); }

    Ptr<GetElementPtrInst> create_gep(Ptr<Value> ptr, PtrVec<Value> idxs) { return GetElementPtrInst::create_gep(ptr, idxs, this->BB_); }

    Ptr<StoreInst> create_store(Ptr<Value> val, Ptr<Value> ptr) { return StoreInst::create_store(val, ptr, this->BB_ ); }
    Ptr<LoadInst>  create_load(Ptr<Type> ty, Ptr<Value> ptr) { return LoadInst::create_load(ty, ptr, this->BB_); }
    Ptr<LoadInst>  create_load(Ptr<Value> ptr) 
    {
#ifdef DEBUG
        assert( ptr->get_type()->is_pointer_type() && "ptr must be pointer type" );
#endif
        return LoadInst::create_load(ptr->get_type()->get_pointer_element_type(), ptr, this->BB_); 
    }

    Ptr<AllocaInst> create_alloca(Ptr<Type> ty) { return AllocaInst::create_alloca(ty, this->BB_); }
    Ptr<ZextInst> create_zext(Ptr<Value> val, Ptr<Type> ty) { return ZextInst::create_zext(val, ty, this->BB_); }
    Ptr<FpToSiInst> create_fptosi(Ptr<Value> val, Ptr<Type> ty) { return FpToSiInst::create_fptosi(val, ty, this->BB_); }
    Ptr<SiToFpInst> create_sitofp(Ptr<Value> val, Ptr<Type> ty) { return SiToFpInst::create_sitofp(val, ty, this->BB_); }
};

}
}

#endif // _SYSYF_IRSTMTBUILDER_H_
