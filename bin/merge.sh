#!/bin/sh

command=$1
fullpath="$2"
basepath=$(echo "$fullpath" | sed -r 's/\..+?$//')
basename=$(basename "$basepath")
first() {
    echo "$1"
}

export LANG=en

case $command in
    list)
        size=$(first $(wc -c "$basepath".* | tail -n 1))
        date=$(date --reference="$(first "$basepath".*)" +"%b %d %Y %H:%M")
        id="`id -u` `id -g`"
        cat <<LIST
-r--r--r-- 1 $id $size $date $(basename "$basename" .split)
LIST
        ;;
    copyout)
        source="$3"
        destination="$4"
        cat "$basepath".* > "$destination"
        ;;
    *)
        echo unknown operation $command > $$.log
        ;;
esac

