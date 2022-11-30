rm -rf result.txt

avg_time() {
    #
    # usage: avg_time n command ...
    #
    n=$1; shift
    (($# > 0)) || return                   # bail if no command given
    for ((i = 0; i < n; i++)); do
        { time -p "$@" &>/dev/null; } 2>&1 # ignore the output of the command
                                           # but collect time's output in stdout
    done | awk '
        /real/ { real = real + $2; nr++ }
        /user/ { user = user + $2; nu++ }
        /sys/  { sys  = sys  + $2; ns++}
        END    {
                 if (nr>0) printf("real %f\n", real/nr);
                 if (nu>0) printf("user %f\n", user/nu);
                 if (ns>0) printf("sys %f\n",  sys/ns)
               }'
}

echo -e "\n base\n" >> result.txt 
(avg_time 10 ./base/sela -e ../oggvorbis/tune.wav 1.sela >> result.txt)
echo -e "\n mlpc\n">> result.txt 
(avg_time 10 ./mlpc/sela -e ../oggvorbis/tune.wav 2.sela >> result.txt)
echo -e "\n mlpr\n">> result.txt 
(avg_time 10 ./mlpr/sela -e ../oggvorbis/tune.wav 3.sela >> result.txt)
echo -e "\n svmr\n">> result.txt 
(avg_time 10 ./svmr/sela -e ../oggvorbis/tune.wav 4.sela >> result.txt)
echo -e "\n adar\n">> result.txt 
(avg_time 10 ./adar/sela -e ../oggvorbis/tune.wav 5.sela >> result.txt)
echo -e "\n ranr\n">> result.txt
(avg_time 10 ./ranr/sela -e ../oggvorbis/tune.wav 6.sela >> result.txt)

