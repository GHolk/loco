#!/bin/sh
field=$1
[ -z "$field" ] && field=4
shift
awk -v field=$field '{
    string = $(field)
    gsub(/[-\/:T]/, " ", string)
    string = substr(string, 1, 18)
    time = mktime(string)
    $(field) = time
    print $0
}' "$@"
