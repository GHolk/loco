#!/bin/sh

cat <<FSB
sometimes bluetooth stop working after suspend,
this script fix this problem.
bug and script url:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1790454
FSB

echo this script require root permision by sudo
sudo systemctl stop bluetooth

mod_list="btusb btintel btbcm bnep rfcomm bluetooth"
for mod in $mod_list
do
    sudo modprobe -r $mod
done

echo press enter to suspend or press ^C to cancel
read suspend
sudo systemctl suspend

for mod in $mod_list
do
    sudo modprobe $mod
done
sudo systemctl start bluetooth

