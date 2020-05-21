#!/bin/sh
t02="$1"
tgd="$t02.tgd"
rinex="$2"

runpkr00 -g -d -v "$t02" "$tgd"
teqc +extend "$tgd" > "$rinex"
