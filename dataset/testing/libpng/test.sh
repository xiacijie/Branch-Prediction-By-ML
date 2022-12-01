rm -rf result.json

hyperfine --warmup 5 --runs 1 './base/pngvalid' './mlpc/pngvalid' './mlpr/pngvalid' './svmr/pngvalid' './adar/pngvalid' './ranr/pngvalid' --export-json result.json


