export CC=$LLVM/clang
export CXX=$LLVM/clang++

BASE="-Os -mllvm -equal-branch-prob"
MLPC="-Os -mllvm -branch-prob-predict-mlpc"
MLPR="-Os -mllvm -branch-prob-predict-mlpr"
SVMR="-Os -mllvm -branch-prob-predict-svmr"
ADAR="-Os -mllvm -branch-prob-predict-adar"
RANR="-Os -mllvm -branch-prob-predict-ranr"

rm -rf base mlpc mlpr svmr adar ranr 

RL=-DCMAKE_BUILD_TYPE=Release

(mkdir -p base; cd base; cmake -G Ninja ../sela -DCMAKE_CXX_FLAGS="$BASE" $RL && ninja)
(mkdir -p mlpc; cd mlpc; cmake -G Ninja ../sela -DCMAKE_CXX_FLAGS="$MLPC" $RL && ninja)
(mkdir -p mlpr; cd mlpr; cmake -G Ninja ../sela -DCMAKE_CXX_FLAGS="$MLPR" $RL && ninja)
(mkdir -p svmr; cd svmr; cmake -G Ninja ../sela -DCMAKE_CXX_FLAGS="$SVMR" $RL && ninja)
(mkdir -p adar; cd adar; cmake -G Ninja ../sela -DCMAKE_CXX_FLAGS="$ADAR" $RL && ninja)
(mkdir -p ranr; cd ranr; cmake -G Ninja ../sela -DCMAKE_CXX_FLAGS="$RANR" $RL && ninja)
