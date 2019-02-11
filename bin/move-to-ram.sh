#!/bin/sh

ram=/dev/shm
disk_path="$1"
disk_file=$(basename "$disk_path")
absolute_path=$(realpath "$disk_path")
ram_directory=$(mktemp --directory $ram/ram-directory-XXXXXX)
file_in_ram="$ram_directory/$disk_file"

cp -r "$disk_path" $ram_directory/
mv "$disk_path" "$disk_path.bak"
ln -s "$file_in_ram" "$disk_path"

while [ "$quit" != quit ]
do
    echo input \"quit\" to move path bake to disk
    read quit
done

if diff -r "$file_in_ram" "$disk_path.bak" >/dev/null
then
    # diff exit 0 mean same
    rm -r "$file_in_ram" "$disk_path"
    mv "$disk_path.bak" "$disk_path"
else
    # diff exit 1 mean different
    rm -r "$disk_path" "$disk_path.bak"
    mv "$file_in_ram" "$disk_path"
fi

rmdir $ram_directory

