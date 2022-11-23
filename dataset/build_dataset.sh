rm -rf ./dataset.csv

for d in ./training/* ; do
    echo "Building Dataset " $d 
    (cd $d; ./build.sh)
done