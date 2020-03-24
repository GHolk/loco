#!/usr/bin/awk -f

($5 ~ /\.Pos\.[XYZ]$/) {
    direction = tolower(substr($5, length($5), 1))
    cart[direction] = $3
}

{
    if (gps_second != $1) {
        if (gps_second) print_record()
        gps_second = $1
    }
}

END {
    print_record()
}

function format_xyz() {
    return sprintf("%.5f %.5f %.5f", cart["x"], cart["y"], cart["z"])
}

function print_record() {
    print format_xyz(), gps_second
}
