#!/bin/sh

while [ $# -gt 0 ]
do
    argument="$1"
    shift
    case "$argument" in
        -a|--all-process) list_all_process=t ;;
        -x|--exclude-leader) exclude_leader=t ;;
        -??*)
            option_first=$(expr substr "$argument" 2 1)
            option_else=$(expr substr "$argument" 3 \( length "$argument" \))
            set -- -$option_first -"$option_else" "$@"
            ;;
        *)
            pid=$argument
            break
            ;;
    esac
done

pgid=`ps --no-headers --format pgid:1 $pid`

if [ -n "$list_all_process" ]
then
    ps -A --no-headers --format pgid:1,pid:1 |
        awk "(\$1 == $pgid) {print \$2}" |
        (
            if [ -n "$exclude_leader" ]
            then grep -v "^$pgid\$"
            else cat
            fi
        )
else
    echo $pgid
fi
