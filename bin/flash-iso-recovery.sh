#!/bin/sh

set -e # flash disk is dangerous, exit if any errror.

environment_or_assign() {
    # if variable not defined, set value
    local name value
    name=$1
    value="$2"
    if eval [ -z "\"\$$name\"" ]
    then
        eval "$name='$value'"
    fi
}

if [ $# -ne 3 ]
then
    cat <<USAGE
usage
        $0 cdrom.img /dev/sdz backup.img
USAGE
    exit 22
fi

environment_or_assign cdrom "$1"
environment_or_assign disk "$2"
environment_or_assign backup "$3"

environment_or_assign cdrom_size $(wc -c "$cdrom" | cut -d ' ' -f 1)
environment_or_assign disk_size $(
    fdisk -l "$disk" |
    sed -E '1{s/.* ([[:digit:]]+) bytes.*/\1/; q}'
)

if [ $cdrom_size -gt $disk_size ]
then
   echo "cdrom size $cdrom_size greater than disk size $disk_size" >&2
   exit 28
fi

environment_or_assign dd_block_size 4194304 # 4M
environment_or_assign dd_count $(expr $cdrom_size / $dd_block_size + 1)

echo backup size is $(expr $dd_block_size \* $dd_count)
echo backup "$disk" to "$backup"

dd if="$disk" of="$backup" bs=$dd_block_size count=$dd_count

echo write "$cdrom" to "$disk"
dd if="$cdrom" of="$disk" bs=$dd_block_size

echo recover disk by "dd if='$backup' of='$disk' bs=4M"
