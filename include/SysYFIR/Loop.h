#include "Value.h"
#include "Instruction.h"
#include "Module.h"
#include "Function.h"

#include <list>
#include <set>
#include <string>

namespace SysYF
{
namespace IR
{
class Loop {
public: 
    static Ptr<Loop> create_loop() { return Ptr<Loop>(new Loop()); }
    static Ptr<Loop> create_loop(PtrSet<BasicBlock> &blocks) { return Ptr<Loop>(new Loop(blocks)); }
    PtrSet<BasicBlock> &get_blocks() { return blocks; }
    PtrSet<Loop> &get_sub_loops() { return sub_loops; }
    PtrSet<Loop> &get_parent_loops() { return parent_loops; }
    void set_blocks(PtrSet<BasicBlock> &set) { blocks = set; }
    void set_sub_loops(PtrSet<Loop> &set) { sub_loops = set; }
    void set_parent_loops(PtrSet<Loop> &set) { parent_loops = set; }
    void add_block(Ptr<BasicBlock> block) { blocks.insert(block); }
    void add_sub_loop(Ptr<Loop> loop) { sub_loops.insert(loop); }
    void add_parent_loop(Ptr<Loop> loop) { parent_loops.insert(loop); }
    void remove_block(Ptr<BasicBlock> block) { blocks.erase(block); }
    void remove_sub_loop(Ptr<Loop> loop) { sub_loops.erase(loop); }
    void remove_parent_loop(Ptr<Loop> loop) { parent_loops.erase(loop); }
    void clear_blocks() { blocks.clear(); }
    void clear_sub_loops() { sub_loops.clear(); }
    void clear_parent_loops() { parent_loops.clear(); }
    bool is_empty() { return blocks.empty(); }
private:
    Loop() = default;
    explicit Loop(PtrSet<BasicBlock> &blocks) : blocks(blocks) {}
    PtrSet<BasicBlock> blocks;
    PtrSet<Loop> sub_loops;
    PtrSet<Loop> parent_loops;
};
}
}