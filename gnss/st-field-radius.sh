#!/bin/sh

st_field_radius () 
{ 
    local field=$1
    local radius=$2
    local file=$3
    local mean=$(
        awk -v field=$field '{print $(field)}' "$file" |
        st | tail | awk '($1 == "mean") {print $2}'
    )
    awk -v field=$field -v mean=$mean -v radius=$radius     '(mean-radius < $(field) && $(field) < mean+radius) {
        print $(field)
    }' $file | power=200 st
}

st_field_radius "$@"
