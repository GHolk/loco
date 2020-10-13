#!/bin/sh
[ $# -eq 0 ] && set -- ping
while sleep 1
do
    echo "$@" `date -Is`
done
