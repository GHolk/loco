#!/bin/sh
# gold holk (gholk) 2020
# license under GPLv3

# render giant format spatial temporal baseline data to svg

awk '
{
    date1 = $2
    date2 = $3
    distance = $4
    if (!(date1 in image) && !(date2 in image)) {
        image[date2] = 0
    }
    if (date2 in image) {
        image[date1] = image[date2] + distance
    }
    else if (date1 in image) {
        image[date2] = image[date1] - distance
    }
    else print "error" 

    print_baseline(date2, date1)
}

function date_to_unix(date) {
    match(date, /^(....)(..)(..)$/, ymd)
    unix = mktime(sprintf("%s %s %s 00 00 00", ymd[1], ymd[2], ymd[3]))
    return unix
}

function print_baseline(date1, date2) {
    unix1 = date_to_unix(date1)
    unix2 = date_to_unix(date2)
    print unix1, unix2, image[date1], image[date2]
}
' | gnuplot -e '
set xdata time;
set timefmt "%s";
set xtics format "%Y-%m-%d";
set term "svg";
plot "-" using 1:3:($2-$1):($4-$3) title "pair" with vector nohead;
'
