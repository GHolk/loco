#!/bin/sh
# run dual boot windows 10 partition by qemu and ovmf,
# record option in script.

# file=/usr/share/ovmf/OVMF_CODE.fd,readonly=on
# file=/usr/share/ovmf/OVMF_VARS.fd
# -net none

qemu-system-x86_64 -enable-kvm \
                   -m 2G -smp 2 \
                   -monitor stdio \
                   -net user -net nic -soundhw all \
                   -drive if=pflash,file=/usr/share/ovmf/OVMF.fd,format=raw,readonly=on \
                   "$@"
