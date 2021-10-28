#!/bin/sh
help="
usage
        touch -d 2020-01-01T00:00:01 file.txt
        $0 file.txt # mv file.txt 2020-01-01-00-00-01.txt
        $0 -p file.txt # mv file.txt 2020-01-01-00-00-01-file.txt
"

rename_date() {
    local suffix
    local file
    file="$1"
    suffix=$(echo "$file" | sed 's/^.*\.//')
    if [ -n "$prefix" ]
    then mv -v "$1" "$(date -r "$1" +%Y-%m-%d-%H-%M-%S)-$1"
    else mv -v "$1" "$(date -r "$1" +%Y-%m-%d-%H-%M-%S)".$suffix
    fi
}

if [ "x$1" = x-p ]
then
    prefix=t
    shift
fi

if [ $# -eq 0 ]
then
    echo "$help"
    exit 1
fi

for file in "$@"
do rename_date "$file"
done
