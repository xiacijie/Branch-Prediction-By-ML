export CC=$LLVM/clang
export CXX=$LLVM/clang++
export SRC=libpng-1.6.37/

FAST="-Os -mllvm -branch-prob-predict-mlpr"
BASE="-Os -mllvm -equal-branch-prob"

rm -rf build1 build2 

(mkdir -p build1; cd build1; ../$SRC/configure CFLAGS="$FAST" && make -j 8)
(mkdir -p build2; cd build2; ../$SRC/configure CFLAGS="$BASE"  && make -j 8)


(time -p ./build1/pngvalid)
(time -p ./build2/pngvalid)