#!/bin/sh

wifi=wdt13d

nmcli connection down $wifi
nmcli connection up $wifi

