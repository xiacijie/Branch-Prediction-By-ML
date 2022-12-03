for d in ./* ; do
    echo "Testing " $d 
    (cd $d; ./test.sh || true)
    echo "$d"
done