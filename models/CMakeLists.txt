cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
project(models)

find_package(Torch REQUIRED)

add_executable(LinearNNPredict LinearNNPredict.cpp)
target_link_libraries(LinearNNPredict "${TORCH_LIBRARIES}")
set_property(TARGET LinearNNPredict PROPERTY CXX_STANDARD 14)