#!/bin/bash
# script to screen shot
# http://wiki.lxde.org/en/How_to_take_screenshots
# gholk
DATE=`date +%Y-%m-%dT%H:%M:%S+08`
import -window root "$HOME/Pictures/screen_${DATE}.png"
