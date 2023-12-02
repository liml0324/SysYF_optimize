#ifndef _SYSYF_INTERNAL_MACROS_H_
#define _SYSYF_INTERNAL_MACROS_H_

#include "internal_types.h"

namespace SysYF
{

#define _RET_AFTER_INIT(t, ...) \
    { \
        auto tmp = Ptr<t>(new t(__VA_ARGS__)); \
        tmp->init(__VA_ARGS__) ; \
        return tmp; \
    } 

#define RET_AFTER_INIT(t, ...) _RET_AFTER_INIT(t, ##__VA_ARGS__)

}

#endif // _SYSYF_INTERNAL_MACROS_H_