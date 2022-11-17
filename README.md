# Branch-Prediction-By-ML

# How to build the project:
`bash build.sh`

# Test with a sample 
`./llvm-project/build/bin/clang++ -Os ./samples/if.cpp -emit-llvm -S -o if.ll`

Then check the ll file to see the branch weights. 