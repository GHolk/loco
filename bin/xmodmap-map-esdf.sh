#!/bin/sh
xmodmap -e "keycode 26 = Up" \
        -e "keycode 39 = Left" \
        -e "keycode 40 = Down" \
        -e "keycode 41 = Right"

echo "key 'e' 's' 'd' 'f' are mapped to Up and Down"
echo "press enter to recover"
read wait

xmodmap -e "keycode 26 = e" \
        -e "keycode 39 = s" \
        -e "keycode 40 = d" \
        -e "keycode 41 = f"

