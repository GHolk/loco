#!/bin/sh

screen_shot_n() {
    local n=$1 i
    sleep 1
    for i in `seq $n`
    do
        xfce4-screenshooter --clipboard --window
        xclip -o -t image/jpeg -sel clipboard > $i.jpg
        xdotool click 5
        sleep 0.2
    done
}

split_rtl_n() {
    local n=$1 i
    for i in `seq $n`
    do
        convert -crop $right $i.jpg split/$((i*2-1)).jpg
        convert -crop $left $i.jpg split/$((i*2)).jpg
    done
}

center=553x782+523+115
right=553x782+800+115
left=553x782+247+115
all=1107x782+247+115
