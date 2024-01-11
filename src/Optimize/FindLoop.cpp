#include "FindLoop.h"
#include <fstream>

#include <algorithm>

namespace SysYF
{
namespace IR
{
void FindLoop::execute() {
    for(auto &func : module->get_functions()) {
        if(func->get_basic_blocks().empty()) {
            continue;
        }
        else {
            func_ = func;
        }
        auto entry = func->get_entry_block();
        visited_.clear();
        back_edges_.clear();
        num_ = 0;
        dfs(entry);
        func_->set_back_edges(back_edges_);
        for(auto &back_edge : back_edges_) {
            auto loop = Loop::create_loop();
            loop->add_block(back_edge.first);
            loop->add_block(back_edge.second);
            visited_.clear();
            visited_.insert(back_edge.second);
            reverse_dfs(back_edge.first, loop);
            func->add_loop(loop);
        }
        find_inner_loop(func);
        get_loop_entry(func);
    }
    dump();
}

void FindLoop::add_back_edge(Ptr<BasicBlock> from, Ptr<BasicBlock> to) {
    back_edges_.push_back(std::make_pair(from, to));
}

void FindLoop::dfs(Ptr<BasicBlock> block) {
    block->set_num(num_++);
    visited_.insert(block);
    for(auto &succ : block->get_succ_basic_blocks()) {
        if(visited_.find(succ) == visited_.end()) {
            dfs(succ);
        }
        else {
            bool is_back_edge = false;
            auto idom = block->get_idom();
            while(idom && idom!=idom->get_idom()) {
                if(idom == succ) {
                    is_back_edge = true;
                    break;
                }
                idom = idom->get_idom();
            }
            if(is_back_edge) {
                add_back_edge(block, succ);
            }
        }
    }
}

void FindLoop::reverse_dfs(Ptr<BasicBlock> block, Ptr<Loop> &loop) {
    loop->add_block(block);
    visited_.insert(block);
    for(auto &pred : block->get_pre_basic_blocks()) {
        if(visited_.find(pred) == visited_.end()) {
            reverse_dfs(pred, loop);
        }
    }
}

void FindLoop::dump() {
    std::fstream f;
    f.open(fldump, std::ios::out);
    for(auto &func : module->get_functions()) {
        auto num = 0;
        if(func->get_basic_blocks().empty()) {
            continue;
        }
        f << "Function: " << func->get_name() << ", " << func->get_loops().size() << " loops" << std::endl;
        f << "Back edges: " << std::endl;
        for(auto &back_edge : func->get_back_edges()) {
            f << back_edge.first->get_name() << " -> " << back_edge.second->get_name() << std::endl;
        }
        for(auto &loop : func->get_loops()) {
            f << "Loop " << num++ << ": " << std::endl;
            f << "Entry: " << loop->get_loop_entry()->get_name() << std::endl;
            f << "Have " << loop->get_sub_loops().size() << " sub loops" << std::endl;
            f << "Have " << loop->get_parent_loops().size() << " parent loops" << std::endl;
            f << "Blocks: " << std::endl;
            for(auto &block : loop->get_blocks()) {
                f << block->get_name() << std::endl;
            }
        }
    }
}

bool less_than(Ptr<Loop> a, Ptr<Loop> b) {
    return a->get_blocks().size() < b->get_blocks().size();
}

void find_inner_loop(Ptr<Function> func) {
    std::sort(func->get_loops().begin(), func->get_loops().end(), less_than);
    for(int i = 0; i < func->get_loops().size(); i++) {
        for(int j = i + 1; j < func->get_loops().size(); j++) {
            auto &loop1 = func->get_loops()[i];
            auto &loop2 = func->get_loops()[j];
            if(loop1->get_blocks().size() == loop2->get_blocks().size()) {
                continue;
            }
            bool is_inner = true;
            for(auto &block : loop1->get_blocks()) {
                if(loop2->get_blocks().find(block) == loop2->get_blocks().end()) {
                    is_inner = false;
                    break;
                }
            }
            if(is_inner) {
                loop1->add_parent_loop(loop2);
                loop2->add_sub_loop(loop1);
            }
        }
    }
}

void get_loop_entry(Ptr<Function> func) {
    for(auto loop : func->get_loops()) {
        bool is_entry = true;
        for(auto block : loop->get_blocks()) {
            for(auto block2 : loop->get_blocks()) {
                if(block == block2) {
                    continue;
                }
                auto idom = block2->get_idom();
                while(idom && idom != idom->get_idom()) {
                    if(idom == block) {
                        break;
                    }
                    idom = idom->get_idom();
                }
                if(idom != block) {
                    is_entry = false;
                    break;
                }
            }
            if (is_entry) {
                loop->set_loop_entry(block);
                break;
            }
            is_entry = true;
        }
    }
}
}
}