#!/bin/sh

_format_degree=%.10f
_format_meter=%.5f
alias xyz2llh='cs2cs -f $_format_degree +proj=cart +to +proj=lonlat'
alias xyz2twd97='cs2cs -f $_format_meter +proj=cart +to +init=epsg:3826'
alias llh2twd97='proj -f $_format_meter +init=epsg:3826'
