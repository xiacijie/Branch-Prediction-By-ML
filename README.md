# Branch-Prediction-By-ML

# How to build the project:
`source init.sh`
`bash build.sh`

# Test with a sample 
`./llvm-project/build/bin/clang++ -Os ./samples/if.cpp -emit-llvm -S -o if.ll`

Then check the ll file to see the branch weights. 

# How to use PyTorch in C++
https://pytorch.org/tutorials/advanced/cpp_export.html