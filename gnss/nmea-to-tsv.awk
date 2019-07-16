#!/usr/bin/awk -f
BEGIN {
    FS = ","
}

($1 ~ /^\$G.GGA$/) {
    second_of_day = compute_second($2)
    latitude = decimal_degree($3)
    if ($4 == "S") latitude *= -1
    longitude = decimal_degree($5)
    if ($6 == "W") longitude *= -1

    ellipsoid_height = $10 + $12

    printf("%d %.10f %.10f %.5f\n",
           second_of_day, longitude, latitude, ellipsoid_height)
    # print second_of_day, longitude, latitude, ellipsoid_height
}

function compute_second(time_string) {
    hour = substr(time_string, 1, 2)
    minute = substr(time_string, 3, 2)
    second = substr(time_string, 5, 2)
    return (hour * 60 + minute) * 60 + second
}

function decimal_degree(nmea_format) {
    dot_index = index(nmea_format, ".")
    degree = substr(nmea_format, 1, dot_index - 3)
    minute = substr(nmea_format, dot_index - 2)
    return degree + minute/60
}

