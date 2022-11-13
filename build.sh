# Build LLVM 
if [ ! -d "llvm-project" ] ; then
    git clone --branch release/13.x --depth 1 https://github.com/llvm/llvm-project
fi


cd llvm-project
mkdir build
cd build
cmake -G Ninja \
    -DCMAKE_BUILD_TYPE=Release  \
    -DLLVM_ENABLE_PROJECTS="clang;compiler-rt;"  \
    -DLLVM_TARGETS_TO_BUILD=X86 \
    -DLLVM_INSTALL_TOOLCHAIN_ONLY=ON \
    ../llvm 

ninja 