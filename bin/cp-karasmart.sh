#!/bin/sh
# cp-karaokay 愛情的模樣-五月天.mpg ~/media/drive

find_id() {
    local dir="$1"
    local id
    id=$(find "$dir" -printf "%P\n" |
        sed -r '/^[0-9]{5}\./!d; s/\..*$//' |
        sort -n | tail -n 1)
    if [ -n "$id" ]
    then id=$((id+1))
    else id=95001
    fi
    echo $id
}

print_help() {
    true
}

warn() {
    echo $* >&2
}

parse_option_loop() {
    local position_argument_count=0

    while [ $# -gt $position_argument_count ]
    do
        # deal first argument then call recursive
        local argument="$1"
        shift
        case "$argument" in
            -h|--help)
                print_help
                exit 0
                ;;
            -d|--debug)
                DEBUG=1
                ;;
            -i|--id)
                id=$1
                shift
                ;;
            -t|--title)
                title="$1"
                shift
                ;;
            -b|--band)
                band="$1"
                shift
                ;;
            -n|--name)
                name="$1"
                shift
                ;;
            # end of option, following is all argument
            --)
                # throw first following option to the end
                if [ $# -gt $position_argument_count ]
                then
                    local first_option="$1"
                    shift
                    position_argument_count=$((position_argument_count + 1))
                    set -- -- "$@" "$first_option"
                fi
                ;;
            --*)
                warn unknown argument $argument
                exit 1
                ;;
            -??*)
                local first_char=$(expr substr $argument 2 1)
                local else_char=$(expr substr $argument 3 \( length $argument \))
                set -- -$first_char -$else_char "$@"
                ;;
            -?)
                warn unknown argument $argument
                exit 1
                ;;
                # argument no match is position argument
            *)
                # append position argument to the end of calling list
                position_argument_count=$((position_argument_count + 1))
                set -- "$@" "$argument"
                ;;
        esac
    done
    mv="$1"
    dest="$2"
}

parse_option_loop "$@"

debug() {
    [ $DEBUG ] || return
    echo id=$id title=$title band=$band
}

debug

empty() {
    test -z "$1"
}

ssed() {
    local string="$1"
    shift
    echo "$string" | sed "$@"
}

auto_fill() {
    local base
    base=$(basename "$mv")
    if empty "$name"
    then
        if empty "$title"
        then title=$(ssed "$base" -r 's/-.*?$//')
        fi
        if empty "$band"
        then band=$(ssed "$base" -r 's/^.*-//; s/\..*$//')
        fi
        name="$title ($band)"
    fi
    if [ -d "$dest" ]
    then
        if empty "$id"
        then id=$(find_id "$dest")
        fi
        dest_file="$dest/$id.dat"
    else
        dest_file="$dest"
        id=$(ssed "$dest_file" 's#^.*/##; s#\..*$##')
    fi
}

auto_fill

store_karaokay() {
    local dest_info=$(ssed "$dest_file" 's/\..*$/.info/')
    if [ $DEBUG ]
    then
        echo cp "$mv" "$dest_file"
        printf '%d\n%s\n' "$id" "$name"
        echo "$dest_info"
    else
        cp "$mv" "$dest_file" \
        && printf '%d\n%s\n' "$id" "$name" > "$dest_info"
    fi
}

store_karaokay
