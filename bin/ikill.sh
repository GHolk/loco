#!/bin/sh
ps_header=--headers
for pid in `pgrep "$@"`
do
    ps -l $ps_header $pid || continue
    echo "kill? (Y/n/term/kill/stop/...signal)"
    read input
    case "$input" in
        n*|N*) signal=0 ;;
        y*|Y*) signal=term ;;
        "") signal=term ;;
        *) signal="$input" ;;
    esac

    kill -s $signal $pid

    ps_header=--no-headers
done

