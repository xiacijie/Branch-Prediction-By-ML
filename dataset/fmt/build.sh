rm -rf build1 build2 

export PROF_RAW=/tmp/fmt.profraw
export PROF_DATA=/tmp/fmt.profdata
export CC=$LLVM/clang
export CXX=$LLVM/clang++
export PGO_SUFFIX="fmt"

CXXF="-fprofile-instr-generate"
CXXF2="-fprofile-instr-use=$PROF_DATA -mllvm -collect-dataset"

(mkdir -p build1; cd build1; cmake -G Ninja ../fmt -DCMAKE_CXX_FLAGS="$CXXF" && ninja)
(LLVM_PROFILE_FILE=$PROF_RAW ./build/bin/printf-test && $LLVM/llvm-profdata merge -output=$PROF_DATA $PROF_RAW)
(mkdir -p build2; cd build2; cmake -G Ninja ../fmt -DCMAKE_CXX_FLAGS="$CXXF2" && ninja)
