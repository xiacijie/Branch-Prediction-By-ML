export CC=$LLVM/clang
export CXX=$LLVM/clang++

rm -rf build1 build2 

export BASE="-mllvm -equal-branch-prob"
export FAST="-mllvm -branch-prob-predict-mlpr"

(mkdir -p build1; cd build1; cmake -G Ninja ../z3 -DCMAKE_CXX_FLAGS="$FAST" && ninja)
(mkdir -p build2; cd build2; cmake -G Ninja ../z3 -DCMAKE_CXX_FLAGS="$BASE" && ninja)
(time -p ./build1/z3 ./input.txt)
(time -p ./build2/z3 ./input.txt)

