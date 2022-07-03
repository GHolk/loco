#!/bin/sh
help="
usage
        touch -d 2020-01-01T00:00:01 file.txt
        $0 file.txt # mv file.txt 2020-01-01-00-00-01.txt
        $0 -p file.txt # mv file.txt 2020-01-01-00-00-01-file.txt
        $0 (-l|--number) file.txt # mv file.txt 1-file.txt
        $0 (-x|--swap) a a2 b b2 # mv a a2; mv b b2
"

rename_sawp() {
    while [ $# -gt 1 ]
    do
        mv -v "$1" "$2"
        shift 2
    done
}

rename_number() {
    local i=1
    local file
    for file in "$@"
    do
        mv -v "$file" "$i-$file"
        i=$((i+1))
    done
}

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

parse_option_loop() {
    local position_argument_count=0

    while [ $# -gt $position_argument_count ]
    do
        # deal first argument then call recursive
        local argument="$1"
        shift
        case "$argument" in
            -h|--help|"-?")
                echo "$help"
                exit 0
                ;;
            -l|--number)
                number=t
                ;;
            -p|--prefix)
                prefix=t
                ;;
            -d)
                date=t
                ;;
            -x|--swap)
                swap=t
                ;;
            # end of option, following is all argument
            --)
                # throw first following option to the end
                if [ $# -gt $position_argument_count ]
                then
                    local first_option="$1"
                    shift
                    position_argument_count=$((position_argument_count + 1))
                    set -- "$@" "$first_option"
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
        esac
    done

    # $@ is position argument
    main "$@"
}

main() {
    if [ -n $number ]
    then rename_number "$@"
    elif [ -n $swap ]
    then rename_swap "$@"
    else rename_date "$@"
    fi
}

parse_option_loop "$@"
