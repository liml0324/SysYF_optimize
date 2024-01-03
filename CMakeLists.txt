project(SysYFCompiler)

cmake_minimum_required(VERSION 3.5)

set(CMAKE_CXX_STANDARD 14)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0 -Wall -Wextra -Wno-unused -Wshadow -g -pedantic")

# include generated files in project environment
include_directories(${CMAKE_CURRENT_BINARY_DIR})

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/AST)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/ErrorReporter)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/Frontend)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/SysYFIR)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/SysYFIRBuilder)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/Optimize)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/Log)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src/AST)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src/ErrorReporter)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src/Frontend)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src/SysYFIR)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src/SysYFIRBuilder)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src/Optimize)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src/Log)

add_executable(
  SysYFCompiler
  ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp
)

target_link_libraries(
  SysYFCompiler
  SysYFPass
  SysYFIRBuilder
  IRLib
  Driver
  ASTPrinter
  ErrReporter
  Log
)
