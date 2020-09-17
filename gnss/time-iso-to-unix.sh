#!/bin/sh
if [ -n "$1" ]
then
    field=$1
    shift
else
    field=4
fi

awk -v field=$field '{
    string = $(field)
    gsub(/[-\/:T]/, " ", string)
    string = substr(string, 1, 19)
    time = mktime(string)
    $(field) = time
    print $0
}' "$@"
