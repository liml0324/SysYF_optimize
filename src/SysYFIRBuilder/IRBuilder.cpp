#include "IRBuilder.h"

namespace SysYF
{
namespace IR
{
#define CONST_INT(num) ConstantInt::create(num, module)
#define CONST_FLOAT(num) ConstantFloat::create(num, module)

// You can define global variables here
// to store state
bool is_assign;//只有赋值语句需要真正的“左值”
PtrVec<Value> initValues;//初值列表，为数组准备的
PtrVec<SyntaxTree::FuncParam> func_params;//函数参数列表
Ptr<Value> func_ret_val;//函数返回值（的指针），return时把返回值store到里面
Ptr<BasicBlock> retBB;//函数返回基本块，return时保存返回值后跳转到这里即可
bool is_func_body;//当前基本块是函数体，visit BlockStmt时如果这个标记为true，就不需要再scope.enter()

// store temporary value
Ptr<Value> tmp_val = nullptr;

// types
Ptr<Type> VOID_T;
Ptr<Type> INT1_T;
Ptr<Type> INT32_T;
Ptr<Type> FLOAT_T;
Ptr<Type> INT32PTR_T;
Ptr<Type> FLOATPTR_T;


void IRBuilder::visit(SyntaxTree::Assembly &node) {
    VOID_T = Type::get_void_type(module);
    INT1_T = Type::get_int1_type(module);
    INT32_T = Type::get_int32_type(module);
    FLOAT_T = Type::get_float_type(module);
    INT32PTR_T = Type::get_int32_ptr_type(module);
    FLOATPTR_T = Type::get_float_ptr_type(module);
    for (const auto &def : node.global_defs) {
        def->accept(*this);
    }
}

// You need to fill them

void IRBuilder::visit(SyntaxTree::InitVal &node) {
    if(node.isExp) {
        node.expr->accept(*this);
        if(tmp_val) {
            initValues.push_back(tmp_val);
        }
    } 
    else {
        for(auto &init_val : node.elementList) {
            init_val->accept(*this);
        }
    }
}

void IRBuilder::visit(SyntaxTree::FuncDef &node) {
    func_params.clear();
    if(node.param_list)// 有参数
        node.param_list->accept(*this);
    PtrVec<Type> param_types;
    for(auto &param : func_params) {// 获取参数类型
        if(param->param_type == SyntaxTree::Type::INT) {
            if(param->array_index.empty())
                param_types.push_back(INT32_T);
            else
                param_types.push_back(INT32PTR_T);
        }
        else {
            if(param->array_index.empty())
                param_types.push_back(FLOAT_T);
            else
                param_types.push_back(FLOATPTR_T);
        }
    }
    Ptr<Type> ret_type;// 获取返回值类型
    if(node.ret_type == SyntaxTree::Type::INT) {
        ret_type = INT32_T;
    }
    else if(node.ret_type == SyntaxTree::Type::FLOAT){
        ret_type = FLOAT_T;
    }
    else if(node.ret_type == SyntaxTree::Type::VOID) {
        ret_type = VOID_T;
    }
    auto func_type = FunctionType::create(ret_type, param_types);
    auto func = Function::create(func_type, node.name, module);// 创建函数
    scope.push(node.name, func);// 把函数名加入符号表
    auto func_def_BB = BasicBlock::create(module, "entry", func);// 创建函数入口基本块
    builder->set_insert_point(func_def_BB);
    scope.enter();// 提前enter，因为参数是局部变量
    if(ret_type != VOID_T)// 为返回值分配空间
        func_ret_val = builder->create_alloca(ret_type);
    else
        func_ret_val = nullptr;
    PtrVec<Value> func_args;
    for(auto &arg : func->get_args()) {
        func_args.push_back(arg);
    }
    for(int i = 0; i < (int)func_args.size(); i++) {// 处理参数
        auto arg = func_args[i];
        auto param = func_params[i];
        auto param_name = param->name;
        auto param_ptr = builder->create_alloca(arg->get_type());
        builder->create_store(arg, param_ptr);// 保存传入的参数
        scope.push(param_name, param_ptr);
    }
    retBB = BasicBlock::create(module, "retBB", func);
    is_func_body = true;// 标记当前基本块是函数体，这样在visit BlockStmt时就不会再enter
    node.body->accept(*this);
    is_func_body = false;
    if(!builder->get_insert_block()->get_terminator()) {// 如果函数体没有return语句，那么就在最后加上一个return
        if(ret_type == INT32_T) {
            builder->create_store(CONST_INT(0), func_ret_val);
        }
        else if(ret_type == FLOAT_T) {
            builder->create_store(CONST_FLOAT(0), func_ret_val);
        }
        builder->create_br(retBB);
    }
    scope.exit();// 退出函数作用域

    builder->set_insert_point(retBB);// 创建函数返回基本块
    if(ret_type != VOID_T) {
        auto ret_val = builder->create_load(func_ret_val);
        builder->create_ret(ret_val);
    }
    else {
        builder->create_void_ret();
    }
}

void IRBuilder::visit(SyntaxTree::FuncFParamList &node) {
    func_params.clear();
    for(auto &param : node.params) {
        param->accept(*this);// visit每一个参数即可
    }
}

void IRBuilder::visit(SyntaxTree::FuncParam &node) {// 这里只将参数存起来，留给FuncDef处理
    auto param = Ptr<SyntaxTree::FuncParam>(new SyntaxTree::FuncParam(node));
    func_params.push_back(param);
}

void IRBuilder::visit(SyntaxTree::VarDef &node) {
    initValues.clear();//清空初始值
    if(node.array_length.empty()) {//不是数组
        if(node.is_constant) {//是常量
            node.initializers->accept(*this);//获取初始值
            auto float_val = std::dynamic_pointer_cast<ConstantFloat>(initValues[0]);//常量必然有初值，且初值必然为常数
            auto int_val = std::dynamic_pointer_cast<ConstantInt>(initValues[0]);
            if(scope.in_global()) {//全局变量
                if(node.btype == SyntaxTree::Type::INT) {//整型
                    if(float_val) {
                        tmp_val = CONST_INT((int)(float_val->get_value()));
                    }
                    else if(int_val) {
                        tmp_val = CONST_INT(int_val->get_value());
                    }
                    tmp_val = GlobalVariable::create(node.name, module, INT32_T, true, dynamic_pointer_cast<Constant>(tmp_val));
                }
                else if(node.btype == SyntaxTree::Type::FLOAT) {//浮点型
                    if(float_val) {
                        tmp_val = CONST_FLOAT(float_val->get_value());
                    }
                    else if(int_val) {
                        tmp_val = CONST_FLOAT((float)(int_val->get_value()));
                    }
                    tmp_val = GlobalVariable::create(node.name, module, INT32_T, true, dynamic_pointer_cast<Constant>(tmp_val));
                }
            }
            else {//局部变量
                if(node.btype == SyntaxTree::Type::INT) {//整型
                    if(float_val) {
                        tmp_val = CONST_INT((int)(float_val->get_value()));
                    }
                    else if(int_val) {
                        tmp_val = CONST_INT(int_val->get_value());
                    }
                }
                else if(node.btype == SyntaxTree::Type::FLOAT) {//浮点型
                    if(float_val) {
                        tmp_val = CONST_FLOAT(float_val->get_value());
                    }
                    else if(int_val) {
                        tmp_val = CONST_FLOAT((float)(int_val->get_value()));
                    }
                }
            }
        }
        else {//不是常量
            Ptr<Value> init_val = nullptr;
            if(node.is_inited) {//确认是否有初值
                node.initializers->accept(*this);
                init_val = initValues[0];
            }
            if(scope.in_global()) {//全局变量
                //全局变量的初值一定是常数表达式
                if(node.btype == SyntaxTree::Type::INT) {
                    Ptr<Constant> initializer;
                    if(init_val) {
                        if(init_val->get_type()->is_integer_type()) {
                            initializer = CONST_INT(dynamic_pointer_cast<ConstantInt>(init_val)->get_value());
                        }
                        else if(init_val->get_type()->is_float_type()) {
                            initializer = CONST_INT((int)(dynamic_pointer_cast<ConstantFloat>(init_val)->get_value()));
                        }
                    }
                    else {
                        initializer = CONST_INT(0);
                    }
                    tmp_val = GlobalVariable::create(node.name, module, INT32_T, false, initializer);
                }
                else if(node.btype == SyntaxTree::Type::FLOAT) {
                    Ptr<Constant> initializer;
                    if(init_val) {
                        if(init_val->get_type()->is_integer_type()) {
                            initializer = CONST_FLOAT((float)(dynamic_pointer_cast<ConstantInt>(init_val)->get_value()));
                        }
                        else if(init_val->get_type()->is_float_type()) {
                            initializer = CONST_FLOAT(dynamic_pointer_cast<ConstantFloat>(init_val)->get_value());
                        }
                    }
                    else {
                        initializer = CONST_FLOAT(0);
                    }
                    tmp_val = GlobalVariable::create(node.name, module, FLOAT_T, false, initializer);
                }
            }
            else {//局部变量
                if(node.btype == SyntaxTree::Type::INT) {
                    tmp_val = builder->create_alloca(INT32_T);//分配内存
                    if(init_val) {//有初值则用store存入初值
                        if(init_val->get_type()->is_integer_type()) {
                            builder->create_store(init_val, tmp_val);
                        }
                        else if(init_val->get_type()->is_float_type()) {
                            auto tmp_float_val = std::dynamic_pointer_cast<ConstantFloat>(init_val);
                            if(tmp_float_val)   {//是常量的话就不必用fptosi转换了
                                builder->create_store(CONST_INT((int)(tmp_float_val->get_value())), tmp_val);
                            }
                            else {
                                init_val = builder->create_fptosi(init_val, INT32_T);
                                builder->create_store(init_val, tmp_val);
                            }
                        }
                    }
                    else {//无初值则存入0
                        builder->create_store(CONST_INT(0), tmp_val);
                    }
                }
                else if(node.btype == SyntaxTree::Type::FLOAT) {//浮点型也一样
                    tmp_val = builder->create_alloca(FLOAT_T);
                    if(init_val) {
                        if(init_val->get_type()->is_integer_type()) {
                            auto tmp_int_val = std::dynamic_pointer_cast<ConstantInt>(init_val);
                            if(tmp_int_val) {
                                builder->create_store(CONST_FLOAT((float)(tmp_int_val->get_value())), tmp_val);
                            }
                            else {
                                init_val = builder->create_sitofp(init_val, FLOAT_T);
                                builder->create_store(init_val, tmp_val);
                            }
                        }
                        else if(init_val->get_type()->is_float_type()) {
                            builder->create_store(init_val, tmp_val);
                        }
                    }
                    else {
                        builder->create_store(CONST_FLOAT(0), tmp_val);
                    }
                }
            }
            
        }
    }
    else {//是数组
        node.array_length[0]->accept(*this);//暂时只考虑一维数组
        auto array_len = dynamic_pointer_cast<ConstantInt>(tmp_val)->get_value();
        if(node.is_constant) {//数组常量
            node.initializers->accept(*this);
            if(scope.in_global()) {//全局变量
                if(node.btype == SyntaxTree::Type::INT) {
                    auto array_type = ArrayType::get(INT32_T, array_len);
                    PtrVec<Constant> init_values;//创建全局数组时，必须全部用常量初始化
                    for(int i = 0; i < initValues.size(); i++) {//把初始值压入
                        auto int_val = std::dynamic_pointer_cast<ConstantInt>(initValues[i]);
                        auto float_val = std::dynamic_pointer_cast<ConstantFloat>(initValues[i]);
                        if(int_val) {
                            init_values.push_back(CONST_INT(int_val->get_value()));
                        }
                        else if(float_val) {
                            init_values.push_back(CONST_INT((int)(float_val->get_value())));
                        }
                    }
                    for(int i = init_values.size(); i < array_len; i++) {//如果初始值不够，用0补齐
                        init_values.push_back(CONST_INT(0));
                    }
                    auto initializer = ConstantArray::create(array_type, init_values);//创建初值数组
                    tmp_val = GlobalVariable::create(node.name, module, array_type, true, initializer);
                }
                else if(node.btype == SyntaxTree::Type::FLOAT) {//浮点型也一样
                    auto array_type = ArrayType::get(FLOAT_T, node.array_length.size());
                    PtrVec<Constant> init_values;
                    for(int i = 0; i < initValues.size(); i++) {
                        auto int_val = std::dynamic_pointer_cast<ConstantInt>(initValues[i]);
                        auto float_val = std::dynamic_pointer_cast<ConstantFloat>(initValues[i]);
                        if(int_val) {
                            init_values.push_back(CONST_FLOAT((float)(int_val->get_value())));
                        }
                        else if(float_val) {
                            init_values.push_back(CONST_FLOAT(float_val->get_value()));
                        }
                    }
                    for(int i = init_values.size(); i < array_len; i++) {
                        init_values.push_back(CONST_FLOAT(0));
                    }
                    auto initializer = ConstantArray::create(array_type, init_values);
                    tmp_val = GlobalVariable::create(node.name, module, array_type, true, initializer);
                }
            }
            else {//非全局的常量数组没有对应的API，这里的定义会有问题（ConstantArray无法用变量寻址）
                    //但测试样例中没有这种情况，暂时先这样写
                if(node.btype == SyntaxTree::Type::INT) {
                    PtrVec<Constant> init_values;
                    for(int i = 0; i < initValues.size(); i++) {
                        auto int_val = std::dynamic_pointer_cast<ConstantInt>(initValues[i]);
                        auto float_val = std::dynamic_pointer_cast<ConstantFloat>(initValues[i]);
                        if(int_val) {
                            init_values.push_back(CONST_INT(int_val->get_value()));
                        }
                        else if(float_val) {
                            init_values.push_back(CONST_INT((int)(float_val->get_value())));
                        }
                    }
                    for(int i = init_values.size(); i < array_len; i++) {
                        init_values.push_back(CONST_INT(0));
                    }
                    tmp_val = ConstantArray::create(ArrayType::get(INT32_T, array_len), init_values);
                }
                else if(node.btype == SyntaxTree::Type::FLOAT) {
                    PtrVec<Constant> init_values;
                    for(int i = 0; i < initValues.size(); i++) {
                        auto int_val = std::dynamic_pointer_cast<ConstantInt>(initValues[i]);
                        auto float_val = std::dynamic_pointer_cast<ConstantFloat>(initValues[i]);
                        if(int_val) {
                            init_values.push_back(CONST_FLOAT((float)(int_val->get_value())));
                        }
                        else if(float_val) {
                            init_values.push_back(CONST_FLOAT(float_val->get_value()));
                        }
                    }
                    for(int i = init_values.size(); i < array_len; i++) {
                        init_values.push_back(CONST_FLOAT(0));
                    }
                    tmp_val = ConstantArray::create(ArrayType::get(FLOAT_T, array_len), init_values);
                }
            }
        }
        else {//非常量数组
            if(node.is_inited) {
                node.initializers->accept(*this);
            }
            if(scope.in_global()) {//全局数组变量
                if(node.btype == SyntaxTree::Type::INT) {
                    auto array_type = ArrayType::get(INT32_T, array_len);
                    PtrVec<Constant> init_values;//初值必为常量
                    for(int i = 0; i < initValues.size(); i++) {
                        auto int_val = std::dynamic_pointer_cast<ConstantInt>(initValues[i]);
                        auto float_val = std::dynamic_pointer_cast<ConstantFloat>(initValues[i]);
                        if(int_val) {
                            init_values.push_back(CONST_INT(int_val->get_value()));
                        }
                        else if(float_val) {
                            init_values.push_back(CONST_INT((int)(float_val->get_value())));
                        }
                    }
                    for(int i = init_values.size(); i < array_len; i++) {
                        init_values.push_back(CONST_INT(0));
                    }
                    auto initializer = ConstantArray::create(array_type, init_values);
                    tmp_val = GlobalVariable::create(node.name, module, array_type, false, initializer);
                }
                else if(node.btype == SyntaxTree::Type::FLOAT) {
                    auto array_type = ArrayType::get(FLOAT_T, array_len);
                    PtrVec<Constant> init_values;
                    for(int i = 0; i < initValues.size(); i++) {
                        auto int_val = std::dynamic_pointer_cast<ConstantInt>(initValues[i]);
                        auto float_val = std::dynamic_pointer_cast<ConstantFloat>(initValues[i]);
                        if(int_val) {
                            init_values.push_back(CONST_FLOAT((float)(int_val->get_value())));
                        }
                        else if(float_val) {
                            init_values.push_back(CONST_FLOAT(float_val->get_value()));
                        }
                    }
                    for(int i = init_values.size(); i < array_len; i++) {
                        init_values.push_back(CONST_FLOAT(0));
                    }
                    auto initializer = ConstantArray::create(array_type, init_values);
                    tmp_val = GlobalVariable::create(node.name, module, array_type, true, initializer);
                }
            }
            else {
                if(node.btype == SyntaxTree::Type::INT) {
                    auto array_type = ArrayType::get(INT32_T, array_len);
                    Ptr<Value> init_value;
                    tmp_val = builder->create_alloca(array_type);
                    for(int i = 0; i < initValues.size(); i++) {//有初值则用store存入初值
                        if(initValues[i]->get_type()->is_float_type()) {
                            init_value = builder->create_fptosi(initValues[i], INT32_T);
                        }
                        else {
                            init_value = initValues[i];
                        }
                        auto array_index = CONST_INT(i);
                        auto array_ptr = builder->create_gep(tmp_val, {CONST_INT(0), array_index});
                        builder->create_store(init_value, array_ptr);
                    }
                    for(int i = initValues.size(); i < array_len; i++) {//否则补0
                        auto array_index = CONST_INT(i);
                        auto array_ptr = builder->create_gep(tmp_val, {CONST_INT(0), array_index});
                        builder->create_store(CONST_INT(0), array_ptr);
                    }
                }
                else if(node.btype == SyntaxTree::Type::FLOAT) {//浮点型也一样
                    auto array_type = ArrayType::get(FLOAT_T, array_len);
                    Ptr<Value> init_value;
                    tmp_val = builder->create_alloca(array_type);
                    for(int i = 0; i < initValues.size(); i++) {
                        if(initValues[i]->get_type()->is_integer_type()) {
                            init_value = builder->create_sitofp(initValues[i], FLOAT_T);
                        }
                        else {
                            init_value = initValues[i];
                        }
                        auto array_index = CONST_INT(i);
                        auto array_ptr = builder->create_gep(tmp_val, {CONST_INT(0), array_index});
                        builder->create_store(init_value, array_ptr);
                    }
                    for(int i = initValues.size(); i < array_len; i++) {
                        auto array_index = CONST_INT(i);
                        auto array_ptr = builder->create_gep(tmp_val, {CONST_INT(0), array_index});
                        builder->create_store(CONST_FLOAT(0), array_ptr);
                    }
                }
            }
        }
    }
    scope.push(node.name, tmp_val);
}

void IRBuilder::visit(SyntaxTree::LVal &node) {
    auto lval = scope.find(node.name, false);//找到变量
    auto get_lval = !is_assign;//如果不是赋值语句，那就需要load（即拿到lval的值）
    is_assign = false;//取消assign标记，否则如果出现a[n] = b这种赋值语句，会取得n的指针而非n的值
    auto is_global_const = false;
    if(node.array_index.size()) {//是数组
        PtrVec<Value> array_index;
        for(auto &index : node.array_index) {
            index->accept(*this);
            if(tmp_val) {
                array_index.push_back(tmp_val);
            }
        }
        auto global_lval = dynamic_pointer_cast<GlobalVariable>(lval);
        if(global_lval && global_lval->is_const() && dynamic_pointer_cast<Constant>(array_index[0])) {//是全局常量数组，且下标是常量
            auto init_array = dynamic_pointer_cast<ConstantArray>(global_lval->get_init());//常量不能被再次赋值，因此这里不管是不是assign，都直接取出它的值
            auto init_val = init_array->get_element_value(dynamic_pointer_cast<ConstantInt>(array_index[0])->get_value());
            tmp_val = init_val;
            is_global_const = true;
        }
        else {
            auto array_ptr = builder->create_gep(lval, {CONST_INT(0), array_index[0]});
            if(global_lval && global_lval->is_const()) {//是全局常量数组，但下标不是常量
                                                        //非全局常量数组还不知如何处理，先空着
                tmp_val = builder->create_load(array_ptr);
            }
            else {
                tmp_val = array_ptr;
            }
        }
    }
    else {
        auto global_lval = dynamic_pointer_cast<GlobalVariable>(lval);
        if(global_lval && global_lval->is_const()) {
            auto init_val = global_lval->get_init();
            tmp_val = init_val;
            is_global_const = true;
        }
        else if(dynamic_pointer_cast<ConstantInt>(lval)) {
            auto int_val = std::dynamic_pointer_cast<ConstantInt>(lval);
            tmp_val = CONST_INT(int_val->get_value());
        }
        else if(dynamic_pointer_cast<ConstantFloat>(lval)) {
            auto float_val = std::dynamic_pointer_cast<ConstantFloat>(lval);
            tmp_val = CONST_FLOAT(float_val->get_value());
        }
        else
            tmp_val = lval;
    }
    if(get_lval && !dynamic_pointer_cast<ConstantInt>(lval) && !dynamic_pointer_cast<ConstantFloat>(lval) && !is_global_const) {//需要Lval的不是赋值语句，且不是常量，需要load
                                                                                                                                //这里只考虑了全局常量数组
        tmp_val = builder->create_load(tmp_val);
    }
}

void IRBuilder::visit(SyntaxTree::AssignStmt &node) {
    is_assign = true;
    node.target->accept(*this);
    auto lval = tmp_val;
    is_assign = false;
    node.value->accept(*this);
    auto rval = tmp_val;
    if(lval->get_type()->get_pointer_element_type()->is_integer_type() && rval->get_type()->is_float_type()) {
        rval = builder->create_fptosi(rval, INT32_T);
    }
    else if(lval->get_type()->get_pointer_element_type()->is_float_type() && rval->get_type()->is_integer_type()) {
        rval = builder->create_sitofp(rval, FLOAT_T);
    }
    builder->create_store(rval, lval);
}

void IRBuilder::visit(SyntaxTree::Literal &node) {
    if(node.literal_type == SyntaxTree::Type::INT) {
        tmp_val = CONST_INT(node.int_const);
    }
    else {
        tmp_val = CONST_FLOAT(node.float_const);
    }
}

void IRBuilder::visit(SyntaxTree::ReturnStmt &node) {}

void IRBuilder::visit(SyntaxTree::BlockStmt &node) {}

void IRBuilder::visit(SyntaxTree::EmptyStmt &node) {}

void IRBuilder::visit(SyntaxTree::ExprStmt &node) {}

void IRBuilder::visit(SyntaxTree::UnaryCondExpr &node) {//可能存在问题，暂时先这样写
    node.rhs->accept(*this);
    if(tmp_val->get_type()->is_integer_type() && tmp_val->get_type()->get_size() > 1) {
        tmp_val = builder->create_icmp_ne(tmp_val, CONST_INT(0));
    }
    else if(tmp_val->get_type()->is_float_type()) {
        tmp_val = builder->create_fcmp_ne(tmp_val, CONST_FLOAT(0));
    }
    else {//bool
        tmp_val = builder->create_zext(tmp_val, INT32_T);
        tmp_val = builder->create_icmp_ne(tmp_val, CONST_INT(0));
    }
}

void IRBuilder::visit(SyntaxTree::BinaryCondExpr &node) {}

void IRBuilder::visit(SyntaxTree::BinaryExpr &node) {}

void IRBuilder::visit(SyntaxTree::UnaryExpr &node) {
    node.rhs->accept(*this);
    if(tmp_val) {
        if(node.op == SyntaxTree::UnaryOp::MINUS) {
            if(tmp_val->get_type()->is_integer_type()) {
                tmp_val = builder->create_isub(tmp_val, CONST_INT(0));
            }
            else if(tmp_val->get_type()->is_float_type()) {
                tmp_val = builder->create_fsub(tmp_val, CONST_INT(0));
            }
        }
    }
}

void IRBuilder::visit(SyntaxTree::FuncCallStmt &node) {}

void IRBuilder::visit(SyntaxTree::IfStmt &node) {}

void IRBuilder::visit(SyntaxTree::WhileStmt &node) {}

void IRBuilder::visit(SyntaxTree::BreakStmt &node) {}

void IRBuilder::visit(SyntaxTree::ContinueStmt &node) {}

}
}