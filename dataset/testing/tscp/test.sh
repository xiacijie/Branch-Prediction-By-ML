export CC=$LLVM/clang
export CXX=$LLVM/clang++

FAST="-Os -mllvm -branch-prob-predict-linear"
REG="-Os -mllvm -equal-branch-prob"

rm -rf build1 build2

(cp -r TSCP/ build1; cd build1/; $CC *.c $FAST -o tscp)
(cp -r TSCP/ build2; cd build2/; $CC *.c $REG  -o tscp)
time -p ./build1/tscp <note.txt > /dev/null
time -p ./build2/tscp <note.txt > /dev/null

