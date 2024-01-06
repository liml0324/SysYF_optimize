#include <iostream>
#include "IRBuilder.h"
#include "SysYFDriver.h"
#include "SyntaxTreePrinter.h"
#include "ErrorReporter.h"
#include "Pass.h"
#include "DominateTree.h"
#include "Mem2Reg.h"
#include "ActiveVar.h"
#include "ConstCalc.h"
#include "DCE.h"

using namespace SysYF::IR;

void print_help(const std::string& exe_name) {
  std::cout << "Usage: " << exe_name
            << " [ -h | --help ] [ -p | --trace_parsing ] [ -s | --trace_scanning ] [ -emit-ast ] [ -emit-ir ] [ -o <output-file> ]"
            << " <input-file>"
            << std::endl;
}

int main(int argc, char *argv[])
{
    SysYFDriver driver;
    SysYF::SyntaxTree::SyntaxTreePrinter printer;
    auto builder = SysYF::IR::IRBuilder::create();

    bool print_ast = false;
    bool print_ir = false;
    bool optimize = false;
    bool optimize_all = false;
    bool av = false;

    // std::string filename = "testcase.sy";
    std::string filename = "../Student/task3/test/03_empty_stmt.sy";
    std::string output_llvm_file = "testcase.ll";
    for (int i = 1; i < argc; ++i) {
        if (argv[i] == std::string("-h") || argv[i] == std::string("--help")) {
            print_help(argv[0]);
            return 0;
        }
        else if (argv[i] == std::string("-p") || argv[i] == std::string("--trace_parsing"))
            driver.trace_parsing = true;
        else if (argv[i] == std::string("-s") || argv[i] == std::string("--trace_scanning"))
            driver.trace_scanning = true;
        else if (argv[i] == std::string("-emit-ast"))
            print_ast = true;
        else if (argv[i] == std::string("-emit-ir"))
            print_ir = true;
        else if (argv[i] == std::string("-o")){
            output_llvm_file = argv[++i];
        }
        else if (argv[i] == std::string("-O2")){
            optimize_all = true;
            optimize = true;
        }
        else if (argv[i] == std::string("-O")){
            optimize = true;
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
    if (print_ir) {
        root->accept(*builder);
        auto m = builder->getModule();
        m->set_file_name(filename);
        m->set_print_name();
        if(optimize) {
            // std::cout << "Optimizing..." << std::endl;
            PassMgr passmgr(m);
            passmgr.addPass<DominateTree>();
            passmgr.addPass<Mem2Reg>();
            if(optimize_all){
                passmgr.addPass<ConstCalc>();
                passmgr.addPass<ActiveVar>();
                passmgr.addPass<DCE>();
                //  ...
            }
            else {
                if(av){
                    passmgr.addPass<ActiveVar>();
                }
                //  ...
            }
            passmgr.execute();
            m->set_print_name();
        }
        auto IR = m->print();
        std::ofstream output_stream;
        output_stream.open(output_llvm_file, std::ios::out);
        output_stream << IR;
        output_stream.close();
    }
    return 0;
}
