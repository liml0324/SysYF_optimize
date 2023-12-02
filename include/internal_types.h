#ifndef _SYSYF_INTERNAL_TYPES_H_
#define _SYSYF_INTERNAL_TYPES_H_

#include <memory>
#include <vector>
#include <list>
#include <set>

namespace SysYF
{

template <typename T>
using Ptr = std::shared_ptr<T>;

// Vector of reference of type
template <typename T>
using PtrVec = std::vector<Ptr<T>>;

// List of reference of type
template <typename T>
using PtrList = std::list<Ptr<T>>;

// Set of reference of type
template <typename T>
using PtrSet = std::set<Ptr<T>>;

using std::static_pointer_cast;
using std::dynamic_pointer_cast;
using std::const_pointer_cast;

}


#endif // !_SYSYF_INTERNAL_TYPES_H_