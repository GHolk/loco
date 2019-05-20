#!/bin/sh

url="$1"

wget_cookie="wget --keep-session-cookies --no-check-certificate"

cookie_temp=$(mktemp /tmp/google-drive-download-XXXXXXXX.cookies.tmp)
confirm_key=$(
    $wget_cookie --quiet --save-cookies $cookie_temp \
                 --output-document - "$url" \
     | perl -0ne '/confirm=([-\w_]+)/ && print $1'
)

$wget_cookie --load-cookie $cookie_temp \
             --content-disposition \
             "$url&confirm=$confirm_key"

rm $cookie_temp
