#!/bin/sh

if expr $0 : '^.*unmute'
then pactl set-sink-mute 0 0
else pactl set-sink-mute 0 1
fi

