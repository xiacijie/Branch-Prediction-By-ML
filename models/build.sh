mkdir build
cd build
cmake -DCMAKE_PREFIX_PATH=$LIBTORCH_PATH ..
cmake --build . --config Release