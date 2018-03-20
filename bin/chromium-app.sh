#!/bin/sh

open() {
    local url pid
    url="$1"
    chromium "--app=$url" &
    pid=$!
    echo $pid
}

top() {
    local pid window_name
    pid='$1'
    window_name=$(wmctrl -lp | awk '{if ($3 == "'$pid'") print $1}')
    wmctrl -ia $window_name -b add,above
}

# while getopts 't' arg
# do
#     case $arg in
#         t) top=1 ;;
#     esac
# done

# shift $(($OPTIND - 1))
# pid=`open $1`
# if [ "$top" = 1 ]
# then top $pid
# fi

open "$1"
