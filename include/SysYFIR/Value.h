#ifndef _SYSYF_VALUE_H_
#define _SYSYF_VALUE_H_

#include <string>
#include <list>
#include <iostream>
#include <memory>

#include "internal_types.h"

namespace SysYF
{
namespace IR
{

class Type;
class Value;

struct Use
{
    Ptr<Value> val_;
    unsigned arg_no_;     // the no. of operand, e.g., func(a, b), a is 0, b is 1
    Use(Ptr<Value> val, unsigned no) : val_(val), arg_no_(no) {}
};

class Value : public std::enable_shared_from_this<Value>
{
public:
    ~Value() = default;

    Ptr<Type> get_type() const { return type_; }

    std::list<Use> &get_use_list() { return use_list_; }

    void add_use(Ptr<Value> val, unsigned arg_no = 0);

    bool set_name(std::string name) { 
        if (name_ == "")
        {
            name_=name;
            return true;
        }   
        return false; 
    }
    std::string get_name() const;

    void replace_all_use_with(Ptr<Value> new_val);
    void remove_use(Ptr<Value> val);

    virtual std::string print() = 0;

protected:
    explicit Value(Ptr<Type> ty, const std::string &name = "");

private:
    Ptr<Type> type_;
    std::list<Use> use_list_;   // who use this value
    std::string name_;    // should we put name field here ?
};

}
}
#endif // _SYSYF_VALUE_H_
