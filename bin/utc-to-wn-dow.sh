#!/bin/sh
set -e
date="$1"
wn_tow=$(utc-to-wn-tow "$date")
wn=$(echo $wn_tow | cut -d' ' -f 1)
tow=$(echo $wn_tow | cut -d' ' -f 2)
second_of_day=86400
dow=$(expr $tow / $second_of_day)
printf "%04d%1d\n" $wn $dow
