export CC=$LLVM/clang
export CXX=$LLVM/clang++

BASE="-Os -mllvm -equal-branch-prob"
MLPC="-Os -mllvm -branch-prob-predict-mlpc"
MLPR="-Os -mllvm -branch-prob-predict-mlpr"
SVMR="-Os -mllvm -branch-prob-predict-svmr"
ADAR="-Os -mllvm -branch-prob-predict-adar"
RANR="-Os -mllvm -branch-prob-predict-ranr"

rm -rf oggencbase oggencmlpc oggencmlpr oggencsvmr oggencadar oggencranr 

$LLVM/clang oggenc.c -g -lm $BASE -o oggencbase
$LLVM/clang oggenc.c -g -lm $MLPC -o oggencmlpc
$LLVM/clang oggenc.c -g -lm $MLPR -o oggencmlpr
$LLVM/clang oggenc.c -g -lm $SVMR -o oggencsvmr
$LLVM/clang oggenc.c -g -lm $ADAR -o oggencadar
$LLVM/clang oggenc.c -g -lm $RANR -o oggencranr

cat /dev/urandom | head -c 30000000 > payload.bin