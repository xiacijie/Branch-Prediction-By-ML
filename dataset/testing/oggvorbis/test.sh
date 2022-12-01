rm -rf result.json

hyperfine --warmup 5 --runs 1 './oggencbase -raw -Q payload.bin' './oggencmlpc -raw -Q payload.bin' './oggencmlpr -raw -Q payload.bin' './oggencsvmr -raw -Q payload.bin' './oggencadar -raw -Q payload.bin' './oggencranr -raw -Q payload.bin' --export-json result.json

