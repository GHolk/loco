#!/bin/sh

device="$1"
switch=$(
    xinput --list-props "$device" | awk '/Device Enabled/ {print !$(NF); exit}'
)
xinput --set-prop "$device" "Device Enabled" $switch
