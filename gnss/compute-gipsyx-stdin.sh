#!/bin/sh

log() {
    echo "$@" >&2
}

tempdir=`mktemp -d $HOME/GipsyX/test/compute-gipsyx-stdin.tmp.XXXXXXXXX`
log tempdir=$tempdir

cd $tempdir
log enter $tempdir

tar -xvf - >&2

rinex=*.??[oO]
log rinex=$rinex

docker exec -i brave_booth sh >&2 <<GIPSYX
. ./rc_GipsyX.sh
cd $tempdir
gd2e.py -rnxFile $rinex
GIPSYX

log start pack file
ls >&2
tar --exclude=$rinex -cf - .

