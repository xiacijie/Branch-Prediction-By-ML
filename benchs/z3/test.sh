rm -rf result.json

hyperfine --warmup 5 --runs 1 './base/z3 ./input.txt ' './mlpc/z3 ./input.txt ' './mlpr/z3 ./input.txt' './svmr/z3 ./input.txt' ' ./adar/z3 ./input.txt' './ranr/z3 ./input.txt' --export-json result.json

