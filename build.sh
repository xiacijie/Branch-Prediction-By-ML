# Build LLVM 
echo "1. Cloning LLVM..."
if [ ! -d "llvm-project" ] ; then
    git clone --branch release/13.x --depth 1 https://github.com/llvm/llvm-project
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

cd ..

echo "3. Applying our branch prediction files and rebuild..."
# Copy our implemented LLVM pass files to LLVM project
patch -p1 < ../branch-predict-pass/llvm.patch 
cp ../branch-predict-pass/*.cpp llvm/lib/Transforms/Instrumentation/
cp ../branch-predict-pass/*.h llvm/include/llvm/Transforms/Instrumentation/

# rebuild LLVM
cd build 
ninja 

echo "3. All done!"
