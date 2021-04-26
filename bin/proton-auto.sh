#!/bin/sh
# usage: proton-auto.sh [proton-compat-data] game.exe

if [ $# -eq 2 ]
then
    compat_data="$1"
    shift
else
    compat_data=proton-compat-data
    [ -d $compat_data ] || mkdir $compat_data
fi

export STEAM_COMPAT_DATA_PATH="$PWD/$compat_data"

game="$1"
shift
exec "$HOME/.steam/steam/steamapps/common/Proton 5.13/proton" run "$game"
