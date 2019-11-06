#!/bin/sh

_format_degree=%.10f
_format_meter=%.5f
alias xyz2llh='cs2cs -f $_format_degree +proj=cart +to +proj=lonlat'
alias xyz2twd97='cs2cs -f $_format_meter +proj=cart +to +init=epsg:3826'
alias llh2twd97='proj -f $_format_meter +init=epsg:3826'

gdcat_to_xyz() {
    awk '/STA.[XYZ]/ { p[substr($2,10,1)] = $4}
         /STA.Z/ { epoch = $3; print p["X"],p["Y"],p["Z"], epoch }' "$@"
}

rinex_name_3_to_2() {
    local rinex2=$1
    local date=20$(expr substr $rinex2 1 6)
    local suffix=$(expr substr $rinex2 \( length $rinex2 \) 1)
    date -d $date +"%03j0.%y$suffix"
}
