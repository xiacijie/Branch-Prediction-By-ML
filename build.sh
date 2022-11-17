# Build LLVM 
echo "1. Cloning LLVM..."
if [ ! -d "llvm-project" ] ; then
    git clone --branch release/13.x --depth 1 https://github.com/llvm/llvm-project
fi
echo "1. Finish cloning LLVM!"

echo "2. Config LLVM..."
cd llvm-project
mkdir build
cd build
cmake -G Ninja \
    -DCMAKE_BUILD_TYPE=Release  \
    -DLLVM_ENABLE_PROJECTS="clang;compiler-rt;"  \
    -DLLVM_TARGETS_TO_BUILD=X86 \
    -DLLVM_INSTALL_TOOLCHAIN_ONLY=ON \
    ../llvm 

# ninja 
echo "2. Finish Config LLVM!"

cd ..

echo "3. Applying our branch prediction files and building LLVM..."
# Copy our implemented LLVM pass files to LLVM project

if ! patch -R -p1 -s -f --dry-run < ../branch-predict-pass/llvm.patch ; then
  patch -p1 < ../branch-predict-pass/llvm.patch 
fi

# patch -p1 -R < ../branch-predict-pass/llvm.patch 
# patch -p1 < ../branch-predict-pass/llvm.patch 
cp ../branch-predict-pass/*.cpp llvm/lib/Transforms/Instrumentation/
cp ../branch-predict-pass/*.h llvm/include/llvm/Transforms/Instrumentation/

# build LLVM
cd build 
ninja 

echo "3. All done!"
