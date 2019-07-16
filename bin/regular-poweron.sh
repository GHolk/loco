#!/bin/sh
this_file=/usr/local/lib/regular-poweron.sh
time_poweron=10:00

shutdown +70
rtcwake --mode no --time `date --date="tomorrow $time_poweron" +%s`
at -f $this_file tomorrow
