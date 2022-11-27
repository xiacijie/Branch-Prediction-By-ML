export CC=$LLVM/clang
export CXX=$LLVM/clang++
export SRC=sqlite-autoconf-3370000

FAST="-Os -mllvm -branch-prob-predict-linear"
BASE="-Os -mllvm -equal-branch-prob"

rm -rf build1 build2

(mkdir -p build1; cd build1; ../$SRC/configure CFLAGS="$FAST" && make -j 8)
(mkdir -p build2; cd build2; ../$SRC/configure CFLAGS="$BASE"  && make -j 8)
time -p ./build1/sqlite3 < bench.sql
time -p ./build2/sqlite3 < bench.sql


