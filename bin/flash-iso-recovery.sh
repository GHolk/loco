#!/bin/sh

set -e # flash disk is dangerous, exit if any errror.

if [ $# -ne 3 ]
then
    cat <<USAGE
usage
        $0 cdrom.img /dev/sdz backup.img.gz
USAGE
    exit 22
fi

cdrom="$1"
disk="$2"
backup="$3"

cdrom_size=$(wc -c "$cdrom" | cut -d ' ' -f 1)

if [ -z $dd_block_size ]
then dd_block_size=4194304 # 4MB
fi

dd_count=$(expr $cdrom_size / $dd_block_size + 1)

echo backup size is $(expr $dd_block_size \* $dd_count)
echo backup "$disk" to "$backup"
dd if="$disk" bs=$dd_block_size count=$dd_count | gzip - > "$backup"

echo write "$cdrom" to "$disk"
dd if="$cdrom" of="$disk" bs=$dd_block_size

echo recover disk by "zcat '$backup' | dd of='$disk' bs=$dd_block_size"
