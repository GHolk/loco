#!/bin/sh

set -e # flash disk is dangerous, exit if any errror.

if [ $# -ne 3 ]
then
    cat <<USAGE
usage
        $0 cdrom.img /dev/sdz backup.img
USAGE
    exit 22
fi

cdrom="$1"
disk="$2"
backup="$3"

cdrom_size=$(wc -c "$cdrom" | cut -d ' ' -f 1)
disk_size=$(
    fdisk -l "$disk" |
    sed -E '1{s/.* ([[:digit:]]+) bytes.*/\1/; q}'
)

if [ $cdrom_size -gt $disk_size ]
then
   echo "cdrom size $cdrom_size greater than disk size $disk_size" >&2
   exit 28
fi

if [ -z $dd_block_size ]
then dd_block_size=4194304 # 4M
fi

dd_count=$(expr $cdrom_size / $dd_block_size + 1)

echo backup size is $(expr $dd_block_size \* $dd_count)
echo backup "$disk" to "$backup"

dd if="$disk" of="$backup" bs=$dd_block_size count=$dd_count

echo write "$cdrom" to "$disk"
dd if="$cdrom" of="$disk" bs=$dd_block_size

echo recover disk by "dd if='$backup' of='$disk' bs=4M"
