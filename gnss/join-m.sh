#!/bin/sh
join_m() { 
    local field=$1
    shift

    local first_file
    if [ $# = 2 ]
    then
        join -j $field "$@"
    else
        first_file="$1"
        shift
        join_m $field "$@" | join -1 $field -2 1 "$first_file" -
    fi
}

join_m "$@"
