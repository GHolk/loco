#!/bin/sh
export PATH=$PATH:/sbin

for event in EXIT INT HUP TERM 
do trap "on_exit $event" $event
done

on_exit() {
    trap - EXIT INT HUP TERM
    echo exit on $1
    kill `pgrep --parent $$`
    exit
}

swapon_fake() {
local zram=$(cat zram)
local swap=$(cat swap)
cat <<SWAP
NAME       TYPE            SIZE            USED PRIO
/dev/dm-4  partition 4030722048           $swap   -2
/dev/zram0 partition  401784832           $zram  100
/dev/zram1 partition  401784832           $zram  100
/dev/zram2 partition  401784832           $zram  100
/dev/zram3 partition  401784832           $zram  100
SWAP
}

if [ -n "$DEBUG" ]
then
    debug_directory=/tmp/swapon-fake.$$
    mkdir $debug_directory
    cd $debug_directory
    exec 1>log
    exec 2>&1
    echo 0 > swap
    echo 0 > zram
    swapon() {
        swapon_fake
    }
fi

while sleep 10
do
    swapon --show --bytes
    echo swapon end
done | awk '
BEGIN {
    debug = ENVIRON["DEBUG"]
    icon["zram"] = "dialog-warning"
    icon["swap"] = "dialog-error"
    gate["zram"] = 0.7
    gate["swap"] = 0
    history["swap"] = 0
}
(debug) { print }

($2 == "partition") {
    if ($1 ~ /zram/) type = "zram"
    else type = "swap"

    total[type] += $3
    use[type] += $4
}
/swapon end/ {
    if (use["swap"] > gate["swap"]) {
        if (use["swap"] > history["swap"]) {
            print_zenity_message(icon["swap"], "swap", use["swap"], total["swap"])
        }
        history["swap"] = use["swap"]
    }
    else if (use["zram"] / total["zram"] > gate["zram"]) {
        print_zenity_message(icon["zram"], "zram", use["zram"], total["zram"])
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
    message = sprintf("%s used %d MB (%.1f%%)", type,
                      use / 1000000, use / total * 100)
    command = sprintf("notify-send --expire-time 7000 --icon %s \"%s\" \"%s\"",
        icon, title, message)
    if (debug) print command
    system(command)
}
' &
wait
