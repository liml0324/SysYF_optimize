#include<CodeGen.h>
#include<RegAlloc.h>
#include<queue>
#include<stack>
#include<algorithm>
#include<sstream>
#include<string>
    
namespace SysYF{
namespace IR{
    std::string CodeGen::instr_gen(Ptr<Instruction> inst){
        std::string code;
        // call functions in IR2asm , deal with phi inst(mov inst)
        // may have many bugs
        auto instr_type = inst->get_instr_type();
        switch (instr_type)
        {
            case Instruction::ret:
                if (inst->get_operands().empty()) {
                    //code += IR2asm::ret();
                } else {
                    auto ret_val = inst->get_operand(0);
                    auto const_ret_val = dynamic_pointer_cast<ConstantInt>(ret_val);
                    if (!const_ret_val&&get_asm_reg(ret_val)->get_id() == 0) {
//                        code += IR2asm::ret();
                    } else {
                        if (const_ret_val) {
                            code += IR2asm::ret(get_asm_const(const_ret_val));
                        } else {
                            if (get_asm_reg(ret_val)->get_id() < 0) {
                                code += IR2asm::safe_load(Ptr<IR2asm::Reg>(new IR2asm::Reg(0)), stack_map[ret_val], sp_extra_ofst, long_func);
                            } else {
                                code += IR2asm::ret(get_asm_reg(ret_val));
                            }
                        }
                    }
                }
                break;
            case Instruction::br:
                if (inst->get_num_operand() == 1) {
                    code += IR2asm::b(bb_label[dynamic_pointer_cast<BasicBlock>(inst->get_operand(0))]);
                }
                break;
            case Instruction::add: {
                    auto op1 = inst->get_operand(0);
                    auto op2 = inst->get_operand(1);
                    auto const_op1 = dynamic_pointer_cast<ConstantInt>(op1);
                    auto const_op2 = dynamic_pointer_cast<ConstantInt>(op2);
                    Ptr<Value>operand1;
                    Ptr<IR2asm::Operand2> operand2;
                    if (const_op1) {
                        operand1 = op2;
                        operand2 =Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_op1->get_value()));
                    } else {
                        operand1 = op1;
                        if (const_op2) {
                            operand2 =Ptr<IR2asm::Operand2>(  new IR2asm::Operand2(const_op2->get_value()));
                        } else {
                            operand2 =Ptr<IR2asm::Operand2>(  new IR2asm::Operand2(*get_asm_reg(op2)));
                        }
                    }
                    code += IR2asm::add(get_asm_reg(inst), get_asm_reg(operand1), operand2);
                }
                break;
            case Instruction::sub: {
                    auto op1 = inst->get_operand(0);
                    auto op2 = inst->get_operand(1);
                    auto const_op1 = dynamic_pointer_cast<ConstantInt>(op1);
                    auto const_op2 = dynamic_pointer_cast<ConstantInt>(op2);
                    Ptr<Value>operand1;
                    Ptr<IR2asm::Operand2> operand2;
                    if (const_op1) {
                        operand1 = op2;
                        operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_op1->get_value()));
                        code += IR2asm::r_sub(get_asm_reg(inst), get_asm_reg(operand1), operand2);
                    } else {
                        operand1 = op1;
                        if (const_op2) {
                            operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_op2->get_value()));
                        } else {
                            operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(op2)));
                        }
                        code += IR2asm::sub(get_asm_reg(inst), get_asm_reg(operand1), operand2);
                    }
                }
                break;
            case Instruction::mul: {
                    auto op1 = inst->get_operand(0);
                    auto op2 = inst->get_operand(1);
                    auto const_op1 = dynamic_pointer_cast<ConstantInt>(op1);
                    auto const_op2 = dynamic_pointer_cast<ConstantInt>(op2);
                    Ptr<Value>operand1;
                    Ptr<IR2asm::Operand2> operand2;
                    if (const_op1) {
                        operand1 = op2;
                        operand2 =Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_op1->get_value()));
                    } else {
                        operand1 = op1;
                        if (const_op2) {
                            operand2 =Ptr<IR2asm::Operand2>(  new IR2asm::Operand2(const_op2->get_value()));
                        } else {
                            operand2 =Ptr<IR2asm::Operand2>(  new IR2asm::Operand2(*get_asm_reg(op2)));
                        }
                    }
                    code += IR2asm::mul(get_asm_reg(inst), get_asm_reg(operand1), operand2);
                }
                break;
            case Instruction::sdiv: { // divide constant can be optimized
                    auto op1 = inst->get_operand(0);
                    auto op2 = inst->get_operand(1);
                    auto const_op1 = dynamic_pointer_cast<ConstantInt>(op1);
                    auto const_op2 = dynamic_pointer_cast<ConstantInt>(op2);
                    Ptr<Value>operand1;
                    Ptr<IR2asm::Operand2> operand2;
                    if (const_op1) {
                        operand1 = op2;
                        operand2 =Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_op1->get_value()));
                    } else {
                        operand1 = op1;
                        if (const_op2) {
                            operand2 =Ptr<IR2asm::Operand2>(  new IR2asm::Operand2(const_op2->get_value()));
                        } else {
                            operand2 =Ptr<IR2asm::Operand2>(  new IR2asm::Operand2(*get_asm_reg(op2)));
                        }
                    }
                    code += IR2asm::sdiv(get_asm_reg(inst), get_asm_reg(operand1), operand2);
                }
                break;
            case Instruction::fadd: {
                    auto op1 = inst->get_operand(0);
                    auto op2 = inst->get_operand(1);
                    auto const_op1 = dynamic_pointer_cast<ConstantFloat>(op1);
                    auto const_op2 = dynamic_pointer_cast<ConstantFloat>(op2);
                    Ptr<Value>operand1;
                    Ptr<IR2asm::Operand2> operand2;
                    if (const_op1) {
                        operand1 = op2;
                        operand2 =Ptr<IR2asm::Operand2>( new IR2asm::Operand2(0,const_op1->get_value(),true));
                    } else {
                        operand1 = op1;
                        if (const_op2) {
                            operand2 =Ptr<IR2asm::Operand2>(  new IR2asm::Operand2(0,const_op2->get_value(),true));
                        } else {
                            operand2 =Ptr<IR2asm::Operand2>(  new IR2asm::Operand2(*get_asm_reg(op2)));
                        }
                    }
                    code += IR2asm::fadd(get_asm_reg(inst), get_asm_reg(operand1), operand2);
                }
                break;
            case Instruction::fsub: {
                    auto op1 = inst->get_operand(0);
                    auto op2 = inst->get_operand(1);
                    auto const_op1 = dynamic_pointer_cast<ConstantFloat>(op1);
                    auto const_op2 = dynamic_pointer_cast<ConstantFloat>(op2);
                    Ptr<Value>operand1;
                    Ptr<IR2asm::Operand2> operand2;
                    if (const_op1) {
                        operand1 = op2;
                        operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(0,const_op1->get_value(),true));
                        code += IR2asm::r_sub(get_asm_reg(inst), get_asm_reg(operand1), operand2);
                    } else {
                        operand1 = op1;
                        if (const_op2) {
                            operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(0,const_op2->get_value(),true));
                        } else {
                            operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(op2)));
                        }
                        code += IR2asm::fsub(get_asm_reg(inst), get_asm_reg(operand1), operand2);
                    }
                }
                break;
            case Instruction::fmul: {
                    auto op1 = inst->get_operand(0);
                    auto op2 = inst->get_operand(1);
                    auto const_op1 = dynamic_pointer_cast<ConstantFloat>(op1);
                    auto const_op2 = dynamic_pointer_cast<ConstantFloat>(op2);
                    Ptr<Value>operand1;
                    Ptr<IR2asm::Operand2> operand2;
                    if (const_op1) {
                        operand1 = op2;
                        operand2 =Ptr<IR2asm::Operand2>( new IR2asm::Operand2(0,const_op1->get_value(),true));
                    } else {
                        operand1 = op1;
                        if (const_op2) {
                            operand2 =Ptr<IR2asm::Operand2>(  new IR2asm::Operand2(0,const_op2->get_value(),true));
                        } else {
                            operand2 =Ptr<IR2asm::Operand2>(  new IR2asm::Operand2(*get_asm_reg(op2)));
                        }
                    }
                    code += IR2asm::fmul(get_asm_reg(inst), get_asm_reg(operand1), operand2);
                }
                break;
            case Instruction::fdiv: { // divide constant can be optimized
                    auto op1 = inst->get_operand(0);
                    auto op2 = inst->get_operand(1);
                    auto const_op1 = dynamic_pointer_cast<ConstantFloat>(op1);
                    auto const_op2 = dynamic_pointer_cast<ConstantFloat>(op2);
                    Ptr<Value>operand1;
                    Ptr<IR2asm::Operand2> operand2;
                    if (const_op1) {
                        operand1 = op2;
                        operand2 =Ptr<IR2asm::Operand2>( new IR2asm::Operand2(0,const_op1->get_value(),true));
                    } else {
                        operand1 = op1;
                        if (const_op2) {
                            operand2 =Ptr<IR2asm::Operand2>(  new IR2asm::Operand2(0,const_op2->get_value(),true));
                        } else {
                            operand2 =Ptr<IR2asm::Operand2>(  new IR2asm::Operand2(*get_asm_reg(op2)));
                        }
                    }
                    code += IR2asm::fdiv(get_asm_reg(inst), get_asm_reg(operand1), operand2);
                }
                break;
            case Instruction::srem: // srem -> sdiv and msub
                break;
            case Instruction::alloca:   // no instruction in .s
                break;
            case Instruction::load: {
                    auto global_addr = dynamic_pointer_cast<GlobalVariable>(inst->get_operand(0));
                    if (global_addr) {
                        code += IR2asm::safe_load(get_asm_reg(inst), 
                                                    global_variable_table[global_addr], 
                                                    sp_extra_ofst, 
                                                    long_func);
                        // code += IR2asm::load(get_asm_reg(inst), global_variable_table[global_addr]);
                        code += IR2asm::safe_load(get_asm_reg(inst), 
                                                    Ptr<IR2asm::Regbase>(new IR2asm::Regbase(*get_asm_reg(inst), 0)), 
                                                    sp_extra_ofst, 
                                                    long_func);
                        // code += IR2asm::load(get_asm_reg(inst), new IR2asm::Regbase(*get_asm_reg(inst), 0));
                    } else {
                        code += IR2asm::safe_load(get_asm_reg(inst), 
                                                    Ptr<IR2asm::Regbase>(new IR2asm::Regbase(*get_asm_reg(inst->get_operand(0)), 0)), 
                                                    sp_extra_ofst, 
                                                    long_func);
                        // code += IR2asm::load(get_asm_reg(inst), new IR2asm::Regbase(*get_asm_reg(inst->get_operand(0)), 0));
                    }
                }
                break;
            case Instruction::store: {
                    auto global_addr = dynamic_pointer_cast<GlobalVariable>(inst->get_operand(1));
                    if (global_addr) {
                        std::vector<int> tmp_reg = {};
                        int ld_reg_id = 11;
                        // OPERAND1 MUST BE GLOBAL IN LIR
                        auto opr0 = inst->get_operand(0);
                        int opr0_reg_id = reg_map[opr0]->reg_num; //must have a reg,alloc in bb_gen
                        for(int i = 0;i <= 12;i++){
                            if(i==11){
                                continue;
                            }
                            if(i!=opr0_reg_id){
                                ld_reg_id = i;
                                tmp_reg.push_back(i);
                                break;
                            }
                        }
                        code += push_regs(tmp_reg);
                        code += IR2asm::safe_load(Ptr<IR2asm::Reg>(new IR2asm::Reg(ld_reg_id)),
                                                global_variable_table[global_addr],
                                                sp_extra_ofst,
                                                long_func);

                        code += IR2asm::safe_store(get_asm_reg(inst->get_operand((0))),
                                                    Ptr<IR2asm::Regbase>(new IR2asm::Regbase(IR2asm::Reg(ld_reg_id), 0)),
                                                    sp_extra_ofst,
                                                    long_func);
                        code += pop_regs(tmp_reg);
                    } else {
                        code += IR2asm::safe_store(get_asm_reg(inst->get_operand((0))),
                                                    Ptr<IR2asm::Regbase>(new IR2asm::Regbase(*get_asm_reg(inst->get_operand(1)), 0)),
                                                    sp_extra_ofst,
                                                    long_func);
                    }
                }
                break;
            case Instruction::cmp: {
                    auto cmp_inst = dynamic_pointer_cast<CmpInst>(inst);
                    auto cond1 = inst->get_operand(0);
                    auto cond2 = inst->get_operand(1);
                    auto cmp_op = cmp_inst->get_cmp_op();
                    auto const_cond1 = dynamic_pointer_cast<ConstantInt>(cond1);
                    auto const_cond2 = dynamic_pointer_cast<ConstantInt>(cond2);
                    Ptr<IR2asm::Reg>operand1;
                    Ptr<IR2asm::Operand2> operand2;
                    switch (cmp_op)
                    {
                        case CmpInst::CmpOp::EQ: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::cmp(operand1, operand2);
                            code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(0)));
                            code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(1)), "eq");
                        }
                        break;
                        case CmpInst::CmpOp::NE: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::cmp(operand1, operand2);
                            code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(0)));
                            code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(1)), "ne");
                        }
                        break;
                        case CmpInst::CmpOp::GT: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::cmp(operand1, operand2);
                            code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(0)));
                            if (const_cond1) {
                                code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(1)), "le");
                            } else {
                                code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(1)), "gt");
                            }
                        }
                        break;
                        case CmpInst::CmpOp::GE: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::cmp(operand1, operand2);
                            code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(0)));
                            if (const_cond1) {
                                code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(1)), "lt");
                            } else {
                                code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(1)), "ge");
                            }
                        }
                        break;
                        case CmpInst::CmpOp::LT: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::cmp(operand1, operand2);
                            code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(0)));
                            if (const_cond1) {
                                code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(1)), "ge");
                            } else {
                                code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(1)), "lt");
                            }
                        }
                        break;
                        case CmpInst::CmpOp::LE: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::cmp(operand1, operand2);
                            code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(0)));
                            if (const_cond1) {
                                code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(1)), "gt");
                            } else {
                                code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(1)), "le");
                            }
                        }
                        break;
                        default:
                        break;
                    }
                }
                break;
            case Instruction::fcmp: {
                    auto cmp_inst = dynamic_pointer_cast<FCmpInst>(inst);
                    auto cond1 = inst->get_operand(0);
                    auto cond2 = inst->get_operand(1);
                    auto cmp_op = cmp_inst->get_cmp_op();
                    auto const_cond1 = dynamic_pointer_cast<ConstantFloat>(cond1);
                    auto const_cond2 = dynamic_pointer_cast<ConstantFloat>(cond2);
                    Ptr<IR2asm::Reg>operand1;
                    Ptr<IR2asm::Operand2> operand2;
                    switch (cmp_op)
                    {
                        case FCmpInst::CmpOp::EQ: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::fcmp(operand1, operand2);
                            code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(0)));
                            code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(1)), "eq");
                        }
                        break;
                        case FCmpInst::CmpOp::NE: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::fcmp(operand1, operand2);
                            code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(0)));
                            code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(1)), "ne");
                        }
                        break;
                        case FCmpInst::CmpOp::GT: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::fcmp(operand1, operand2);
                            code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(0)));
                            if (const_cond1) {
                                code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(1)), "le");
                            } else {
                                code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(1)), "gt");
                            }
                        }
                        break;
                        case FCmpInst::CmpOp::GE: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::fcmp(operand1, operand2);
                            code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(0)));
                            if (const_cond1) {
                                code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(1)), "lt");
                            } else {
                                code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(1)), "ge");
                            }
                        }
                        break;
                        case FCmpInst::CmpOp::LT: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::fcmp(operand1, operand2);
                            code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(0)));
                            if (const_cond1) {
                                code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(1)), "ge");
                            } else {
                                code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(1)), "lt");
                            }
                        }
                        break;
                        case FCmpInst::CmpOp::LE: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::fcmp(operand1, operand2);
                            code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(0)));
                            if (const_cond1) {
                                code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(1)), "gt");
                            } else {
                                code += IR2asm::ldr_const(get_asm_reg(inst),Ptr<IR2asm::constant>( new IR2asm::constant(1)), "le");
                            }
                        }
                        break;
                        default:
                        break;
                    }
                }
                break;
            case Instruction::phi:  // has done before
                break;
            case Instruction::call:
                    code += IR2asm::call(Ptr<IR2asm::label>(new IR2asm::label(inst->get_operand(0)->get_name())));
                break;
            case Instruction::getelementptr: {
                    auto base_addr = inst->get_operand(0);
                    if (dynamic_pointer_cast<GlobalVariable>(base_addr)) {
                        auto addr = global_variable_table[dynamic_pointer_cast<GlobalVariable>(base_addr)];
                        code += IR2asm::safe_load(get_asm_reg(inst), addr, sp_extra_ofst, long_func);
                    } else if (dynamic_pointer_cast<AllocaInst>(base_addr)) {
                        auto addr = stack_map[base_addr];
                        if(addr==nullptr){
                            std::cout<<"ERORR: stack of "<<base_addr->print()<<" :nullptr"<<std::endl;
                            std::cout<<"stack:"<<std::endl;
                            for(auto i:stack_map){
                                if(i.second==nullptr)
                                    std::cout<<i.first->print()<<":nullptr"<<std::endl;
                                else
                                    std::cout<<i.first->print()<<":"<<i.second->get_code()<<std::endl;
                            }
                        }
                        code += IR2asm::getelementptr(get_asm_reg(inst), addr);
                    } else {
                        auto addr = Ptr<IR2asm::Regbase>(new IR2asm::Regbase(*get_asm_reg(base_addr), 0));
                        code += IR2asm::getelementptr(get_asm_reg(inst), addr);
                    }
                }
                break;
            case Instruction::zext:
                code += IR2asm::mov(get_asm_reg(inst), Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(inst->get_operand(0)))));
                break;
            case Instruction::cmpbr: {
                    // std::cout<<"cmpbr"<<inst->print()<<std::endl;
                    auto cmpbr_inst = dynamic_pointer_cast<CmpBrInst>(inst);
                    auto cond1 = inst->get_operand(0);
                    auto cond2 = inst->get_operand(1);
                    auto cmp_op = cmpbr_inst->get_cmp_op();
                    auto true_bb = dynamic_pointer_cast<BasicBlock>(inst->get_operand(2));
                    auto false_bb = dynamic_pointer_cast<BasicBlock>(inst->get_operand(3));
                    auto const_cond1 = dynamic_pointer_cast<ConstantInt>(cond1);
                    auto const_cond2 = dynamic_pointer_cast<ConstantInt>(cond2);
                    Ptr<IR2asm::Reg>operand1;
                    Ptr<IR2asm::Operand2> operand2;
                    switch (cmp_op)
                    {
                        case CmpBrInst::CmpOp::EQ: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::cmp(operand1, operand2);
                            code += IR2asm::beq(bb_label[true_bb]);
                            code += IR2asm::b(bb_label[false_bb]);
                        }
                        break;
                        case CmpBrInst::CmpOp::NE: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::cmp(operand1, operand2);
                            code += IR2asm::bne(bb_label[true_bb]);
                            code += IR2asm::b(bb_label[false_bb]);
                        }
                        break;
                        case CmpBrInst::CmpOp::GT: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::cmp(operand1, operand2);
                            if (const_cond1) {
                                code += IR2asm::ble(bb_label[true_bb]);
                            } else {
                                code += IR2asm::bgt(bb_label[true_bb]);
                            }
                            code += IR2asm::b(bb_label[false_bb]);
                        }
                        break;
                        case CmpBrInst::CmpOp::GE: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::cmp(operand1, operand2);
                            if (const_cond1) {
                                code += IR2asm::blt(bb_label[true_bb]);
                            } else {
                                code += IR2asm::bge(bb_label[true_bb]);
                            }
                            code += IR2asm::b(bb_label[false_bb]);
                        }
                        break;
                        case CmpBrInst::CmpOp::LT: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::cmp(operand1, operand2);
                            if (const_cond1) {
                                code += IR2asm::bge(bb_label[true_bb]);
                            } else {
                                code += IR2asm::blt(bb_label[true_bb]);
                            }
                            code += IR2asm::b(bb_label[false_bb]);
                        }
                        break;
                        case CmpBrInst::CmpOp::LE: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::cmp(operand1, operand2);
                            if (const_cond1) {
                                code += IR2asm::bgt(bb_label[true_bb]);
                            } else {
                                code += IR2asm::ble(bb_label[true_bb]);
                            }
                            code += IR2asm::b(bb_label[false_bb]);
                        }
                        break;
                        default:
                        break;
                    }
                }
                break;
            case Instruction::fcmpbr: {
                    auto fcmpbr_inst = dynamic_pointer_cast<FCmpBrInst>(inst);
                    auto cond1 = inst->get_operand(0);
                    auto cond2 = inst->get_operand(1);
                    auto cmp_op = fcmpbr_inst->get_fcmp_op();
                    auto true_bb = dynamic_pointer_cast<BasicBlock>(inst->get_operand(2));
                    auto false_bb = dynamic_pointer_cast<BasicBlock>(inst->get_operand(3));
                    auto const_cond1 = dynamic_pointer_cast<ConstantInt>(cond1);
                    auto const_cond2 = dynamic_pointer_cast<ConstantInt>(cond2);
                    Ptr<IR2asm::Reg>operand1;
                    Ptr<IR2asm::Operand2> operand2;
                    switch (cmp_op)
                    {
                        case FCmpBrInst::CmpOp::EQ: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::fcmp(operand1, operand2);
                            code += IR2asm::beq(bb_label[true_bb]);
                            code += IR2asm::b(bb_label[false_bb]);
                        }
                        break;
                        case FCmpBrInst::CmpOp::NE: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::fcmp(operand1, operand2);
                            code += IR2asm::bne(bb_label[true_bb]);
                            code += IR2asm::b(bb_label[false_bb]);
                        }
                        break;
                        case FCmpBrInst::CmpOp::GT: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::fcmp(operand1, operand2);
                            if (const_cond1) {
                                code += IR2asm::ble(bb_label[true_bb]);
                            } else {
                                code += IR2asm::bgt(bb_label[true_bb]);
                            }
                            code += IR2asm::b(bb_label[false_bb]);
                        }
                        break;
                        case FCmpBrInst::CmpOp::GE: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::fcmp(operand1, operand2);
                            if (const_cond1) {
                                code += IR2asm::blt(bb_label[true_bb]);
                            } else {
                                code += IR2asm::bge(bb_label[true_bb]);
                            }
                            code += IR2asm::b(bb_label[false_bb]);
                        }
                        break;
                        case FCmpBrInst::CmpOp::LT: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::fcmp(operand1, operand2);
                            if (const_cond1) {
                                code += IR2asm::bge(bb_label[true_bb]);
                            } else {
                                code += IR2asm::blt(bb_label[true_bb]);
                            }
                            code += IR2asm::b(bb_label[false_bb]);
                        }
                        break;
                        case FCmpBrInst::CmpOp::LE: {
                            if (const_cond1) {
                                operand1 = get_asm_reg(cond2);
                                operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond1->get_value()));
                            } else {
                                operand1 = get_asm_reg(cond1);
                                if (const_cond2) {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(const_cond2->get_value()));
                                } else {
                                    operand2 = Ptr<IR2asm::Operand2>( new IR2asm::Operand2(*get_asm_reg(cond2)));
                                }
                            }
                            code += IR2asm::fcmp(operand1, operand2);
                            if (const_cond1) {
                                code += IR2asm::bgt(bb_label[true_bb]);
                            } else {
                                code += IR2asm::ble(bb_label[true_bb]);
                            }
                            code += IR2asm::b(bb_label[false_bb]);
                        }
                        break;
                        default:
                        break;
                    }
                }
                break;
            case Instruction::mov_const: {
                    auto mov_inst = dynamic_pointer_cast<MovConstInst>(inst);
                    auto const_val = mov_inst->get_const()->get_value();
                    code += IR2asm::ldr_const(get_asm_reg(inst), Ptr<IR2asm::constant>(new IR2asm::constant(const_val)));
                }
                break;
            case Instruction::fptosi:{
                    auto fptosi_inst = dynamic_pointer_cast<FpToSiInst>(inst);
                    auto reg=fptosi_inst->get_operand(0);
                    code += IR2asm::fptosi(get_asm_reg(reg),get_asm_reg(reg));
                }
                break;
            case Instruction::sitofp:{
                    auto sitofp_inst = dynamic_pointer_cast<SiToFpInst>(inst);
                    auto reg=sitofp_inst->get_operand(0);
                    code += IR2asm::sitofp(get_asm_reg(reg),get_asm_reg(reg));
                }
                break;
            default:
                std::cout<<"invalid type: "<<inst->get_instr_op_name()<<std::endl;
                break;
        }
        return code;
    }
    }
    }