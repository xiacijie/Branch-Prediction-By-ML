export CC=$LLVM/clang
export CXX=$LLVM/clang++
export SRC=libpng-1.6.37/

BASE="-Os -mllvm -equal-branch-prob"
MLPC="-Os -mllvm -branch-prob-predict-mlpc"
MLPR="-Os -mllvm -branch-prob-predict-mlpr"
SVMR="-Os -mllvm -branch-prob-predict-svmr"
ADAR="-Os -mllvm -branch-prob-predict-adar"
RANR="-Os -mllvm -branch-prob-predict-ranr"
RL=-DCMAKE_BUILD_TYPE=Release

rm -rf base mlpc mlpr svmr adar ranr 

(mkdir -p base; cd base; ../$SRC/configure CFLAGS="$BASE" $RL && make -j 8)
(mkdir -p mlpc; cd mlpc; ../$SRC/configure CFLAGS="$MLPC" $RL && make -j 8)
(mkdir -p mlpr; cd mlpr; ../$SRC/configure CFLAGS="$MLPR" $RL && make -j 8)
(mkdir -p svmr; cd svmr; ../$SRC/configure CFLAGS="$SVMR" $RL && make -j 8)
(mkdir -p adar; cd adar; ../$SRC/configure CFLAGS="$ADAR" $RL && make -j 8)
(mkdir -p ranr; cd ranr; ../$SRC/configure CFLAGS="$RANR" $RL && make -j 8)