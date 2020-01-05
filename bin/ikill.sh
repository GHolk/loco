#!/bin/sh
ps_header=--headers
for pid in `pgrep --full --ignore-case "$@"`
do
    if ps -l $ps_header $pid
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

# testing implement, use information from pgrep
true || (
nth() {
    local n=$1
    shift
    eval echo -n \$$n
}

once_a_line() {
    exec 3<&0 # copy 0 to 3
    pgrep --list-full --full --ignore-case "$@" |
    while read process_info
    do
        echo "$process_info"
        echo "kill? (Y/n/term/kill/stop/...signal)"
        read input <&3
        case "$input" in
            n*|N*) signal=0 ;;
            y*|Y*) signal=term ;;
            "") signal=term ;;
            *) signal="$input" ;;
        esac
        kill -s $signal $(nth 1 $process_info)
    done
}

once_a_line "$@"
)
