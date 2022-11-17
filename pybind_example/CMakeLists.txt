cmake_minimum_required(VERSION 3.4)
project(example)

set(CMAKE_BUILD_TYPE Debug)

add_subdirectory(../extern/pybind11/ build/pybind11)
include_directories(../extern/eigen/)

add_executable(example example.cpp)
target_link_libraries(example PRIVATE pybind11::embed)