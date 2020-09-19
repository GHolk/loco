#!/bin/sh
# usage:
# adb-clipboard "this text will be sent to android clipboard"
# adb-clipboard > file-contain-android-clipboard-data
#
# this script require app [Adb Clipboard] installed and adb enabled on android.
# this script will prompt android's address for adb connect
# if no android device found.
#
# [Adb Clipboard]: https://play.google.com/store/apps/details?id=ch.pete.adbclipboard

app_name=ch.pete.adbclipboard

adb_connect_interactive() {
    local address
    echo android address:
    read address
    if adb connect $address
    then adb wait-for-any-device
    else
        echo connect error
        adb_connect_interactive
    fi
}

adb_retry() {
    adb_connect_interactive
    exec "$0" "$@"
}

if [ $# -gt 0 ]
then
    data="$*"
    if ! adb shell am broadcast \
         -n $app_name/.WriteReceiver \
         -e text "$(urlencode "$data")"
    then adb_retry "$@"
    fi
else 
    if ! output=$(adb shell am broadcast -n $app_name/.ReadReceiver)
    then adb_retry "$@"
    else echo "$output" | sed '1d; s/^[^"]*"//; s/"$//'
    fi
fi
