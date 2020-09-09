#!/bin/sh

if [ $1 = -s ] || [ $1 = --signal ]
then 
    signal=$2
    signal_option="$1 $2"
    shift 2
fi

pid=$1
pgid=`ps --no-headers --format pgid:1 $pid`
kill $signal_option -- -$pgid
