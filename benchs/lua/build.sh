export CC=$LLVM/clang
export CXX=$LLVM/clang++

BASE="-Os -mllvm -equal-branch-prob"
MLPC="-Os -mllvm -branch-prob-predict-mlpc"
MLPR="-Os -mllvm -branch-prob-predict-mlpr"
SVMR="-Os -mllvm -branch-prob-predict-svmr"
ADAR="-Os -mllvm -branch-prob-predict-adar"
RANR="-Os -mllvm -branch-prob-predict-ranr"

rm -rf base mlpc mlpr svmr adar ranr 

(cp -r lua-5.4.3 base; cd base; make clean; make -j 8 MYCFLAGS="$BASE" CC=$CC)
(cp -r lua-5.4.3 mlpc; cd mlpc; make clean; make -j 8 MYCFLAGS="$MLPC" CC=$CC)
(cp -r lua-5.4.3 mlpr; cd mlpr; make clean; make -j 8 MYCFLAGS="$MLPR" CC=$CC)
(cp -r lua-5.4.3 svmr; cd svmr; make clean; make -j 8 MYCFLAGS="$SVMR" CC=$CC)
(cp -r lua-5.4.3 adar; cd adar; make clean; make -j 8 MYCFLAGS="$ADAR" CC=$CC)
(cp -r lua-5.4.3 ranr; cd ranr; make clean; make -j 8 MYCFLAGS="$RANR" CC=$CC)