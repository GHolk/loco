#!/bin/awk -f
BEGIN {
    FS = ","
    time_previous = -1
    print "start check stdin"
}
$1 == "$GNGGA" {
    time_current = clock_to_second($2)
    if (time_previous == -1) printf("first record at %f\n", time_current)
    else if (time_current-1 != time_previous) {
        printf("record leap from %f to %f at line %d\n",
               time_previous, time_current, NR)
    }
    time_previous = time_current
}
function clock_to_second(clock) {
    second = clock % 100 % 60
    minute = int(clock / 100) % 100
    hour = int(clock / 10000)
    return second + (minute + hour*60)*60
}
