#!/bin/sh
xmodmap -e "keycode 53 = space" \
        -e "keycode 54 = space" \
        -e "keycode 58 = space" \
        -e "keycode 59 = space"

echo "key 'x' 'c' 'm' ',' are mapped to space"
echo "press enter to recover"
read wait

xmodmap -e "keycode 53 = x" \
        -e "keycode 54 = c" \
        -e "keycode 58 = m" \
        -e "keycode 59 = comma less"
