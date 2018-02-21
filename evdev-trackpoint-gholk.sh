#!/bin/sh

(
    trackpoint() {
        xinput --set-prop "ETPS/2 Elantech TrackPoint" "$1" "$2"
    }

    # 加速小紅點
    trackpoint "Device Accel Constant Deceleration" 0.300000
    trackpoint "Device Accel Adaptive Deceleration" 2.000000
    trackpoint "Device Accel Velocity Scaling" 10.000000

    # 滑鼠鍵編號從 0 開始，
    # 左鍵 0、右鍵 1、中鍵 2，
    # 依序排列。

    # 中鍵視為一般壓滾輪的中鍵
    trackpoint "Evdev Middle Button Emulation" 1
    trackpoint "Evdev Middle Button Button" 2

    # 壓著中鍵時移動小紅點視為滾動
    trackpoint "Evdev Wheel Emulation" 1
    trackpoint "Evdev Wheel Emulation Button" 2
)
