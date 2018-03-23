#!/bin/sh

wifi=wdt13d

sudo=""
if [ "$1" = "-s" ]
then
    sudo=sudo
fi

$sudo nmcli connection down $wifi
$sudo nmcli connection up $wifi

