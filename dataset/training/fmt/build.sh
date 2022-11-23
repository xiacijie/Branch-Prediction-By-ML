export PROF_RAW=/tmp/fmt.profraw
export PROF_DATA=/tmp/fmt.profdata
export CC=$LLVM/clang
export CXX=$LLVM/clang++
export PGO_SUFFIX="fmt"

CXXF="-fprofile-instr-generate"
CXXF2="-fprofile-instr-use=$PROF_DATA -mllvm -collect-dataset"

(mkdir -p build; cd build; cmake -G Ninja ../fmt -DCMAKE_CXX_FLAGS="$CXXF" && ninja)
(LLVM_PROFILE_FILE=$PROF_RAW ./build/bin/printf-test && $LLVM/llvm-profdata merge -output=$PROF_DATA $PROF_RAW)
(mkdir -p build; cd build; cmake -G Ninja ../fmt -DCMAKE_CXX_FLAGS="$CXXF2" && ninja)
