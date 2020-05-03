#!/bin/sh
if ! lsmod | grep -q '^nbd'
then modprobe nbd max_part=16
fi

image=$1

if [ -n "$2" ]
then device=$2
else device=/dev/nbd0
fi

qemu-nbd -c $device $image

cat <<UNMOUNT
# to unmount device
qemu-nbd -d $device
modprobe -r nbd
UNMOUNT
