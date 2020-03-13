#!/bin/sh
ps_header=--headers
for pid in `pgrep --full --ignore-case "$@"`
do
    if [ $pid -ne $$ ] && ps -ww -l $ps_header $pid
    then
        echo "kill? (Y/n/term/kill/stop/...signal)"
        read input
        case "$input" in
            n*|N*) signal=0 ;;
            y*|Y*) signal=term ;;
            "") signal=term ;;
            *) signal="$input" ;;
        esac

        kill -s $signal $pid
    fi

    ps_header=--no-headers
done
