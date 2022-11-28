
export CC=$LLVM/clang
export CXX=$LLVM/clang++

FAST="-mllvm -branch-prob-predict-linear"
BASE="-mllvm -equal-branch-prob"
rm -rf oggenc1
rm -rf oggenc2

$LLVM/clang oggenc.c -Os -Wall -g -lm $FAST -o oggenc1
$LLVM/clang oggenc.c -Os -Wall -g -lm $BASE -o oggenc2
cat /dev/urandom | head -c 30000000 > payload.bin
(time -p ./oggenc1 -raw -Q payload.bin)
(time -p ./oggenc2 -raw -Q payload.bin)


