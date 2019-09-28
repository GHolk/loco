#!/bin/sh

warn() {
    echo "$@" >&2
}

# recursive parsing,
# count then put position argument to the end of $@
position_argument_count=0
parse_option() {
    # rest argument is all position argument
    if [ $position_argument_count -eq $# ]
    then
        # $@ is position argument
        # main "$@"
        printf -- '"%s" ' "$@"
        printf "\n"
        return 0
    fi

    # deal first argument then call recursive
    local argument="$1"
    shift
    case "$argument" in
        --help)
            echo "just use it"
            exit 0
            ;;
        -n|--number)
            if expr "$1" : "^-" >/dev/null
            then n=5
            else
                n=$1
                shift
            fi
            ;;
        -s|--string)
            s="$1"
            shift
            ;;
        -E)
            easy=1
            ;;
        -W)
            warn=1
            ;;
        # end of option, following is all argument
        --)
            # throw first following option to the end
            if [ $# -gt $position_argument_count ]
            then
                local first_option="$1"
                shift
                position_argument_count=$((position_argument_count + 1))
                parse_option -- "$@" "$first_option"
                return
            fi
            ;;
        --*)
            warn unknown argument $argument
            exit 1
            ;;
        -??*)
            local first_char=$(expr substr $argument 2 1)
            local else_char=$(expr substr $argument 3 \( length $argument \))
            parse_option -$first_char -$else_char "$@"
            return
            ;;
        -?)
            warn unknown argument $argument
            exit 1
            ;;
        # argument no match is position argument
        *)
            # append position argument to the end of calling list
            position_argument_count=$((position_argument_count + 1))
            parse_option "$@" "$argument"
            return
    esac
    parse_option "$@"
}

parse_option_loop() {
    local position_argument_count=0

    while [ $# -gt $position_argument_count ]
    do
        # deal first argument then call recursive
        local argument="$1"
        shift
        case "$argument" in
            --help)
                echo "just use it"
                exit 0
                ;;
            -n|--number)
                if expr "$1" : "^-" >/dev/null
                then n=5
                else
                    n=$1
                    shift
                fi
                ;;
            -s|--string)
                s="$1"
                shift
                ;;
            -E)
                easy=1
                ;;
            -W)
                warn=1
                ;;
            # end of option, following is all argument
            --)
                # throw first following option to the end
                if [ $# -gt $position_argument_count ]
                then
                    local first_option="$1"
                    shift
                    position_argument_count=$((position_argument_count + 1))
                    parse_option -- "$@" "$first_option"
                    return
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
    # main "$@"
    printf -- '"%s" ' "$@"
    printf "\n"
}

parse_option_loop "$@"

if [ -n "$warn" ]
then echo warning!
fi

if [ -n "$easy" ]
then echo take it easy.
fi


echo string $s
echo number $n
