#!/bin/sh
# usage: proton-auto.sh [proton-compat-data] game.exe
# PROTON_USE_WINED3D=1 proton-auto

if [ "$1" = "-v" ]
then
    version=$2
    shift 2
elif [ "$1" = -t ]
then
    echo "$1" | sed 's#\\#/#g; s#^#proton-compat-data/pfx#'
    exit 0
fi

if [ -d "$1" ]
then
    if expr match "$1" "/.*" > /dev/null
    then compat_data="$1"
    else compat_data="$(realpath "$1")"
    fi
    shift
else
    compat_data=proton-compat-data
    [ -d $compat_data ] || mkdir $compat_data
    compat_data="$PWD/proton-compat-data"
fi

if [ -z "$version" ]
then
    version=$(sed 's/-.*$//' "$compat_data/version") || {
        echo please specify version
        exit 1
    }
fi

export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/steam"
export STEAM_COMPAT_DATA_PATH="$compat_data"

game="$1"
shift
"$HOME/.steam/steam/steamapps/common/Proton $version/proton" \
     run "$game" "$@"
