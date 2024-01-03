#ifndef SYSYF_MEM2REG_H
#define SYSYF_MEM2REG_H

#include "BasicBlock.h"
#include "Function.h"
#include "IRBuilder.h"
#include "Instruction.h"
#include "Module.h"
#include "Pass.h"

namespace SysYF
{
namespace IR
{
class Mem2Reg : public Pass{
private:
	Ptr<Function>func_;
	Ptr<IRBuilder>builder;
	std::map<Ptr<BasicBlock>, std::vector<Ptr<Value>>> define_var;
    const std::string name = "Mem2Reg";
	std::map<Ptr<Value>, Ptr<Value>> lvalue_connection;
	PtrSet<Value> no_union_set;

public:
	explicit Mem2Reg(Ptr<Module>m) : Pass(m) {}
	~Mem2Reg(){};
	void execute() final;
	void genPhi();
	void insideBlockForwarding();
	void valueDefineCounting();
	void valueForwarding(Ptr<BasicBlock>bb);
	void removeAlloc();
	void phiStatistic();
    const std::string get_name() const override {return name;}

	bool isLocalVarOp(Ptr<Instruction> inst){
		if (inst->get_instr_type() == Instruction::OpID::store){
			Ptr<StoreInst>sinst = static_pointer_cast<StoreInst>(inst);
			auto lvalue = sinst->get_lval();
			auto glob = dynamic_pointer_cast<GlobalVariable>(lvalue);
			auto array_element_ptr = dynamic_pointer_cast<GetElementPtrInst>(lvalue);
			return !glob && !array_element_ptr;
		}
		else if (inst->get_instr_type() == Instruction::OpID::load){
			Ptr<LoadInst> linst = static_pointer_cast<LoadInst>(inst);
			auto lvalue = linst->get_lval();
			auto glob = dynamic_pointer_cast<GlobalVariable>(lvalue);
			auto array_element_ptr = dynamic_pointer_cast<GetElementPtrInst>(lvalue);
			return !glob && !array_element_ptr;
		}
		else
			return false;
	}
	// void DeleteLS();
	//可加一个遍历删除空phi节点
};
}
}

#endif // SYSYF_MEM2REG_H