#!/bin/sh

log() {
    echo "$@" >&2
}

tempdir=`mktemp -d $HOME/GipsyX/test/compute-gipsyx-stdin.tmp.XXXXXXXXX`
log tempdir=$tempdir

cd $tempdir
log enter $tempdir

tar -xvf - >&2

rinex=$(echo *.??[oO])
log rinex=$rinex

if [ -n "$tree_dir" ]
then tree_option="-treeSequenceDir $tree_dir"
elif [ -d Trees ]
then tree_option='-treeSequenceDir Trees'
fi

if [ -n "$gde_tree" ]
then gde_option="-gdeTree $gde_tree"
elif [ -f gde.tree ]
then gde_option='-gdeTree gde.tree'
fi

if [ -n "$rec_type" ]
then
    latitude=$(awk '/APPROX POSITION XYZ/ { print $1,$2,$3; exit }' $rinex \
               | cs2cs -f %.10f +proj=cart +to +proj=lonlat \
               | awk '{print $2}')
    rec_type_latitude_option="-recTypeLatitude $rec_type $latitude"
fi

if [ -z $docker_name ]
then docker_name=gxh
fi

docker exec -iu `id -u`:`id -g` $docker_name sh >&2 <<GIPSYX
. /usr/local/GipsyX/rc_GipsyX.sh
cd $tempdir
if [ -x runAgain ]
then ./runAgain
else
    rinex2StaDb.py -o local.sta_db $rinex
    rnxEditGde.py -d $rinex -o dataRecordFile.gz \
                  $gde_option $rec_type_latitude_option
    gd2e.py -runType PPP -drEditedFile dataRecordFile.gz \\
            -staDb local.sta_db \\
            -rec $(echo $rinex | cut -c 1-4 | tr a-z A-Z) \\
            $tree_option
fi
GIPSYX

log start pack file
tar --exclude=$rinex -cf - .

cd ..

log remove work directory
rm -r $tempdir

