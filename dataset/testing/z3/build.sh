export CC=$LLVM/clang
export CXX=$LLVM/clang++


BASE="-Os -mllvm -equal-branch-prob"
MLPC="-Os -mllvm -branch-prob-predict-mlpc"
MLPR="-Os -mllvm -branch-prob-predict-mlpr"
SVMR="-Os -mllvm -branch-prob-predict-svmr"
ADAR="-Os -mllvm -branch-prob-predict-adar"
ranr="-Os -mllvm -branch-prob-predict-ranr"

rm -rf base mlpc mlpr svmr adar ranr 

(mkdir -p base; cd base; cmake -G Ninja ../z3 -DCMAKE_CXX_FLAGS="$BASE" && ninja)
(mkdir -p mlpc; cd mlpc; cmake -G Ninja ../z3 -DCMAKE_CXX_FLAGS="$MLPC" && ninja)
(mkdir -p mlpr; cd mlpr; cmake -G Ninja ../z3 -DCMAKE_CXX_FLAGS="$MLPR" && ninja)
(mkdir -p svmr; cd svmr; cmake -G Ninja ../z3 -DCMAKE_CXX_FLAGS="$SVMR" && ninja)
(mkdir -p adar; cd adar; cmake -G Ninja ../z3 -DCMAKE_CXX_FLAGS="$ADAR" && ninja)
(mkdir -p ranr; cd ranr; cmake -G Ninja ../z3 -DCMAKE_CXX_FLAGS="$RANR" && ninja)