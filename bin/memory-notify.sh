#!/bin/sh

while sleep 10
do
    swapon --show --bytes
    echo swapon end
done | awk '
BEGIN {
    debug = ENVIRON["DEBUG"]
}
(debug) { print }

($2 == "partition") {
    if ($1 ~ /zram/) type = "zram"
    else type = "swap"

    total[type] += $3
    use[type] += $4
}
/swapon end/ {
    if (use["swap"] > 0) {
        print_zenity_message("error", "swap", use["swap"], total["swap"])
    }
    else if (use["zram"] / total["zram"] > 0.36) {
        print_zenity_message("warning", "zram", use["zram"], total["zram"])
    }
    if (debug) {
        print "total", total["zram"], total["swap"]
        print "use", use["zram"], use["swap"]
    }
    total["zram"] = total["swap"] = 0
    use["zram"] = use["swap"] = 0
}

function print_zenity_message(icon, type, use, total) {
    title = "memory notify"
    message = sprintf("%s used %d MB (%f%%)", type, use / 1000000, use / total)
    command = sprintf("notify-send --expire-time 7000 --icon %s \"%s\" \"%s\"",
        icon, title, message)
    if (debug) print command
    system(command)
}
'
