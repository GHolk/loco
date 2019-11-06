#!/bin/sh

parse_option() {
    while [ $# -gt 0 ]
    do
        local argument="$1"
        shift
        case "$argument" in
        --tree|-t)
            tree_option="-treeSequenceDir $1"
            shift
            ;;
        --gde-tree|-g)
            gde_option="-gdeTree $1"
            shift
            ;;
        --rec-type|--receiver-type|-r)
            receiver_type="$1"
            shift
            ;;
        -o|--option)
            other_option="$1"
            shift
            ;;
        -d|--docker)
            docker_name="$1"
            shift
            ;;
        -?)
            log "unknown option $argument"
            exit 1
            ;;
        --?*)
            log "unknown long option $argument"
            exit 1
            ;;
        -??*)
            local first_char=$(expr substr x$argument 3 1)
            local other_char=$(expr substr x$argument 4 \(
                                     length x$argument \) )
            set -- -$first_char -$other_char "$@"
            ;;
        *)
            rinex=$(realpath "$argument")
            break
            ;;
        esac
    done
}

log() {
    echo "$@" >&2
}

parse_option "$@"

tempdir=`mktemp -d $HOME/GipsyX/test/compute-gipsyx-stdin.tmp.XXXXXXXXX`
log tempdir=$tempdir

cd $tempdir
log enter $tempdir

if ( [ -n "$rinex" ] && [ -f "$rinex" ] )
then
    ln "$rinex" ./ || ( log "can not link $rinex" && exit 2 )
    rinex="$(basename "$rinex")"
else 
    tar -xvf - >&2
    rinex=$(echo *.??[oOdD])
fi

log rinex=$rinex

if [ -d Trees ] && [ -z "$tree_option" ]
then tree_option='-treeSequenceDir Trees'
fi

if [ -f gde.tree ] && [ -z "$gde_option" ]
then gde_option='-gdeTree gde.tree'
fi

if [ -z $docker_name ]
then docker_name=gxh
fi

if [ -n "$receiver_type" ]
then
    latitude=$(
        awk '/APPROX POSITION XYZ/ {print $1,$2,$3; exit}' $rinex \
        | cs2cs -f %.10f +proj=cart +to +proj=lonlat \
        | awk '{print $2}'
    )
    rec_type_latitude_option="-recTypeLatitude $rec_type $latitude"
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
            $tree_option $other_option
fi
GIPSYX

log start pack file
tar --exclude=$rinex -cf - .

cd ..

log remove work directory
rm -r $tempdir

