#!/usr/bin/awk -f

($5 ~ /\.Pos\.[XYZ]$/) {
    direction = tolower(substr($5, length($5), 1))
    cart[direction] = $3
}

(gipsy_second != $1) {
    if (gipsy_second) print_record()
    gipsy_second = $1
}

END {
    print_record()
}

function format_xyz() {
    return sprintf("%.5f %.5f %.5f", cart["x"], cart["y"], cart["z"])
}

function print_record() {
    unix_second = gipsy_second + 946728000
    print format_xyz(), unix_second
}
