export CC=$LLVM/clang
export CXX=$LLVM/clang++

BASE="-Os -mllvm -equal-branch-prob"
MLPC="-Os -mllvm -branch-prob-predict-mlpc"
MLPR="-Os -mllvm -branch-prob-predict-mlpr"
SVMR="-Os -mllvm -branch-prob-predict-svmr"
ADAR="-Os -mllvm -branch-prob-predict-adar"
RANR="-Os -mllvm -branch-prob-predict-ranr"

rm -rf base mlpc mlpr svmr adar ranr 

(cp -r TSCP/ base; cd base/; $CC *.c $BASE -o tscp)
(cp -r TSCP/ mlpc; cd mlpc/; $CC *.c $MLPC -o tscp)
(cp -r TSCP/ mlpr; cd mlpr/; $CC *.c $MLPR -o tscp)
(cp -r TSCP/ svmr; cd svmr/; $CC *.c $SVMR -o tscp)
(cp -r TSCP/ adar; cd adar/; $CC *.c $ADAR -o tscp)
(cp -r TSCP/ ranr; cd ranr/; $CC *.c $RANR -o tscp)