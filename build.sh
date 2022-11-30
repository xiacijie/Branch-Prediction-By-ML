# Build LLVM 
echo "1. Cloning LLVM..."
if [ ! -d "llvm-project" ] ; then
    git clone --depth 1 https://github.com/xiacijie/llvm-project
fi

if [ ! -d "pybind11" ] ; then
    git clone git@github.com:pybind/pybind11.git
fi

echo "1. Finish cloning LLVM!"

echo "2. Building LLVM..."
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
echo "2. Finish building LLVM!"
