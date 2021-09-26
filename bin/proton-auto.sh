#!/bin/sh
# usage: proton-auto.sh [proton-compat-data] game.exe
# PROTON_USE_WINED3D=1 proton-auto

if [ "$1" = "-v" ]
then
    version=$2
    shift 2
else version=5.13
fi

if [ $# -eq 2 ]
then
    if expr match "$1" "/.*" > /dev/null
    then compat_data="$1"
    else compat_data="$(realpath "$1")"
    fi
    shift
else
    compat_data=proton-compat-data
    [ -d $compat_data ] || mkdir $compat_data
fi

export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/steam"
export STEAM_COMPAT_DATA_PATH="$compat_data"

game="$1"
shift
exec "$HOME/.steam/steam/steamapps/common/Proton $version/proton" run "$game"
