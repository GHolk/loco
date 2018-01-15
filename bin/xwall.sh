#!/bin/sh
# broadcast in x window, just like wall.

header='X Wall'
notify_wall() {
    notify-send "$header" "$*"
}

zenity_wall() {
    zenity --info --title "$header" --text "$*"
}


for display in $(w --no-header | awk '$3 ~ /^.*:[[:digit:]]+$/ {print $3}')
do
    export DISPLAY=$display
    zenity_wall "$*" &
done

