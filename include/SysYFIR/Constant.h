#ifndef _SYSYF_CONSTANT_H_
#define _SYSYF_CONSTANT_H_
#include "User.h"
#include "Value.h"
#include "Type.h"

namespace SysYF
{
namespace IR
{
class Constant : public User
{
protected:
    explicit Constant(Ptr<Type> ty, const std::string &name = "", unsigned num_ops = 0)
    : User(ty, name, num_ops) {}
    void init(Ptr<Type> ty, const std::string &name = "", unsigned num_ops = 0) {}
    // int value;
public:
    ~Constant() = default;
};

class ConstantInt : public Constant
{
private:
    int value_;
    explicit ConstantInt(Ptr<Type> ty, int val) 
        : Constant(ty,"",0),value_(val) {}
    void init(Ptr<Type> ty, int val);

public:
    
    static int get_value(Ptr<ConstantInt> const_val) { return const_val->value_; }
    int get_value() { return value_; }
    static Ptr<ConstantInt> create(int val, Ptr<Module> m);
    static Ptr<ConstantInt> create(bool val, Ptr<Module> m);
    virtual std::string print() override;
};

class ConstantFloat : public Constant
{
private:
    float value_;
    explicit ConstantFloat(Ptr<Type>  ty,float val) 
        : Constant(ty,"",0),value_(val) {}
    void init(Ptr<Type> ty, float val);

public:
    
    static float get_value(Ptr<ConstantFloat> const_val) { return const_val->value_; }
    float get_value() { return value_; }
    static Ptr<ConstantFloat> create(float val, Ptr<Module> m);
    virtual std::string print() override;
};

class ConstantArray : public Constant
{
private:
    PtrVec<Constant> const_array;
    explicit ConstantArray(Ptr<ArrayType> ty, const PtrVec<Constant> &val);
    void init(Ptr<ArrayType> ty, const PtrVec<Constant> &val);

public:
    
    ~ConstantArray() = default;

    Ptr<Constant> get_element_value(int index);

    unsigned get_size_of_array() { return const_array.size(); } 

    static Ptr<ConstantArray> create(Ptr<ArrayType> ty, const PtrVec<Constant> &val);

    virtual std::string print() override;
};

class ConstantZero : public Constant 
{
private:
    explicit ConstantZero(Ptr<Type> ty)
        : Constant(ty,"",0) {}
    void init(Ptr<Type> ty);

public:
    static Ptr<ConstantZero> create(Ptr<Type> ty, Ptr<Module> m);
    virtual std::string print() override;
};

}
}

#endif //_SYSYF_CONSTANT_H_
