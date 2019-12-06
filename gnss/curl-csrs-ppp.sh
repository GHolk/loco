#!/bin/sh

do_help() {
    cat <<HELP
usage
        $0 login my@email.edu password
        $0 login my@email.edu @password_file
        $0 login my@email.edu @- # stdin
        $0 post csrs0010.19o my@email.edu Kinematic
        $0 get abcdefghijklmnopqrstuvwxyz_ABCDE-0123456789 > output.zip
        $0 pos-to-lonlat csrs0010.pos > csrs0010.lonlath
HELP
}

do_post() {
    local rinex=$1
    local email=$2
    local station=$3

    if [ -z "$station" ]
    then station=Kinematic
    fi
    
    curl --cookie-jar $cookie_jar \
         -F return_email=$email \
         -F process_type=$station \
         -F sysref=ITRF \
         -F official_marker= \
         -F user_otl_file= \
         -F rfile_upload=@$rinex \
         https://webapp.geod.nrcan.gc.ca/CSRS-PPP/service/submit
}

do_login() {
    email=$1
    password=$2
    curl -i --cookie-jar $cookie_jar \
         -d emaillogin=$email \
         -d passwlogin=$password \
         https://webapp.geod.nrcan.gc.ca/geod/jpWare/process.php
}


do_get_url() {
    local id=$1
    echo "http://webapp.geod.nrcan.gc.ca/CSRS-PPP/service/results/file?id=$id&lang=en&fid=000&type=full"
}

do_get() {
    local id=$1
    shift
    curl "http://webapp.geod.nrcan.gc.ca/CSRS-PPP/service/results/file?id=$id&lang=en&fid=000&type=full" "$@"
}

do_pos_to_lonlath() {
    awk '{printf "%dd%d\x27%f\" %dd%d\x27%f\" %f\n", $24,$25,$26,$21,$22,$23,$27}' "$@"
}

set_cookie_jar() {
    if [ -z "$cookie_jar" ]
    then
        cookie_jar=csrs.cookie
        echo use $cookie_jar as cookie jar file
    fi
}


# main

if [ $# -gt 0 ]
then
    action=$1
    shift
fi

case $action in
    post)
        set_cookie_jar
        do_post $@
        ;;
    login)
        set_cookie_jar
        do_login $@
        ;;
    get)
        do_get $@
        ;;
    get?url)
        do_get_url "$@"
        ;;
    pos_to_lonlath|pos-to-lonlath)
        do_pos_to_lonlath "$@"
        ;;
    help|*)
        do_help
        ;;
esac
