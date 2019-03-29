#!/bin/sh
# run dual boot windows 10 partition by qemu and ovmf,
# record option in script.

qemu-system-x86_64 -enable-kvm -snapshot \
                   -m 1G \
                   -hda /dev/sda \
                   -pflash /usr/share/ovmf/OVMF.fd \
                   -net none \
                   "$@"
