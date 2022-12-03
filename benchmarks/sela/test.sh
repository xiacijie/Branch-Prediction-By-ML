rm -rf result.json

hyperfine --warmup 5 --runs 1 './base/sela -e ../oggvorbis/tune.wav 1.sela' './mlpc/sela -e ../oggvorbis/tune.wav 2.sela' './mlpr/sela -e ../oggvorbis/tune.wav 3.sela' './svmr/sela -e ../oggvorbis/tune.wav 4.sela' './adar/sela -e ../oggvorbis/tune.wav 5.sela' './ranr/sela -e ../oggvorbis/tune.wav 6.sela' --export-json result.json
