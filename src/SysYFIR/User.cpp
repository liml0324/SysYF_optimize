#include "User.h"
#ifdef DEBUG
#include <cassert>
#endif

namespace SysYF
{
namespace IR
{
User::User(Ptr<Type> ty, const std::string &name , unsigned num_ops)
    : Value(ty, name), num_ops_(num_ops)
{
    // if (num_ops_ > 0)
    //   operands_.reset(new std::list<Ptr<Value> >());
    operands_.resize(num_ops_, nullptr);
}

PtrVec<Value>& User::get_operands()
{
    return operands_;
}

Ptr<Value> User::get_operand(unsigned i) const
{
    return operands_[i];
}

void User::set_operand(unsigned i, Ptr<Value> v)
{
#ifdef DEBUG
    assert(i < num_ops_ && "set_operand out of index");
#endif
    // assert(operands_[i] == nullptr && "ith operand is not null");
    operands_[i] = v;  
    v->add_use(shared_from_this(), i);
}

void User::add_operand(Ptr<Value> v)
{
    operands_.push_back(v);  
    v->add_use(shared_from_this(), num_ops_);
    num_ops_++;
}

unsigned User::get_num_operand() const
{
    return num_ops_;
}

void User::remove_use_of_ops()
{
    for (auto op : operands_) {
        op->remove_use(shared_from_this());
    }
}

void User::remove_operands(int index1,int index2){
    for(int i=index1;i<=index2;i++){
        operands_[i]->remove_use(shared_from_this());
    }
    operands_.erase(operands_.begin()+index1,operands_.begin()+index2+1);
    // std::cout<<operands_.size()<<std::endl;
    num_ops_=operands_.size();
}

}
}