export CC=$LLVM/clang
export CXX=$LLVM/clang++

BASE="-mllvm -equal-branch-prob"
FAST="-mllvm -branch-prob-predict-linear"

rm -rf build1 build2 

(mkdir -p build1; cd build1; cmake -G Ninja ../z3 -DCMAKE_CXX_FLAGS="$BASE" && ninja)
(mkdir -p build2; cd build2; cmake -G Ninja ../z3 -DCMAKE_CXX_FLAGS="$BASE" && ninja)
(time -p ./build1/z3 ./input.txt)
(time -p ./build2/z3 ./input.txt)

