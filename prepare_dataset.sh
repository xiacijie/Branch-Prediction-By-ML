rm -rf ./dataset 

# Profile generation run:
CCC="-DCMAKE_C_COMPILER=$PWD/llvm-project/build/bin/clang"
TRAIN="-DTEST_SUITE_PROFILE_GENERATE=ON -DTEST_SUITE_RUN_TYPE=train "
USE="-DTEST_SUITE_PROFILE_GENERATE=OFF -DTEST_SUITE_PROFILE_USE=ON "
TS="$PWD/llvm-test-suite"

(mkdir -p ./dataset &&
 cd ./dataset &&
 cmake $CCC $TS -G Ninja $TRAIN &&
 ninja -k 100)

 (cd ./dataset &&
 cmake $CCC $TS -G Ninja $USE &&
 ninja -k 100)
