#!/bin/sh

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
         -F nad83_custom=1997-01-01 \
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


do_get() {
    local id=$1
    curl "http://webapp.geod.nrcan.gc.ca/CSRS-PPP/service/results/file?id=$id&lang=en&fid=000&type=full"
}

do_help() {
    cat <<HELP
usage
        $0 login my@email.edu
        $0 post csrs0010.19o my@email.edu Kinematic
        $0 get abcdefghijklmnopqrstuvwxyz_ABCDE-0123456789 > output.zip
HELP
}

set_cookie_jar() {
    if [ -z "$cookie_jar" ]
    then
        cookie_jar=csrs.cookie
        echo use $cookie_jar as cookie jar file
    fi
}


# main

action=$1
shift

case action in
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
    help|*)
        do_help
        ;;
esac
