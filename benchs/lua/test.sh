rm -rf result.json

hyperfine --warmup 5 --runs 1 './base/src/lua sort.lua' './mlpc/src/lua sort.lua' './mlpr/src/lua sort.lua' './svmr/src/lua sort.lua' './adar/src/lua sort.lua' './ranr/src/lua sort.lua' --export-json result.json

