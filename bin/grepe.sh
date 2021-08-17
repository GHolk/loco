#!/bin/sh
first=''
while [ x"$1" != x-e ]
do
    first="$1"
    shift
    set -- "$@" -e "$first"
done
grep "$@"
