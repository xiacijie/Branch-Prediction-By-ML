rm -rf result.json

hyperfine --warmup 5 --runs 1 './base/tscp <note.txt > /dev/null' './mlpc/tscp <note.txt > /dev/null' './mlpr/tscp <note.txt > /dev/null' './mlpr/tscp <note.txt > /dev/null' './mlpr/tscp <note.txt > /dev/null' './mlpr/tscp <note.txt > /dev/null' --export-json result.json
