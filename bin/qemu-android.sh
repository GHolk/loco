#!/bin/sh

image="$1"

qemu-system-x86_64 -enable-kvm \
                   -m 1G \
                   -soundhw all \
                   -hda "$image"
