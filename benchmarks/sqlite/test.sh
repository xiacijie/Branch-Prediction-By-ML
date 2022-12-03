rm -rf result.json

hyperfine --warmup 5 --runs 1 './base/sqlite3 < bench.sql' './mlpc/sqlite3 < bench.sql' './mlpr/sqlite3 < bench.sql' './svmr/sqlite3 < bench.sql' './adar/sqlite3 < bench.sql' './ranr/sqlite3 < bench.sql' --export-json result.json