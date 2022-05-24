#!/bin/sh

screen_shot_n() {
    local n=$1 i
    sleep 1
    for i in `seq $n`
    do
        import -window root -crop 626x951+137+124 $i.jpg
        xdotool mousemove 350 350 click 5 mousemove restore
        xdotool click 5
        sleep 0.5
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
