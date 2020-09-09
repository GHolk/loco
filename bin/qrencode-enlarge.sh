#!/bin/sh
# usage: qrencode --type=UTF8 | sh qrencode-enlarge.sh

sed_enlarge() {
    sed '
x
s|^|\n\n|
x

:check_first_char
/^./ {
    /^ / {
        x
        s/\n/  &/g
        x
    }
    /^▄/ {
        x
        s/\n/  &/1
        s/\n/██&/2
        x
    }
    /^▀/ {
        x
        s/\n/██&/1
        s/\n/  &/2
        x
    }
    /^█/ {
        x
        s/\n/██&/g
        x
    }
    s/^.//
    b check_first_char
}
x
s/\n//2
'
}

qrsmall_enlarge() {
    local line1 line2 c1 c2
    local line_raw char
    sed 's/ /_/g; s/[_▄▀█]/& /g' | while read line_raw
    do
        line1=''
        line2=''
        for char in $line_raw
        do
            case $char in
            _)
                c1="  "
                c2="  "
                ;;
            ▄)
                c1="  "
                c2="██"
                ;;
            ▀)
                c1="██"
                c2="  "
                ;;
            █)
                c1="██"
                c2="██"
                ;;
            esac
            line1="$line1$c1"
            line2="$line2$c2"
        done
        printf "%s\n%s\n" "$line1" "$line2"
    done
}

sed_enlarge
