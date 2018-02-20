#!/bin/sh

(
    trackpoint() {
        xinput --set-prop "ETPS/2 Elantech TrackPoint" "$1" "$2"
    }

    trackpoint "Device Accel Profile" "0"
    trackpoint "Device Accel Constant Deceleration" "0.300000"
    trackpoint "Device Accel Adaptive Deceleration" "2.000000"
    trackpoint "Device Accel Velocity Scaling" "10.000000"
    trackpoint "Evdev Middle Button Emulation" "1"
    trackpoint "Evdev Middle Button Button" "2"
    trackpoint "Evdev Third Button Emulation" "0"
    trackpoint "Evdev Wheel Emulation" "1"
    trackpoint "Evdev Wheel Emulation Button" "2"

)
