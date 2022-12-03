for d in ./* ; do
    echo "Building Benchmark " $d 
    (cd $d; ./build.sh || true)
done