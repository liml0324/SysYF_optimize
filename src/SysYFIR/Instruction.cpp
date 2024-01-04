#include "Type.h"
#include "Module.h"
#include "Function.h"
#include "BasicBlock.h"
#include "Instruction.h"
#include "IRPrinter.h"
#include "internal_macros.h"

#ifdef DEBUG
#include <cassert>
#endif
#include <vector>
#include <algorithm>

namespace SysYF
{
namespace IR
{
Instruction::Instruction(Ptr<Type> ty, OpID id, unsigned num_ops, Ptr<BasicBlock> parent)
    : User(ty, "", num_ops), op_id_(id), num_ops_(num_ops), parent_(parent)
{
    
}

void Instruction::insert_to_bb()
{ 
    parent_ -> add_instruction(dynamic_pointer_cast<Instruction>(shared_from_this())); 
}

void Instruction::init(Ptr<Type> ty, OpID id, unsigned num_ops, Ptr<BasicBlock> parent) 
{
    insert_to_bb();
}

Ptr<Function> Instruction::get_function()
{ 
    return parent_->get_parent(); 
}

Ptr<Module> Instruction::get_module() 
{ 
    return parent_->get_module(); 
}

BinaryInst::BinaryInst(Ptr<Type> ty, OpID id, Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb)
    : Instruction(ty, id, 2, bb)
{
    
}

void BinaryInst::init(Ptr<Type> ty, OpID id, Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb)
{
    Instruction::init(ty, id, 2, bb);
    set_operand(0, v1);
    set_operand(1, v2);
}

Ptr<BinaryInst> BinaryInst::create_add(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m)
{
    RET_AFTER_INIT(BinaryInst, v1->get_type()->is_pointer_type() ? v1->get_type() : v2->get_type(), Instruction::add, v1, v2, bb);
}

Ptr<BinaryInst> BinaryInst::create_sub(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m)
{
    RET_AFTER_INIT(BinaryInst, Type::get_int32_type(m), Instruction::sub, v1, v2, bb);
}

Ptr<BinaryInst> BinaryInst::create_mul(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m)
{
    RET_AFTER_INIT(BinaryInst, Type::get_int32_type(m), Instruction::mul, v1, v2, bb);
}

Ptr<BinaryInst> BinaryInst::create_sdiv(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m)
{
    RET_AFTER_INIT(BinaryInst, Type::get_int32_type(m), Instruction::sdiv, v1, v2, bb);
}

Ptr<BinaryInst> BinaryInst::create_srem(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m)
{
    RET_AFTER_INIT(BinaryInst, Type::get_int32_type(m), Instruction::srem, v1, v2, bb);
}

Ptr<BinaryInst> BinaryInst::create_fadd(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m)
{
    RET_AFTER_INIT(BinaryInst, Type::get_float_type(m), Instruction::fadd, v1, v2, bb);
}

Ptr<BinaryInst> BinaryInst::create_fsub(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m)
{
    RET_AFTER_INIT(BinaryInst, Type::get_float_type(m), Instruction::fsub, v1, v2, bb);
}

Ptr<BinaryInst> BinaryInst::create_fmul(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m)
{
    RET_AFTER_INIT(BinaryInst, Type::get_float_type(m), Instruction::fmul, v1, v2, bb);
}

Ptr<BinaryInst> BinaryInst::create_fdiv(Ptr<Value> v1, Ptr<Value> v2, Ptr<BasicBlock> bb, Ptr<Module> m)
{
    RET_AFTER_INIT(BinaryInst, Type::get_float_type(m), Instruction::fdiv, v1, v2, bb);
}

std::string BinaryInst::print()
{
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += this->get_module()->get_instr_op_name( this->get_instr_type() );
    instr_ir += " ";
    instr_ir += this->get_operand(0)->get_type()->print();
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), false);
    instr_ir += ", ";
    if (Type::is_eq_type(this->get_operand(0)->get_type(), this->get_operand(1)->get_type()))
    {
        instr_ir += print_as_op(this->get_operand(1), false);
    }
    else
    {
        instr_ir += print_as_op(this->get_operand(1), true);
    }
    return instr_ir;
}

CmpInst::CmpInst(Ptr<Type> ty, CmpOp op, Ptr<Value> lhs, Ptr<Value> rhs, 
            Ptr<BasicBlock> bb)
    : Instruction(ty, Instruction::cmp, 2, bb), cmp_op_(op)
{

}

void CmpInst::init(Ptr<Type> ty, CmpOp op, Ptr<Value> lhs, Ptr<Value> rhs, Ptr<BasicBlock> bb)
{
    Instruction::init(ty, Instruction::cmp, 2, bb);
    set_operand(0, lhs);
    set_operand(1, rhs);
}

Ptr<CmpInst> CmpInst::create_cmp(CmpOp op, Ptr<Value> lhs, Ptr<Value> rhs, 
                        Ptr<BasicBlock> bb, Ptr<Module> m)
{
    RET_AFTER_INIT(CmpInst, m->get_int1_type(), op, lhs, rhs, bb);
}

std::string CmpInst::print()
{
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += this->get_module()->get_instr_op_name( this->get_instr_type() );
    instr_ir += " ";
    instr_ir += print_cmp_type(this->cmp_op_);
    instr_ir += " ";
    instr_ir += this->get_operand(0)->get_type()->print();
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), false);   
    instr_ir += ", ";
    if (Type::is_eq_type(this->get_operand(0)->get_type(), this->get_operand(1)->get_type()))
    {
        instr_ir += print_as_op(this->get_operand(1), false);
    }
    else
    {
        instr_ir += print_as_op(this->get_operand(1), true);
    }
    return instr_ir;
}

FCmpInst::FCmpInst(Ptr<Type> ty, CmpOp op, Ptr<Value> lhs, Ptr<Value> rhs, 
            Ptr<BasicBlock> bb)
    : Instruction(ty, Instruction::fcmp, 2, bb), cmp_op_(op)
{

}

void FCmpInst::init(Ptr<Type> ty, CmpOp op, Ptr<Value> lhs, Ptr<Value> rhs, Ptr<BasicBlock> bb)
{
    Instruction::init(ty, Instruction::fcmp, 2, bb);
    set_operand(0, lhs);
    set_operand(1, rhs);
}

Ptr<FCmpInst> FCmpInst::create_fcmp(CmpOp op, Ptr<Value> lhs, Ptr<Value> rhs, 
                        Ptr<BasicBlock> bb, Ptr<Module> m)
{
    RET_AFTER_INIT(FCmpInst, m->get_int1_type(), op, lhs, rhs, bb);
}

std::string FCmpInst::print()
{
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += this->get_module()->get_instr_op_name( this->get_instr_type() );
    instr_ir += " ";
    instr_ir += print_fcmp_type(this->cmp_op_);
    instr_ir += " ";
    instr_ir += this->get_operand(0)->get_type()->print();
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), false);   
    instr_ir += ", ";
    if (Type::is_eq_type(this->get_operand(0)->get_type(), this->get_operand(1)->get_type()))
    {
        instr_ir += print_as_op(this->get_operand(1), false);
    }
    else
    {
        instr_ir += print_as_op(this->get_operand(1), true);
    }
    return instr_ir;
}

CallInst::CallInst(Ptr<Function> func, PtrVec<Value>  args, Ptr<BasicBlock> bb)
    : Instruction(func->get_return_type(), Instruction::call, args.size() + 1, bb)
{
#ifdef DEBUG
    assert(func->get_num_of_args() == args.size());
#endif
}

void CallInst::init(Ptr<Function> func, PtrVec<Value> args, Ptr<BasicBlock> bb)
{
    Instruction::init(func->get_return_type(), Instruction::call, args.size() + 1, bb);
    int num_ops = args.size() + 1; 
    set_operand(0, func);
    for (int i = 1; i < num_ops; i++) {
        set_operand(i, args[i-1]);
    }
}

CallInst::CallInst(Ptr<Type> ret_ty, PtrVec<Value>  args, Ptr<BasicBlock> bb)
    : Instruction(ret_ty, Instruction::call, args.size() + 1, bb)
{
    
}

void CallInst::init(Ptr<Type> ret_ty, PtrVec<Value>  args, Ptr<BasicBlock> bb)
{
    Instruction::init(ret_ty, Instruction::call, args.size() + 1, bb);
    int num_ops = args.size() + 1; 
    for (int i = 1; i < num_ops; i++) {
        set_operand(i, args[i-1]);
    }
}

Ptr<CallInst> CallInst::create(Ptr<Function> func, PtrVec<Value>  args, Ptr<BasicBlock> bb)
{
    RET_AFTER_INIT(CallInst, func, args, bb);
}

Ptr<FunctionType> CallInst::get_function_type() const
{
    return static_pointer_cast<FunctionType>(get_operand(0)->get_type());
}

std::string CallInst::print()
{
    std::string instr_ir;
    if( !this->is_void() )
    {
        instr_ir += "%";
        instr_ir += this->get_name();
        instr_ir += " = ";
    }
    instr_ir += this->get_module()->get_instr_op_name( this->get_instr_type() );
    instr_ir += " ";
    instr_ir += this->get_function_type()->get_return_type()->print();    
    
    instr_ir += " ";
#ifdef DEBUG
    assert(dynamic_pointer_cast<Function>(this->get_operand(0)) && "Wrong call operand function");
#endif
    instr_ir += print_as_op(this->get_operand(0), false);
    instr_ir += "(";
    for (unsigned int i = 1; i < this->get_num_operand(); i++)
    {
        if( i > 1 )
            instr_ir += ", ";
        instr_ir += this->get_operand(i)->get_type()->print();
        instr_ir += " ";
        instr_ir += print_as_op(this->get_operand(i), false);
    }
    instr_ir += ")";
    return instr_ir;
}

BranchInst::BranchInst(Ptr<Value> cond, Ptr<BasicBlock> if_true, Ptr<BasicBlock> if_false,
                    Ptr<BasicBlock> bb)
    : Instruction(Type::get_void_type(if_true->get_module()), Instruction::br, 3, bb)
{
    
}

void BranchInst::init(Ptr<Value> cond, Ptr<BasicBlock> if_true, Ptr<BasicBlock> if_false,
                    Ptr<BasicBlock> bb)
{
    Instruction::init(Type::get_void_type(if_true->get_module()), Instruction::br, 3, bb);
    set_operand(0, cond);
    set_operand(1, if_true);
    set_operand(2, if_false);
}

BranchInst::BranchInst(Ptr<Value> cond, Ptr<BasicBlock> bb)
    : Instruction(Type::get_void_type(bb->get_module()), Instruction::br, 3, bb)
{
    
}

void BranchInst::init(Ptr<Value> cond, Ptr<BasicBlock> bb)
{
    Instruction::init(Type::get_void_type(bb->get_module()), Instruction::br, 3, bb);
    set_operand(0, cond);
}

BranchInst::BranchInst(Ptr<BasicBlock> if_true, Ptr<BasicBlock> bb)
    : Instruction(Type::get_void_type(if_true->get_module()), Instruction::br, 1, bb)
{
    
}

void BranchInst::init(Ptr<BasicBlock> if_true, Ptr<BasicBlock> bb)
{
    Instruction::init(Type::get_void_type(if_true->get_module()), Instruction::br, 1, bb);
    set_operand(0, if_true);
}

BranchInst::BranchInst(Ptr<BasicBlock> bb)
    : Instruction(Type::get_void_type(bb->get_module()), Instruction::br, 1, bb)
{

}

void BranchInst::init(Ptr<BasicBlock> bb)
{
    Instruction::init(Type::get_void_type(bb->get_module()), Instruction::br, 1, bb);
}

Ptr<BranchInst> BranchInst::create_cond_br(Ptr<Value> cond, Ptr<BasicBlock> if_true, Ptr<BasicBlock> if_false,
                                    Ptr<BasicBlock> bb)
{
    if_true->add_pre_basic_block(bb);
    if_false->add_pre_basic_block(bb);
    bb->add_succ_basic_block(if_false);
    bb->add_succ_basic_block(if_true);

    RET_AFTER_INIT(BranchInst, cond, if_true, if_false, bb);
}

Ptr<BranchInst> BranchInst::create_br(Ptr<BasicBlock> if_true, Ptr<BasicBlock> bb)
{
    if_true->add_pre_basic_block(bb);
    bb->add_succ_basic_block(if_true);

    RET_AFTER_INIT(BranchInst, if_true, bb);
}

bool BranchInst::is_cond_br() const
{
    return get_num_operand() == 3;
}

std::string BranchInst::print()
{
    std::string instr_ir;
    instr_ir += this->get_module()->get_instr_op_name( this->get_instr_type() );
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), true);
    if( is_cond_br() )
    {
        instr_ir += ", ";
        instr_ir += print_as_op(this->get_operand(1), true);
        instr_ir += ", ";
        instr_ir += print_as_op(this->get_operand(2), true);
    }
    return instr_ir;
}

ReturnInst::ReturnInst(Ptr<Value> val, Ptr<BasicBlock> bb)
    : Instruction(Type::get_void_type(bb->get_module()), Instruction::ret, 1, bb)
{
    
}

void ReturnInst::init(Ptr<Value> val, Ptr<BasicBlock> bb)
{
    Instruction::init(Type::get_void_type(bb->get_module()), Instruction::ret, 1, bb);
    set_operand(0, val);
}

ReturnInst::ReturnInst(Ptr<BasicBlock> bb)
    : Instruction(Type::get_void_type(bb->get_module()), Instruction::ret, 0, bb)
{

}

void ReturnInst::init(Ptr<BasicBlock> bb)
{
    Instruction::init(Type::get_void_type(bb->get_module()), Instruction::ret, 0, bb);
}

Ptr<ReturnInst> ReturnInst::create_ret(Ptr<Value> val, Ptr<BasicBlock> bb)
{
    RET_AFTER_INIT(ReturnInst, val, bb);
}

Ptr<ReturnInst> ReturnInst::create_void_ret(Ptr<BasicBlock> bb)
{
    RET_AFTER_INIT(ReturnInst, bb);
}

bool ReturnInst::is_void_ret() const
{
    return get_num_operand() == 0;
}

std::string ReturnInst::print()
{
    std::string instr_ir;
    instr_ir += this->get_module()->get_instr_op_name( this->get_instr_type() );
    instr_ir += " ";
    if ( !is_void_ret() )
    {
        instr_ir += this->get_operand(0)->get_type()->print();
        instr_ir += " ";
        instr_ir += print_as_op(this->get_operand(0), false);
    }
    else
    {
        instr_ir += "void";
    }
    
    return instr_ir;
}

GetElementPtrInst::GetElementPtrInst(Ptr<Value> ptr, PtrVec<Value>  idxs, Ptr<BasicBlock> bb)
    : Instruction(PointerType::get(get_element_type(ptr, idxs)), Instruction::getelementptr, 
                1 + idxs.size(), bb)
{
    
}

void GetElementPtrInst::init(Ptr<Value> ptr, PtrVec<Value>  idxs, Ptr<BasicBlock> bb)
{
    Instruction::init(PointerType::get(get_element_type(ptr, idxs)), Instruction::getelementptr, 
                1 + idxs.size(), bb);
    set_operand(0, ptr);
    for (unsigned int i = 0; i < idxs.size(); i++) {
        set_operand(i + 1, idxs[i]);
    }
    element_ty_ = get_element_type(ptr, idxs);
}

Ptr<Type> GetElementPtrInst::get_element_type(Ptr<Value> ptr, PtrVec<Value>  idxs)
{

    Ptr<Type> ty = ptr->get_type()->get_pointer_element_type();
    if (ty->is_array_type())
    {
        Ptr<ArrayType> arr_ty = static_pointer_cast<ArrayType>(ty);
        for (unsigned int i = 1; i < idxs.size(); i++) {
            ty = arr_ty->get_element_type();
            if (i < idxs.size() - 1) {
#ifdef DEBUG
                assert(ty->is_array_type() && "Index error!");
#endif
            }
            if (ty->is_array_type()) {
                arr_ty = static_pointer_cast<ArrayType>(ty);
            }
        }
    }
    return ty;
}

Ptr<Type> GetElementPtrInst::get_element_type() const
{
    return element_ty_;
}

Ptr<GetElementPtrInst> GetElementPtrInst::create_gep(Ptr<Value> ptr, PtrVec<Value>  idxs, Ptr<BasicBlock> bb)
{
    RET_AFTER_INIT(GetElementPtrInst, ptr, idxs, bb);
}

std::string GetElementPtrInst::print()
{
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += this->get_module()->get_instr_op_name( this->get_instr_type() );
    instr_ir += " ";
#ifdef DEBUG
    assert(this->get_operand(0)->get_type()->is_pointer_type());
#endif
    instr_ir += this->get_operand(0)->get_type()->get_pointer_element_type()->print();
    instr_ir += ", ";
    for (unsigned int i = 0; i < this->get_num_operand(); i++)
    {
        if( i > 0 )
            instr_ir += ", ";
        instr_ir += this->get_operand(i)->get_type()->print();
        instr_ir += " ";
        instr_ir += print_as_op(this->get_operand(i), false);
    }
    return instr_ir;
}

StoreInst::StoreInst(Ptr<Value> val, Ptr<Value> ptr, Ptr<BasicBlock> bb)
    : Instruction(Type::get_void_type(bb->get_module()), Instruction::store, 2, bb)
{
    
}

void StoreInst::init(Ptr<Value> val, Ptr<Value> ptr, Ptr<BasicBlock> bb)
{
    Instruction::init(Type::get_void_type(bb->get_module()), Instruction::store, 2, bb);
    set_operand(0, val);
    set_operand(1, ptr);
}

Ptr<StoreInst> StoreInst::create_store(Ptr<Value> val, Ptr<Value> ptr, Ptr<BasicBlock> bb)
{
    RET_AFTER_INIT(StoreInst, val, ptr, bb);
}

std::string StoreInst::print()
{
    std::string instr_ir;
    instr_ir += this->get_module()->get_instr_op_name( this->get_instr_type() );
    instr_ir += " ";
    instr_ir += this->get_operand(0)->get_type()->print();
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), false);
    instr_ir += ", ";
    instr_ir += print_as_op(this->get_operand(1), true);
    return instr_ir;
}

LoadInst::LoadInst(Ptr<Type> ty, Ptr<Value> ptr, Ptr<BasicBlock> bb)
    : Instruction(ty, Instruction::load, 1, bb)
{
#ifdef DEBUG
    assert(ptr->get_type()->is_pointer_type());
    assert(ty == static_pointer_cast<PointerType>(ptr->get_type())->get_element_type());
#endif
}

void LoadInst::init(Ptr<Type> ty, Ptr<Value> ptr, Ptr<BasicBlock> bb)
{
    Instruction::init(ty, Instruction::load, 1, bb);
    set_operand(0, ptr);
}

Ptr<LoadInst> LoadInst::create_load(Ptr<Type> ty, Ptr<Value> ptr, Ptr<BasicBlock> bb)
{
    RET_AFTER_INIT(LoadInst, ty, ptr, bb);
}

Ptr<Type> LoadInst::get_load_type() const
{
    return static_pointer_cast<PointerType>(get_operand(0)->get_type())->get_element_type();
}

std::string LoadInst::print()
{
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += this->get_module()->get_instr_op_name( this->get_instr_type() );
    instr_ir += " ";
#ifdef DEBUG
    assert(this->get_operand(0)->get_type()->is_pointer_type());
#endif
    instr_ir += this->get_operand(0)->get_type()->get_pointer_element_type()->print();
    instr_ir += ",";
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), true);
    return instr_ir;
}

AllocaInst::AllocaInst(Ptr<Type> ty, Ptr<BasicBlock> bb)
    : Instruction(PointerType::get(ty), Instruction::alloca, 0, bb), alloca_ty_(ty)
{

}

void AllocaInst::init(Ptr<Type> ty, Ptr<BasicBlock> bb)
{
    Instruction::init(PointerType::get(ty), Instruction::alloca, 0, bb);
}

Ptr<AllocaInst> AllocaInst::create_alloca(Ptr<Type> ty, Ptr<BasicBlock> bb)
{
    RET_AFTER_INIT(AllocaInst, ty, bb);
}

Ptr<Type> AllocaInst::get_alloca_type() const
{
    return alloca_ty_;
}

std::string AllocaInst::print()
{
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += this->get_module()->get_instr_op_name( this->get_instr_type() );
    instr_ir += " ";
    instr_ir += get_alloca_type()->print();
    return instr_ir;    
}

ZextInst::ZextInst(OpID op, Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb)
    : Instruction(ty, op, 1, bb), dest_ty_(ty)
{
    
}

void ZextInst::init(OpID op, Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb)
{
    Instruction::init(ty, op, 1, bb);
    set_operand(0, val);
}

Ptr<ZextInst> ZextInst::create_zext(Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb)
{
    RET_AFTER_INIT(ZextInst, Instruction::zext, val, ty, bb);
}

Ptr<Type> ZextInst::get_dest_type() const
{
    return dest_ty_;
}

std::string ZextInst::print()
{
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += this->get_module()->get_instr_op_name( this->get_instr_type() );
    instr_ir += " ";
    instr_ir += this->get_operand(0)->get_type()->print();
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), false);
    instr_ir += " to ";
    instr_ir += this->get_dest_type()->print();
    return instr_ir; 
}

FpToSiInst::FpToSiInst(OpID op, Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb)
    : Instruction(ty, op, 1, bb), dest_ty_(ty)
{
    
}

void FpToSiInst::init(OpID op, Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb)
{
    Instruction::init(ty, op, 1, bb);
    set_operand(0, val);
}

Ptr<FpToSiInst> FpToSiInst::create_fptosi(Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb)
{
    RET_AFTER_INIT(FpToSiInst, Instruction::fptosi, val, ty, bb);
}

Ptr<Type> FpToSiInst::get_dest_type() const
{
    return dest_ty_;
}

std::string FpToSiInst::print()
{
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += this->get_module()->get_instr_op_name( this->get_instr_type() );
    instr_ir += " ";
    instr_ir += this->get_operand(0)->get_type()->print();
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), false);
    instr_ir += " to ";
    instr_ir += this->get_dest_type()->print();
    return instr_ir; 
}

SiToFpInst::SiToFpInst(OpID op, Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb)
    : Instruction(ty, op, 1, bb), dest_ty_(ty)
{
    
}

void SiToFpInst::init(OpID op, Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb)
{
    Instruction::init(ty, op, 1, bb);
    set_operand(0, val);
}

Ptr<SiToFpInst> SiToFpInst::create_sitofp(Ptr<Value> val, Ptr<Type> ty, Ptr<BasicBlock> bb)
{
    RET_AFTER_INIT(SiToFpInst, Instruction::sitofp, val, ty, bb);
}

Ptr<Type> SiToFpInst::get_dest_type() const
{
    return dest_ty_;
}

std::string SiToFpInst::print()
{
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += this->get_module()->get_instr_op_name( this->get_instr_type() );
    instr_ir += " ";
    instr_ir += this->get_operand(0)->get_type()->print();
    instr_ir += " ";
    instr_ir += print_as_op(this->get_operand(0), false);
    instr_ir += " to ";
    instr_ir += this->get_dest_type()->print();
    return instr_ir; 
}

PhiInst::PhiInst(OpID op, PtrVec<Value> vals, PtrVec<BasicBlock> val_bbs, Ptr<Type> ty, Ptr<BasicBlock> bb)
    : Instruction(ty, op, 2*vals.size())
{
    
}

void PhiInst::init(OpID op, PtrVec<Value> vals, PtrVec<BasicBlock> val_bbs, Ptr<Type> ty, Ptr<BasicBlock> bb)
{
    this->set_parent(bb);
    // Instruction::init(ty, op, 2*vals.size());
    for (unsigned int i = 0; i < vals.size(); i++)
    {
        set_operand(2*i, vals[i]);
        set_operand(2*i+1, val_bbs[i]);
    }
}

Ptr<PhiInst> PhiInst::create_phi( Ptr<Type> ty, Ptr<BasicBlock> bb)
{
    PtrVec<Value>  vals;
    PtrVec<BasicBlock>  val_bbs;
    RET_AFTER_INIT(PhiInst, Instruction::phi, vals, val_bbs, ty, bb);
}

std::string PhiInst::print()
{
    std::string instr_ir;
    instr_ir += "%";
    instr_ir += this->get_name();
    instr_ir += " = ";
    instr_ir += this->get_module()->get_instr_op_name( this->get_instr_type() );
    instr_ir += " ";
    instr_ir += this->get_operand(0)->get_type()->print();
    instr_ir += " ";
    for (unsigned int i = 0; i < this->get_num_operand()/2; i++)
    {
        if( i > 0 )
            instr_ir += ", ";
        instr_ir += "[ ";
        instr_ir += print_as_op(this->get_operand(2*i), false);
        instr_ir += ", ";
        instr_ir += print_as_op(this->get_operand(2*i+1), false);
        instr_ir += " ]";
    }
    if ( this->get_num_operand()/2 < this->get_parent()->get_pre_basic_blocks().size() )
    {
        for ( auto pre_bb : this->get_parent()->get_pre_basic_blocks() )
        {
            if (std::find(this->get_operands().begin(), this->get_operands().end(), static_pointer_cast<Value>(pre_bb)) == this->get_operands().end())
            {
                // find a pre_bb is not in phi
                instr_ir += ", [ undef, " +print_as_op(pre_bb, false)+" ]";
            }
        }
    }
    return instr_ir; 
}

}
}