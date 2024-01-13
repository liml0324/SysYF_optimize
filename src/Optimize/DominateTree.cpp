#include "Pass.h"
#include "DominateTree.h"

namespace SysYF
{
namespace IR
{
void DominateTree::execute() {
    for(auto f:module->get_functions()){
        if(f->get_basic_blocks().empty()){
            continue;
        }
        get_bb_idom(f);
        get_bb_dom_front(f);
    }
}

void DominateTree::get_post_order(Ptr<BasicBlock>bb,PtrSet<BasicBlock>& visited) {
    // 按后序遍历编号
    visited.insert(bb);
    auto children = bb->get_succ_basic_blocks();
    for(auto child : children){
        auto is_visited = visited.find(child);
        if(is_visited == visited.end()){
            get_post_order(child, visited);
        }
    }
    bb2int[bb] = reverse_post_order.size();
    reverse_post_order.push_back(bb);
}

void DominateTree::get_revserse_post_order(Ptr<Function>f) {
    // 倒过来的后序
    doms.clear();
    reverse_post_order.clear();
    bb2int.clear();
    auto entry = f->get_entry_block();
    PtrSet<BasicBlock> visited = {};
    get_post_order(entry,visited);
    reverse_post_order.reverse();
}

//ref:https://www.cs.rice.edu/~keith/EMBED/dom.pdf
void DominateTree::get_bb_idom(Ptr<Function>f) {
    get_revserse_post_order(f);

    auto root = f->get_entry_block();
    auto root_id = bb2int[root];// 这里的编号仍然是按后序遍历编的号
    // 除入口外，初始支配节点均为空
    for(int i = 0;i < root_id;i++){
        doms.push_back(nullptr);
    }
    //入口的支配节点为自己
    doms.push_back(root);

    bool changed = true;
    while(changed){
        changed = false;
        for(auto bb:reverse_post_order){
            if(bb == root){
                continue;
            }
            auto preds = bb->get_pre_basic_blocks();
            Ptr<BasicBlock> new_idom = nullptr;
            for(auto pred_bb:preds){
                // 有前驱节点支配节点已知，直接取该前驱节点
                if(doms[bb2int[pred_bb]] != nullptr){
                    new_idom = pred_bb;
                    break;
                }
            }
            for(auto pred_bb:preds){
                // 有别的前驱节点支配节点已知，取前驱与当前直接支配节点的最近公共支配祖先
                // 这是因为直接支配节点一定支配它的所有前驱，所有前驱的公共支配节点一定支配它
                if(doms[bb2int[pred_bb]] != nullptr){
                    new_idom = intersect(pred_bb,new_idom);
                }
            }
            if(doms[bb2int[bb]] != new_idom){
                doms[bb2int[bb]] = new_idom;
                changed = true;
            }
        }
    }

    for(auto bb:reverse_post_order){
        bb->set_idom(doms[bb2int[bb]]);
    }
}

void DominateTree::get_bb_dom_front(Ptr<Function>f) {
    for(auto b:f->get_basic_blocks()){
        auto b_pred = b->get_pre_basic_blocks();
        if(b_pred.size() >= 2){
            for(auto pred:b_pred){
                auto runner = pred;
                while(runner!=doms[bb2int[b]]){
                    runner->add_dom_frontier(b);
                    runner = doms[bb2int[runner]];
                }
            }
        }
    }
}

Ptr<BasicBlock> DominateTree::intersect(Ptr<BasicBlock>b1, Ptr<BasicBlock>b2) {
    auto finger1 = b1;
    auto finger2 = b2;
    while(finger1!=finger2){
        // 后序遍历编号，编号大的是祖先
        // 所以寻找公共支配祖先时，编号小的先往上走
        while(bb2int[finger1]<bb2int[finger2]){
            finger1 = doms[bb2int[finger1]];
        }
        while(bb2int[finger2]<bb2int[finger1]){
            finger2 = doms[bb2int[finger2]];
        }
    }
    return finger1;
}
}
}