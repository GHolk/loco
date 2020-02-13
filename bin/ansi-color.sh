#!/bin/sh

range() {
    local command="$1"
    shift

    local x
    for x in $1
    do
        $command $x
    done
}



print_color() {
    local color="$1"
    local string="$2"
    printf "\e[%sm%s\e[m" $color "$string"
}

print_row() {
    print_color "$1;$2" " Tt "
}

background_classic=`seq -f '%-4.0f' 40 47 | tr -d '\n'`
cat <<CLASSIC
\e[ $background_classic ;    ${background_classic}m
CLASSIC

for foreground in '  ' `seq 30 37`
do
    printf "%s %s %s %s\n" \
        "$foreground" \
        "$(range "print_row 0;$foreground" "$background_classic")" \
        "1;$foreground" \
        "$(range "print_row 1;$foreground" "$background_classic")"
done

background_modern=`seq -f '%-4.0f' 100 107 | tr -d '\n'`
cat <<MODERN
\e[ $background_modern ;    ${background_modern}m
MODERN

for foreground in '  ' `seq 90 97`
do
    printf "%s %s %s %s\n" \
        "$foreground" \
        "$(range "print_row 0;$foreground" "$background_modern")" \
        "1;$foreground" \
        "$(range "print_row 1;$foreground" "$background_modern")"
done
