#include "Value.h"
#include "Type.h"
#include "User.h"
#ifdef DEBUG
#include <cassert>
#endif

namespace SysYF
{
namespace IR
{
Value::Value(Ptr<Type> ty, const std::string &name)
  : type_(ty), name_(name)
{

}

void Value::add_use(Ptr<Value> val, unsigned arg_no)
{
    use_list_.push_back(Use(val, arg_no));
}

std::string Value::get_name() const
{
    return name_;
}

void Value::replace_all_use_with(Ptr<Value> new_val)
{
    for (auto use : use_list_) {
        auto val = dynamic_pointer_cast<User>(use.val_);
#ifdef DEBUG
        assert(val && "new_val is not a user");
#endif
        val->set_operand(use.arg_no_, new_val);
    }
}

void Value::remove_use(Ptr<Value> val)
{
    auto is_val = [val] (const Use &use) { return use.val_ == val; };
    use_list_.remove_if(is_val);
}

}
}