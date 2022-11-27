export CC=$LLVM/clang
export CXX=$LLVM/clang++

export BASE="-mllvm -equal-branch-prob"
export FAST="-mllvm -branch-prob-predict-linear"

(mkdir -p build1; cd build1; cmake -G Ninja ../libuv -DCMAKE_C_FLAGS="$FAST" $RL && ninja)
(mkdir -p build2; cd build2; cmake -G Ninja ../libuv -DCMAKE_C_FLAGS="$BASE" $RL && ninja)

(time -p ./build1/uv_run_benchmarks_a async4)
(time -p ./build2/uv_run_benchmarks_a async4)


