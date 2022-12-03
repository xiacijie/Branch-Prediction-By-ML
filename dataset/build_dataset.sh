rm -rf ./dataset.csv

for d in ./* ; do
    echo "Building Dataset " $d 
    (cd $d; ./build.sh || true)
done