#ifndef _SYSYF_TYPE_H_
#define _SYSYF_TYPE_H_

#include <vector>
#include <iostream>

#include "internal_types.h"

namespace SysYF
{
namespace IR
{
class Module;
class IntegerType;
class FloatType;
class FunctionType;
class ArrayType;
class PointerType;
class Type;

class Type : public std::enable_shared_from_this<Type>
{
public:
    enum TypeID {
        VoidTyID,         // Void
        LabelTyID,        // Labels, e.g., BasicBlock
        IntegerTyID,      // Integers, include 32 bits and 1 bit
        FloatTyID,        // Floats, only 32 bits
        FunctionTyID,     // Functions
        ArrayTyID,        // Arrays
        PointerTyID,      // Pointer
    };

    static Ptr<Type> create(TypeID tid, Ptr<Module> m);

    ~Type() = default;

    TypeID get_type_id() const { return tid_; }

    bool is_void_type() const { return get_type_id() == VoidTyID; }
    
    bool is_label_type() const { return get_type_id() == LabelTyID; }

    bool is_integer_type() const { return get_type_id() == IntegerTyID; }

    bool is_float_type() const { return get_type_id() == FloatTyID; }
        
    bool is_function_type() const { return get_type_id() == FunctionTyID; }

    bool is_array_type() const { return get_type_id() == ArrayTyID; }

    bool is_pointer_type() const { return get_type_id() == PointerTyID; }

    static bool is_eq_type(Ptr<Type> ty1, Ptr<Type> ty2);

    static Ptr<Type> get_void_type(Ptr<Module> m);

    static Ptr<Type> get_label_type(Ptr<Module> m);

    static Ptr<IntegerType> get_int1_type(Ptr<Module> m);

    static Ptr<IntegerType> get_int32_type(Ptr<Module> m);

    static Ptr<FloatType> get_float_type(Ptr<Module> m);

    static Ptr<PointerType> get_int32_ptr_type(Ptr<Module> m);

    static Ptr<PointerType> get_float_ptr_type(Ptr<Module> m);

    static Ptr<PointerType> get_pointer_type(Ptr<Type> contained);

    static Ptr<ArrayType> get_array_type(Ptr<Type> contained, unsigned num_elements);

    Ptr<Type> get_pointer_element_type();

    Ptr<Type> get_array_element_type();

    int get_size();
    
    Ptr<Module> get_module();

    std::string print();

protected:
    explicit Type(TypeID tid, Ptr<Module> m);
    void init(TypeID tid, Ptr<Module> m) {}

private:
    TypeID tid_;
    Ptr<Module> m_;
};

class IntegerType : public Type {
public:
    static Ptr<IntegerType> create(unsigned num_bits, Ptr<Module> m );

    unsigned get_num_bits();
private:
    explicit IntegerType(unsigned num_bits ,Ptr<Module> m);
    void init(unsigned num_bits ,Ptr<Module> m) { Type::init(IntegerTyID, m); }
    unsigned num_bits_;
};

class FloatType : public Type {
public:
    static Ptr<FloatType> create(Ptr<Module> m);
private:
    explicit FloatType(Ptr<Module> m);
    void init(Ptr<Module> m) { Type::init(FloatTyID, m); }
};

class FunctionType : public Type {
public:
    static Ptr<FunctionType> create(Ptr<Type> result, PtrVec<Type> params);
    static bool is_valid_return_type(Ptr<Type> ty);
    static bool is_valid_argument_type(Ptr<Type> ty);

    unsigned get_num_of_args() const;

    Ptr<Type> get_param_type(unsigned i) const;
    PtrVec<Type>::iterator param_begin() { return args_.begin(); }
    PtrVec<Type>::iterator param_end() { return args_.end(); }
    Ptr<Type> get_return_type() const;
private:
    explicit FunctionType(Ptr<Type> result, PtrVec<Type> params);
    void init(Ptr<Type> result, PtrVec<Type> params) { Type::init(FunctionTyID, nullptr); }
    Ptr<Type> result_;
    PtrVec<Type>  args_;
};

class ArrayType : public Type {
public:
    static bool is_valid_element_type(Ptr<Type> ty);

    static Ptr<ArrayType> get(Ptr<Type> contained, unsigned num_elements);
    static Ptr<ArrayType> create(Ptr<Type> contained, unsigned num_elements);

    Ptr<Type> get_element_type() const { return contained_; }
    unsigned get_num_of_elements() const { return num_elements_; }

private:
    explicit ArrayType(Ptr<Type> contained, unsigned num_elements);
    void init(Ptr<Type> contained, unsigned num_elements) { Type::init(ArrayTyID, nullptr); }
    Ptr<Type> contained_;   // The element type of the array.
    unsigned num_elements_;  // Number of elements in the array.
};

class PointerType : public Type {
public:
    Ptr<Type> get_element_type() const { return contained_; }
    static Ptr<PointerType> get(Ptr<Type> contained);
    static Ptr<PointerType> create(Ptr<Type> contained);

private:
    explicit PointerType(Ptr<Type> contained);
    void init(Ptr<Type> contained) { Type::init(PointerTyID, nullptr); }
    Ptr<Type> contained_;   // The element type of the ptr.
};

}
}
#endif // _SYSYF_TYPE_H_