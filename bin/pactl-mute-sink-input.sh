#!/bin/sh

pactl list sink-inputs |
    sed -n '
/^Sink Input/ {
    s/.*#//
    H
}
/^..application.name/ {
    s/..application.name = "/\t/
    s/"$//
    H
}
$ {
    g
    s/\n\t/\t/g
    p
}' |
    dmenu -l 5 -p 'toggle mute' | {
    read sink name
    if [ -n "$sink" ]
    then pactl set-sink-input-mute $sink toggle
    fi
}
