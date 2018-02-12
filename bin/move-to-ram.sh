#!/bin/sh

ram=/dev/shm
disk_path="$1"
disk_file=$(basename "$disk_path")
absolute_path=$(realpath "$disk_path")
ram_directory=$(mktemp --directory $ram/ram-directory-XXXXXX)
file_in_ram="$ram_directory/$disk_file"

mv "$disk_path" $ram_directory/
ln -s "$file_in_ram" "$disk_path"

while [ "$quit" != quit ]
do
    echo input \"quit\" to move path bake to disk
    read quit
done

rm "$disk_path"
mv "$file_in_ram" "$disk_path"
rmdir $ram_directory

