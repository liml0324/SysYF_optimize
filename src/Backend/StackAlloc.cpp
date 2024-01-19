#include <CodeGen.h>
#include <RegAlloc.h>
#include <string>

/*
    Code for allocating spaces for the varibles in the function (specified by parameter)
        - parameter `fun`: pointer to the function to be handled
    
    You need to implement this function, according to the stack frame layout stated in the documentation
    
    Here are some tips:
        - Be careful with the order of the arguments to be passed through stack. They are pushed in reversed order,
          which means that a parameter in front will be closer to the stack pointer. 
          For example, the fourth parameter will be closer to the stack pointer than the fifth parameter.
        - Don't forget to reserve the space for callee-saved registers. The number of callee-saved registers
          can be obtained with `used_reg.second.size()`. 
        - ...
*/

namespace SysYF{
namespace IR{
int CodeGen::stack_space_allocation(Ptr<Function>fun)
{
    std::cout<<"stack_space_allocation"<<std::endl;
    int size = 0;

    // std::map<Ptr<Value>, Interval *> CodeGen::reg_map
    auto _reg_map = &reg_map;   // Hint: use this to get register for values

    // std::map<Ptr<Value>, Ptr<IR2asm::Regbase>> CodeGen::stack_map
    stack_map.clear();          // You need to fill in this container to finish allocation

    // std::vector<Ptr<IR2asm::Regbase>> CodeGen::arg_on_stack（未使用，不必要维护）
    arg_on_stack.clear();       // You need to maintain this information, the order is the same as parameter

    /* TODO：put your code here */
    int offset=0;
    //参数分配
    int arg_offset=0;
    for(auto arg:fun->get_args()){
        if(arg->get_arg_no()>=4){
            stack_map[arg]=Ptr<IR2asm::Regbase>(new IR2asm::Regbase(IR2asm::sp,arg_offset));
            arg_offset+=reg_size;
        }
    }
    arg_offset+=reg_size;
    std::cout<<"arg_offset:"<<arg_offset<<std::endl;
    offset+=arg_offset;
    //局部数组分配（遍历alloca语句）
    for(auto inst:fun->get_entry_block()->get_instructions()){
        if(inst->get_instr_type() == Instruction::alloca){
            stack_map[inst] = Ptr<IR2asm::Regbase>(new IR2asm::Regbase(IR2asm::Reg(IR2asm::sp), offset));
            offset += inst->get_operand(0)->get_type()->get_size();
        }
    }
    std::cout<<"offset after vec:"<<offset<<std::endl;
    //溢出的局部变量分配(_reg_map中)
    for(auto reg: *_reg_map){
        if(reg.second->reg_num==-1){
            stack_map[reg.first] = Ptr<IR2asm::Regbase>(new IR2asm::Regbase(IR2asm::Reg(IR2asm::sp), offset));
            offset += reg.first->get_type()->get_size();
        }
    }
    std::cout<<"offset after reg:"<<offset<<std::endl;
    //临时变量分配
    if(have_temp_reg){
        offset+=temp_reg_store_num*reg_size;
    }
    //函数调用
    if(have_func_call){
        offset+=caller_saved_reg_num*reg_size;
    }
    
    size=offset-arg_offset;
    //返回分配的总空间的大小（字节数）
    std::cout<<"size:"<<size<<std::endl;
    return size;
}
}
}