#!/bin/sh
ps_header=--headers

signal_default=term
if [ "$1" = -s ]
then
    signal_default=$2
    shift 2
fi

for pid in `pgrep --full --ignore-case "$@"`
do
    if [ $pid -ne $$ ] && ps -ww -f $ps_header $pid
    then
        echo "kill? (Y/n/term/kill/stop/...signal)"
        read input
        case "$input" in
            n*|N*) signal=0 ;;
            y*|Y*) signal=$signal_default ;;
            "") signal=term ;;
            *) signal="$input" ;;
        esac

        kill -s $signal $pid
    fi

    ps_header=--no-headers
done
