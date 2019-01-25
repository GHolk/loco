#!/bin/sh
# run dual boot windows 10 partition by qemu and ovmf,
# record option in script.

qemu-system-x86_64 -enable-kvm \
                   -m 8G \
                   -smp 4 \
                   -pflash /usr/share/ovmf/OVMF.fd \
                   -vga qxl \
                   "$@"
