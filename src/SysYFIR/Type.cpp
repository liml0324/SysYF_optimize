#include "Type.h"
#include "Module.h"

#ifdef DEBUG
#include <cassert>
#endif

namespace SysYF
{
namespace IR
{
Type::Type(TypeID tid, Ptr<Module> m)
{
    tid_ = tid;
    m_ = m;
}

Ptr<Type> Type::create(TypeID tid, Ptr<Module> m)
{
    RET_AFTER_INIT(Type, tid, m);
}

Ptr<Module> Type::get_module()
{
    return m_;
}

bool Type::is_eq_type(Ptr<Type> ty1, Ptr<Type> ty2)
{
    return ty1 == ty2;
}

Ptr<Type> Type::get_void_type(Ptr<Module> m)
{
    return m->get_void_type();
}

Ptr<Type> Type::get_label_type(Ptr<Module> m)
{
    return m->get_label_type();
}

Ptr<IntegerType> Type::get_int1_type(Ptr<Module> m)
{
    return m->get_int1_type();
}

Ptr<IntegerType> Type::get_int32_type(Ptr<Module> m)
{
    return m->get_int32_type();
}

Ptr<FloatType> Type::get_float_type(Ptr<Module> m)
{
    return m->get_float_type();
}

Ptr<PointerType> Type::get_pointer_type(Ptr<Type> contained)
{
    return PointerType::get(contained);
}

Ptr<ArrayType> Type::get_array_type(Ptr<Type> contained, unsigned num_elements)
{
    return ArrayType::get(contained, num_elements);
}

Ptr<PointerType> Type::get_int32_ptr_type(Ptr<Module> m)
{
    return m->get_int32_ptr_type();
}

Ptr<PointerType> Type::get_float_ptr_type(Ptr<Module> m)
{
    return m->get_float_ptr_type();
}

Ptr<Type> Type::get_pointer_element_type(){ 
    if( this->is_pointer_type() )
        return static_pointer_cast<PointerType>(shared_from_this())->get_element_type();
    else
        return nullptr;
}

Ptr<Type> Type::get_array_element_type(){
    if( this->is_array_type() )
        return static_pointer_cast<ArrayType>(shared_from_this())->get_element_type();
    else
        return nullptr;
}

int Type::get_size() 
{
    if (this->is_integer_type()) 
    {
        auto bits = static_pointer_cast<IntegerType>(shared_from_this())->get_num_bits() / 8;
        return bits > 0 ? bits : 1;        
    }
    if (this->is_float_type()) 
    {
        return 4;        
    }
    if (this->is_array_type()) 
    {
        auto element_size = static_pointer_cast<ArrayType>(shared_from_this())->get_element_type()->get_size();
        auto num_elements = static_pointer_cast<ArrayType>(shared_from_this())->get_num_of_elements();
        return element_size * num_elements;
    }
    if (this->is_pointer_type()) 
    {
        if (this->get_pointer_element_type()->is_array_type()) 
        {
            return this->get_pointer_element_type()->get_size();
        } 
        else 
        {
            return 4;
        }
    }
    return 0;
}

std::string Type::print(){
    std::string type_ir;
    switch (this->get_type_id())
    {
    case VoidTyID:
        type_ir += "void";
        break;
    case LabelTyID:
        type_ir += "label";
        break;
    case IntegerTyID:
        type_ir += "i";
        type_ir += std::to_string( static_pointer_cast<IntegerType>(shared_from_this())->get_num_bits());
        break;
    case FloatTyID:
        type_ir += "float";
        break;
    case FunctionTyID:
        type_ir += static_pointer_cast<FunctionType>(shared_from_this())->get_return_type()->print();
        type_ir += " (";
        for(unsigned int i = 0 ; i < static_pointer_cast<FunctionType>(shared_from_this())->get_num_of_args() ; i++)
        {
            if(i)
                type_ir += ", ";
            type_ir += static_pointer_cast<FunctionType>(shared_from_this())->get_param_type(i)->print();
        }
        type_ir += ")";
        break;
    case PointerTyID:
        type_ir += this->get_pointer_element_type()->print();
        type_ir += "*";
        break;
    case ArrayTyID:
        type_ir += "[";
        type_ir += std::to_string( static_pointer_cast<ArrayType>(shared_from_this())->get_num_of_elements());
        type_ir += " x ";
        type_ir += static_pointer_cast<ArrayType>(shared_from_this())->get_element_type()->print();
        type_ir += "]";
        break;
    default:
        break;
    }
    return type_ir;
}

IntegerType::IntegerType(unsigned num_bits , Ptr<Module> m)
    : Type(Type::IntegerTyID, m), num_bits_(num_bits)
{

}


Ptr<IntegerType> IntegerType::create(unsigned num_bits, Ptr<Module> m )
{
    RET_AFTER_INIT(IntegerType, num_bits, m);
}

unsigned IntegerType::get_num_bits()
{
    return num_bits_;
}

FloatType::FloatType(Ptr<Module> m)
    : Type(Type::FloatTyID, m)
{

}

Ptr<FloatType> FloatType::create(Ptr<Module> m )
{
    RET_AFTER_INIT(FloatType, m);
}

FunctionType::FunctionType(Ptr<Type> result, PtrVec<Type>  params)
    : Type(Type::FunctionTyID, nullptr)
{
#ifdef DEBUG
    assert(is_valid_return_type(result) && "Invalid return type for function!");
#endif
    result_ = result;

    for (auto p : params) {
#ifdef DEBUG
        assert(is_valid_argument_type(p) &&
            "Not a valid type for function argument!");
#endif
        args_.push_back(p);
    }
}

Ptr<FunctionType> FunctionType::create(Ptr<Type> result, PtrVec<Type>  params)
{
    RET_AFTER_INIT(FunctionType, result, params);
}

bool FunctionType::is_valid_return_type(Ptr<Type> ty)
{
    return ty->is_integer_type() || ty->is_void_type();
}

bool FunctionType::is_valid_argument_type(Ptr<Type> ty)
{
    return ty->is_integer_type() || ty->is_pointer_type();
}

unsigned FunctionType::get_num_of_args() const
{
    return args_.size();
}

Ptr<Type> FunctionType::get_param_type(unsigned i) const
{
    return args_[i];
}

Ptr<Type> FunctionType::get_return_type() const
{
    return result_;
}

ArrayType::ArrayType(Ptr<Type> contained, unsigned num_elements)
    : Type(Type::ArrayTyID, contained->get_module()), num_elements_(num_elements)
{
#ifdef DEBUG
    assert(is_valid_element_type(contained) && "Not a valid type for array element!");
#endif
    contained_ = contained;
}

bool ArrayType::is_valid_element_type(Ptr<Type> ty)
{
    return ty->is_integer_type()||ty->is_array_type()||ty->is_float_type();
}

Ptr<ArrayType> ArrayType::get(Ptr<Type> contained, unsigned num_elements)
{
    return contained->get_module()->get_array_type(contained, num_elements);
}

Ptr<ArrayType> ArrayType::create(Ptr<Type> contained, unsigned num_elements)
{
    RET_AFTER_INIT(ArrayType, contained, num_elements);
}

PointerType::PointerType(Ptr<Type> contained)
    : Type(Type::PointerTyID, contained->get_module()), contained_(contained)
{
    
}

Ptr<PointerType> PointerType::get(Ptr<Type> contained)
{
    return contained->get_module()->get_pointer_type(contained);
}

Ptr<PointerType> PointerType::create(Ptr<Type> contained)
{
    RET_AFTER_INIT(PointerType, contained);
}

}
}