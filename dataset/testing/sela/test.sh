export CC=$LLVM/clang
export CXX=$LLVM/clang++

BASE="-mllvm -equal-branch-prob"
FAST="-mllvm -branch-prob-predict-linear"

rm -rf build1
rm -rf build2

RL=-DCMAKE_BUILD_TYPE=Release
(mkdir -p build1; cd build1; cmake -G Ninja ../sela -DCMAKE_CXX_FLAGS="$FAST" $RL && ninja)
(mkdir -p build2; cd build2; cmake -G Ninja ../sela -DCMAKE_CXX_FLAGS="$BASE"      $RL && ninja)

(time -p ./build1/sela -e ../oggvorbis/tune.wav 1.sela)
(time -p ./build2/sela -e ../oggvorbis/tune.wav 2.sela)

