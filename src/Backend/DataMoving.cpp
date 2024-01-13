#include<CodeGen.h>
#include<string>

/*
    code for moving data from src list to dst list:
        - parameter `src` contains data sources, they can be constant (immediate),
          register or address on stack (address specified by base register and offset)
        - parameter `dst` contains data destinations, they can be register 
          or address on stack (address specified by base register and offset)
        - parameter `cmpop` is used to generate instructions with conditional excution method
    
    you should generate code for data moving, the method for moving single data from a source location (or const)
    to a destination location is given, parameters:
        - `src_loc` is data source location, can be constant (immediate),
          register or address on stack (address specified by base register and offset)
        - parameter `dst` contains data destinations, they can be register 
          or address on stack (address specified by base register and offset)
        - parameter `reg_tmp` is the temporary register used for data moving under situations like
            - moving data from stack location to another (this function doesn't distinguish if the location is the same)
            - moving constant value (immediate) to a stack location
            - ...
        - parameter `cmpop` is used to generate instructions with conditional excution method
    the function may generate more than one instruction.
*/

namespace SysYF{
namespace IR{
    std::string CodeGen::data_move(PtrVec<IR2asm::Location> &src,
                                   PtrVec<IR2asm::Location> &dst,
                                   std::string cmpop){
        std::string code;
        
        /* TODO: put your code here */
        //寻找空闲寄存器（该方法中需要最多一个永久空闲的临时寄存器）
        auto reg_tmp=Ptr<IR2asm::Reg>(new IR2asm::Reg(12));
        //建立有向依赖图
        depend_graph.clear();
        depend_graph=create_dep_graph(src,dst);
        //由于限制，所有顶点都至多有一条出边，所以，按逆拓扑先处理无出度顶点后，剩余图为若干圈的并集
        //为没有出边的顶点赋值
        std::set<Ptr<IR2asm::Location>,cmp_out_num> dec_out_vec;
        auto cur_dst=*(dec_out_vec.begin());
        while(depend_graph[cur_dst].size()==1){
            //找到了无出度的顶点
            auto cur_src=depend_graph[cur_dst][0];
            if(cur_src!=nullptr){
                //有入度
                code+=single_data_move(cur_src,cur_dst,reg_tmp,cmpop);
                auto src_out_list=depend_graph[cur_src];
                for(auto it=src_out_list.begin();it!=src_out_list.end();it++){
                    if(*it==cur_dst){
                        src_out_list.erase(it);
                        (*it)->out_deg--;
                        break;
                    }
                }
            }else{
                //无入度
            }
            depend_graph.erase(cur_dst);
            dec_out_vec.erase(dec_out_vec.begin());
            cur_dst=*(dec_out_vec.begin());
        }
        //获取空闲寄存器
        auto reg_tmp_2=Ptr<IR2asm::Location>(new IR2asm::RegLoc(10));
        //找环，直到所有顶点都被赋值
        while(!depend_graph.empty()){
            //找到一个环(1<-2<-3<-4<-...)
            std::set<Ptr<IR2asm::Location>> cur_circle;
            auto cur_dst=depend_graph.begin()->first;
            auto cur_src=depend_graph[cur_dst][0];
            cur_circle.insert(cur_dst);
            auto start=cur_dst;
            while(cur_src!=start){
                cur_circle.insert(cur_src);
                cur_dst=cur_src;
                cur_src=depend_graph[cur_dst][0];
            }
            //处理环
            auto it=cur_circle.begin();
            auto last=it++;
            code+=single_data_move(*last,reg_tmp_2,reg_tmp,cmpop);
            for(;it!=cur_circle.end();it++){
                code+=single_data_move(*it,*last,reg_tmp,cmpop);
                last=it;
            }
            code+=single_data_move(reg_tmp_2,*last,reg_tmp,cmpop);
            //删除环
            for(auto it=cur_circle.begin();it!=cur_circle.end();it++){
                depend_graph.erase(*it);
            }
        }
        return code;
    }

    //返回依赖图
    //loc->(src(loc),dsts(loc))
    std::map<Ptr<IR2asm::Location>,PtrVec<IR2asm::Location>> CodeGen::create_dep_graph(
        PtrVec<IR2asm::Location> &src,
        PtrVec<IR2asm::Location> &dst)
    {
        std::map<Ptr<IR2asm::Location>,PtrVec<IR2asm::Location>> depend_graph;
        for(int i=0;i<src.size();i++){
            auto cur_src=src[i];
            auto cur_dst=dst[i];
            //对dst去重
            if(dynamic_pointer_cast<IR2asm::RegLoc>(cur_dst)){
                auto it=depend_graph.begin();
                for(;it!=depend_graph.end();it++){
                    if(it->first->get_code()==cur_dst->get_code()){
                        cur_dst=it->first;
                        break;
                    }
                }
                if(it==depend_graph.end()){
                    depend_graph[cur_dst]=PtrVec<IR2asm::Location>();
                    depend_graph[cur_dst].push_back(nullptr);
                }
            }
            else{
                if(depend_graph.find(cur_dst)==depend_graph.end()){
                    depend_graph[cur_dst]=PtrVec<IR2asm::Location>();
                    depend_graph[cur_dst].push_back(nullptr);
                }
            }
            //对src去重
            //src为常数或寄存器
            if(dynamic_pointer_cast<IR2asm::RegLoc>(cur_src)){
                //将dst加入src的终点列表
                auto cur_regloc=dynamic_pointer_cast<IR2asm::RegLoc>(cur_src);
                auto it=depend_graph.begin();
                    for(;it!=depend_graph.end();it++){
                        if(it->first->get_code()==cur_regloc->get_code()){
                            cur_src=it->first;
                            break;
                        }
                    }
                    if(it==depend_graph.end()){
                        depend_graph[cur_regloc]=PtrVec<IR2asm::Location>();
                        depend_graph[cur_regloc].push_back(nullptr);
                    }
            }
            //src为栈
            else{
                auto cur_stackloc=dynamic_pointer_cast<IR2asm::Regbase>(cur_src);
                if(depend_graph.find(cur_stackloc)==depend_graph.end()){
                    depend_graph[cur_stackloc]=PtrVec<IR2asm::Location>();
                    depend_graph[cur_stackloc].push_back(nullptr);
                }
            }
            //将(src,dst)加入图中
            if(cur_src!=cur_dst){
                depend_graph[cur_src].push_back(cur_dst);
                depend_graph[cur_dst][0]=cur_src;
            }
        }
        return depend_graph;
    }

    std::string CodeGen::single_data_move(Ptr<IR2asm::Location> src_loc,
                                 Ptr<IR2asm::Location> target_loc,
                                 Ptr<IR2asm::Reg>reg_tmp,
                                 std::string cmpop){
        std::string code;
        //src为寄存器或常数
        if(dynamic_pointer_cast<IR2asm::RegLoc>(src_loc)){
            auto regloc = dynamic_pointer_cast<IR2asm::RegLoc>(src_loc);
            //src为常数
            if(regloc->is_constant()){
                //target为寄存器
                if(dynamic_pointer_cast<IR2asm::RegLoc>(target_loc)){
                    auto target_reg_loc = dynamic_pointer_cast<IR2asm::RegLoc>(target_loc);
                    code += IR2asm::space;
                    code += "Ldr" + cmpop + " ";
                    code += target_reg_loc->get_code();
                    code += ", =";
                    code += std::to_string(regloc->get_constant());
                    code += IR2asm::endl;
                }
                //target为栈
                else{
                    code += IR2asm::space;
                    code += "Ldr" + cmpop + " ";
                    code += reg_tmp->get_code();
                    code += ", =";
                    code += std::to_string(regloc->get_constant());
                    code += IR2asm::endl;
                    code += IR2asm::safe_store(reg_tmp, target_loc, sp_extra_ofst, long_func, cmpop);
                }
            }
            //src为寄存器
            else{
                if(dynamic_pointer_cast<IR2asm::RegLoc>(target_loc)){
                    auto target_reg_loc = dynamic_pointer_cast<IR2asm::RegLoc>(target_loc);
                    code += IR2asm::space;
                    code += "Mov" + cmpop + " ";
                    code += target_reg_loc->get_code();
                    code += ", ";
                    code += regloc->get_code();
                    code += IR2asm::endl;
                }
                else{
                    code += IR2asm::safe_store(Ptr<IR2asm::Reg>(new IR2asm::Reg(regloc->get_reg_id())),
                                                target_loc, sp_extra_ofst, long_func, cmpop);
                }
            }
        }
        //src为栈
        else{
            auto stackloc = dynamic_pointer_cast<IR2asm::Regbase>(src_loc);
            //target为寄存器
            if(dynamic_pointer_cast<IR2asm::RegLoc>(target_loc)){
                auto target_reg_loc = dynamic_pointer_cast<IR2asm::RegLoc>(target_loc);
                code += IR2asm::safe_load(Ptr<IR2asm::Reg>(new IR2asm::Reg(target_reg_loc->get_reg_id())),
                                            stackloc, sp_extra_ofst, long_func, cmpop);
            }
            //target为栈
            else{
                code += IR2asm::safe_load(reg_tmp, stackloc, sp_extra_ofst, long_func, cmpop);
                code += IR2asm::safe_store(reg_tmp, target_loc, sp_extra_ofst, long_func, cmpop);
            }
        }
        return code;
    }
}
}