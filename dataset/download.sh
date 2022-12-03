for d in ./* ; do
    echo "Downloading " $d 
    (cd $d; ./download.sh || true)
    echo "$d"
done