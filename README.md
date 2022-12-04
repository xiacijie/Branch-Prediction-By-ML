# Branch-Prediction-By-ML

# 0. Clone the project:

`git clone git@github.com:xiacijie/Branch-Prediction-By-ML.git`

`cd Branch-Prediction-By-ML`

# 1. Build the project:
`source init.sh` - Config the environment variables

`bash build.sh` - Build the LLVM project 

Note: LLVM project takes more than 35 mins on an average 8 cores (16 threads) machine to build. Make sure you allocate enough memory ( at least 12GB RAM and 20GB swap space) otherwise it can fail. 

If your memory is limited, try replacing `ninja` command in `build.sh` with `ninja -j(NUM)` where `NUM` is a number smaller than your machine's total number of threads. 

# 2. Sanity Check
`bash sanity_check.sh`

Then check the generate `if.ll` file to see the branch weights. You should see something in the `if.ll` file similar to below: 

```
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 16.0.0 (git@github.com:xiacijie/llvm-project.git 6734d9faf591d6780e69cbfb237291c6069cb4fb)"}
!5 = !{!"branch_weights", i32 50, i32 50}
```

# 3. Generate dataset 
`bash generate_dataset.sh` 

Then check the `dataset.csv` file under the `/dataset` folder. It should contain around 130,000 entries of data. 

# 4. Train the models
`bash train_models.sh`

# 5. Run benchmarks 
`bash run_benchmarks.sh`

After the benchmarks finish running, go into the directory of each benchmark, you can see there is a file called `result.json` that contains the execution detail of the benchmark. 
