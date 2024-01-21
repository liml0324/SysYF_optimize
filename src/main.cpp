#include <iostream>
#include "IRBuilder.h"
#include "SysYFDriver.h"
#include "SyntaxTreePrinter.h"
#include "ErrorReporter.h"
#include "SyntaxTreeChecker.h"
#include "Pass.h"
#include "DominateTree.h"
#include "Mem2Reg.h"
#include "ActiveVar.h"
#include "ConstCalc.h"
#include "DCE.h"
#include "DBE.h"
#include "LocalCSE.h"
#include "FindLoop.h"
#include "LoopCodeMotion.h"
#include "FindPureFunc.h"
#include "LIR.h"
#include "MovConst.h"
#include "CodeGen.h"

using namespace SysYF::IR;

void print_help(const std::string& exe_name) {
  std::cout << "Usage: " << exe_name
            << " [ -h | --help ] [ -p | --trace_parsing ] [ -s | --trace_scanning ] [ -emit-ast ] [ -check ]"
            << " [ -emit-ir ] [ -S ] [ -O2 ] [ -O ] [ -o <output-file> ]"
            << " <input-file>"
            << std::endl;
}

int main(int argc, char *argv[])
{
    SysYFDriver driver;
    SysYF::SyntaxTree::SyntaxTreePrinter printer;
    auto builder = SysYF::IR::IRBuilder::create();
    SysYF::ErrorReporter reporter(std::cerr);
    SysYF::SyntaxTree::SyntaxTreeChecker checker(reporter);

    bool print_ast = false;
    bool emit_ir = false;
    bool check = false;
    bool optimize_all = false;
    bool optimize = false;
    bool emit_assembly = false;

    bool cse = false;
    bool av = false;

    std::string filename = "-";
    std::string output_file = "-";
    for (int i = 1; i < argc; ++i) {
        if (argv[i] == std::string("-h") || argv[i] == std::string("--help")) {
            print_help(argv[0]);
            return 0;
        }
        else if (argv[i] == std::string("-p") || argv[i] == std::string("--trace_parsing")) {
            driver.trace_parsing = true;
        }
        else if (argv[i] == std::string("-s") || argv[i] == std::string("--trace_scanning")){
            driver.trace_scanning = true;
        }
        else if (argv[i] == std::string("-emit-ast")) {
            print_ast = true;
        }
        else if (argv[i] == std::string("-emit-ir")){
            emit_ir = true;
        }
        else if(argv[i] == std::string("-S")){
            emit_assembly = true;
        }
        else if (argv[i] == std::string("-o")){
            output_file = argv[++i];
        }
        else if (argv[i] == std::string("-check")){
            check = true;
        }
        else if (argv[i] == std::string("-O2")){
            optimize_all = true;
            optimize = true;
        }
        else if (argv[i] == std::string("-O") || argv[i] == std::string("-O1")){
            optimize = true;
        }
        else if (argv[i] == std::string("-O0")){
            optimize = false;
        }
        else if(argv[i] == std::string("-cse")){
            cse = true;
        }
        else if(argv[i] == std::string("-av")){
            av = true;
        }
        else {
            filename = argv[i];
        }
    }
    auto root = driver.parse(filename);
    if (print_ast)
        root->accept(printer);
    if (check)
        root->accept(checker);
    if (emit_ir || emit_assembly) {
        root->accept(*builder);
        auto m = builder->getModule();
        m->set_file_name(filename);
        m->set_print_name();
        if(optimize || emit_assembly){
            PassMgr passmgr(m);
            passmgr.addPass<DominateTree>();
            passmgr.addPass<Mem2Reg>();
            if(optimize_all){
                // passmgr.addPass<ComSubExprEli>();
                passmgr.addPass<ConstCalc>();
                passmgr.addPass<FindPureFunc>();
                passmgr.addPass<LocalCSE>();
                passmgr.addPass<FindLoop>();
                passmgr.addPass<LoopCodeMotion>();
                //这里多删除几次，一次可能删不干净
                passmgr.addPass<DCE>();
                passmgr.addPass<DBE>();
                passmgr.addPass<DCE>();
                passmgr.addPass<DBE>();
                passmgr.addPass<DCE>();
                passmgr.addPass<ActiveVar>();
            }
            else {
                if(cse){
                    // passmgr.addPass<ComSubExprEli>();
                }
                if(av || emit_assembly){ // HurryPeng: emit_assembly depends on ActiveVar! 
                    passmgr.addPass<ActiveVar>();
                }
            }
            if(emit_assembly){
                passmgr.addPass<LIR>();
                passmgr.addPass<MovConst>();
            }
            passmgr.execute();
            m->set_print_name();
        }
        if(emit_assembly){
            CodeGen coder = CodeGen();
            auto asmcode = coder.module_gen(m);
            if(output_file == "-"){
                std::cout << asmcode;
            }
            else{
                std::ofstream output_stream;
                output_stream.open(output_file, std::ios::out);
                output_stream << asmcode;
                output_stream.close();
            }
        }
        else{
            auto IR = m->print();
            if(output_file == "-"){
                std::cout << IR;
            }
            else {
                std::ofstream output_stream;
                output_stream.open(output_file, std::ios::out);
                output_stream << IR;
                output_stream.close();
            }
        }
    }
    return 0;
}
