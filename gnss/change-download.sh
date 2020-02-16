. $HOME/.bash_function

set_if_empty port 5566
set_if_empty date_start `date --iso-8601=date --utc`
set_if_empty file `mktemp nctu2-alloy-$date_start-XXXXXXXXXXX.nmea`

set_if_empty mail $USER

nc_save="ncat --recv-only -lp $port >> $file < /dev/null"

file_size() {
    local file="$1"
    wc -c "$file" | cut -d' ' -f 1
}

size_old=$(file_size $file)

log_error() {
    local error="error: `date -Is` small download size $(file_size $file)"
    echo $error >>$file
    echo $error >&2
}

kill_wait() {
    kill -s TERM %%
    sleep 2s
    if jobs %%
    then kill -s KILL %%
    fi
    sleep 1s
}

eval $nc_save \&

state_current=download

set_if_empty interval 10s
while sleep $interval
do
    size_current=$(file_size $file)
    if ! [ $size_current -gt $size_old ]
    then
        kill_wait
        log_error=`log_error 2>&1`
        echo "$log_error" >&2
        if [ $state_current = download ]
        then
            echo "$log_error" | mail -s "$file status" $mail
            state_current=disconnect
        fi
        size_current=$(file_size $file)
        eval $nc_save \&
    elif [ $state_current = disconnect ]
    then # success download after disconnect
        echo "download: `date -Is` restart download file size: $size_current" \
         | mail -s "$file status" $mail
        state_current=download
    fi
    size_old=$size_current
done
