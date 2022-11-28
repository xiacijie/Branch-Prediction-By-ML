for d in ./training/* ; do
    echo "Downloading " $d 
    (cd $d; ./download.sh || true)
    echo "$d"
done