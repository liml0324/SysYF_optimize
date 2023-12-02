#ifndef _SYSYF_MODULE_H_
#define _SYSYF_MODULE_H_

#include <string>
#include <list>
#include <map>

#include "internal_types.h"
#include "internal_macros.h"
#include "Type.h"
#include "GlobalVariable.h"
#include "Value.h"
#include "Function.h"

namespace SysYF
{
namespace IR
{
class GlobalVariable;
class Module;

class Module : public std::enable_shared_from_this<Module>
{
public:
    static Ptr<Module> create(std::string name);
    ~Module() = default;
    
    Ptr<Type> get_void_type();
    Ptr<Type> get_label_type();
    Ptr<IntegerType> get_int1_type();
    Ptr<IntegerType> get_int32_type();
    Ptr<FloatType> get_float_type();
    Ptr<PointerType> get_int32_ptr_type();
    Ptr<PointerType> get_float_ptr_type();

    Ptr<PointerType> get_pointer_type(Ptr<Type> contained);
    Ptr<ArrayType> get_array_type(Ptr<Type> contained, unsigned num_elements);

    void add_function(Ptr<Function> f);
    PtrList<Function> &get_functions();
    void add_global_variable(Ptr<GlobalVariable> g);
    PtrList<GlobalVariable> &get_global_variable();
    std::string get_instr_op_name( Instruction::OpID instr ) { return instr_id2string_[instr]; }
    void set_print_name();
    void set_file_name(std::string name){source_file_name_ = name;}
    std::string get_file_name(){return source_file_name_;}
    virtual std::string print();
private:
    explicit Module(std::string name);
    void init(std::string name);
    PtrList<GlobalVariable> global_list_;   // The Global Variables in the module
    PtrList<Function> function_list_;       // The Functions in the module
    std::map<std::string, Ptr<Value>> value_sym_;   // Symbol table for values
    std::map<Instruction::OpID, std::string> instr_id2string_;   // Instruction from opid to string 
    
    std::string module_name_;         // Human readable identifier for the module
    std::string source_file_name_;    // Original source file name for module, for test and debug

private:
    Ptr<IntegerType> int1_ty_;
    Ptr<IntegerType> int32_ty_;
    Ptr<FloatType> float32_ty_;
    Ptr<Type> label_ty_;
    Ptr<Type> void_ty_;    
    
    std::map<Ptr<Type> , Ptr<PointerType>> pointer_map_;
    std::map<std::pair<Ptr<Type> ,int>, Ptr<ArrayType> > array_map_; 
};

}
}

#endif // _SYSYF_MODULE_H_