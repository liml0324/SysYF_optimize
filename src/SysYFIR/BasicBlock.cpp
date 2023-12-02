#include "Module.h"
#include "BasicBlock.h"
#include "Function.h"
#include "IRPrinter.h"
#ifdef DEBUG
#include <cassert>
#endif
#include <algorithm>

namespace SysYF
{
namespace IR
{
BasicBlock::BasicBlock(Ptr<Module> m, const std::string &name = "",
                      Ptr<Function> parent = nullptr)
    : Value(Type::get_label_type(m), name), parent_(parent)
{
#ifdef DEBUG
    assert(parent && "currently parent should not be nullptr");
#endif
    // parent_->add_basic_block(dynamic_pointer_cast<BasicBlock>(shared_from_this()));
}

void BasicBlock::init(Ptr<Module> m, const std::string &name = "",
                      Ptr<Function> parent = nullptr)
{
    parent_->add_basic_block(dynamic_pointer_cast<BasicBlock>(shared_from_this()));
}

Ptr<Module> BasicBlock::get_module()
{
    return get_parent()->get_parent();
}

void BasicBlock::add_instruction(Ptr<Instruction> instr)
{
    instr_list_.push_back(instr);
}

void BasicBlock::add_instruction(PtrList<Instruction>::iterator instr_pos, Ptr<Instruction> instr)
{
    instr_list_.insert(instr_pos, instr);
}

void BasicBlock::add_instr_begin(Ptr<Instruction> instr)
{
    instr_list_.push_front(instr);
}

PtrList<Instruction>::iterator BasicBlock::find_instruction(Ptr<Instruction> instr)
{
    return std::find(instr_list_.begin(), instr_list_.end(), instr);
}

void BasicBlock::delete_instr( Ptr<Instruction> instr )
{
    instr_list_.remove(instr);
    instr->remove_use_of_ops();
}

const Ptr<Instruction> BasicBlock::get_terminator() const
{
    if (instr_list_.empty()){
        return nullptr;
    }
    switch (instr_list_.back()->get_instr_type())
    {
    case Instruction::ret:
        return instr_list_.back();
        break;
    
    case Instruction::br:
        return instr_list_.back();
        break;

    default:
        return nullptr;
        break;
    }
}

void BasicBlock::erase_from_parent()
{
    this->get_parent()->remove(dynamic_pointer_cast<BasicBlock>(shared_from_this()));
}

std::string BasicBlock::print()
{
    std::string bb_ir;
    bb_ir += this->get_name();
    bb_ir += ":";
    // print prebb
    if(!this->get_pre_basic_blocks().empty())
    {
        bb_ir += "                                                ; preds = ";
    }
    for (auto bb : this->get_pre_basic_blocks() )
    {
        if( bb != *this->get_pre_basic_blocks().begin() )
            bb_ir += ", ";
        bb_ir += print_as_op(bb, false);
    }
    
    // print prebb
    if ( !this->get_parent() )
    {
        bb_ir += "\n";
        bb_ir += "; Error: Block without parent!";
    }
    bb_ir += "\n";
    for ( auto instr : this->get_instructions() )
    {
        bb_ir += "  ";
        bb_ir += instr->print();
        bb_ir += "\n";
    }

    return bb_ir;
}

}
}