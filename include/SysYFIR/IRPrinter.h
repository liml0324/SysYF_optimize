#ifndef _SYSYF_IPRINTER_H_
#define _SYSYF_IPRINTER_H_

#include "Value.h"
#include "Module.h"
#include "Function.h"
#include "GlobalVariable.h"
#include "Constant.h"
#include "BasicBlock.h"
#include "Instruction.h"
#include "User.h"
#include "Type.h"

namespace SysYF
{
namespace IR
{
std::string print_as_op(Ptr<Value> v, bool print_ty );
std::string print_cmp_type(CmpInst::CmpOp op);
std::string print_fcmp_type(FCmpInst::CmpOp op);

}
}

#endif
