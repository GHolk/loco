#!/bin/sh

source="$1"
target="$2"

print_usage() {
    program=$(basename $0)
    cat <<EOF
usage
        ## pipe to remote file
        tar -czf - ~/ | $program - my.server.org:home-backup.tar.gz

        ## pipe from remote file
        $program my.server.org:home-backup.tar.gz - | tar -xzf - ~/..
EOF
}

set_ssh_variable() {
    server="$(echo "$*" | cut -d ':' -f 1)"
    path="$(echo "$*" | cut -d ':' -f 2-)"
}

escape_single_quote() {
    echo "$1" | sed "s/'/\\\\'/g"
}


if [ "$source" = "-" ] && [ "$target" = "-" ]
then
    print_usage >&2
    exit 22
elif [ "$source" = "-" ]
then
    set_ssh_variable "$target"
    ssh "$server" "cat > '$(escape_single_quote "$path")'"
elif [ "$target" = "-" ]
then
    set_ssh_variable "$source"
    ssh "$server" "cat '$(escape_single_quote "$path")'"
else
    print_usage >&2
    exit 22
fi


