#!/bin/sh
. $HOME/.bash_function

set -e

week_day_to_day_count() {
    local week day
    week=$1
    day=$2
    echo $((week * 7 + day))
}
day_count_to_week_day() {
    local day
    day=$1
    echo $((day / 7)) $((day % 7))
}

format_precise_url() {
    local week day base_name base_url
    week=$1
    day=$2
    base_name="igs$week$day"
    base_url="ftp://cddis.nasa.gov/gnss/products/$week/$base_name"
    echo $base_url.sp3.Z
    echo $base_url.clk.Z
}

copy_to_csrs() {
    file="$1"
    ln -s "$(realpath "$file")" "$csrs_root"
}
wn_tow_to_wn_dow() {
    week=$1
    second=$2
    echo $week $((second / 24 / 60 / 60))
}
utc_to_wn_dow() {
    local utc
    utc=$1
    wn_tow_to_wn_dow `utc-to-wn-tow $utc`
}


# rinex=filename.17o
eval $(
    sed -En '/TIME OF FIRST OBS[[:space:]]*$/ {
               s/^ *([0-9]{4} +[0-9]{1,2} +[0-9]{1,2}).*$/\1/
               s/ +/-/g
               s/^/utc_start=/
               p
             }
             /^ *([0-9]{2,4} +[0-9]{1,2} +[0-9]{1,2}) +.*$/h
             $ {
               g
               s/^ *([0-9]{2,4} +[0-9]{1,2} +[0-9]{1,2}) +.*$/\1/
               s/ +/-/g
               s/^/utc_end=20/
               p
             }' \
         "$rinex"
)

utc_start=`date -u -Is -d $utc_start`
utc_end=`date -u -Is -d $utc_end`
gps_start=$(wn_tow_to_wn_dow `utc-to-wn-tow $utc_start`)
gps_end=$(wn_tow_to_wn_dow `utc-to-wn-tow $utc_end`)

url_list=$(
    seq `week_day_to_day_count $gps_start` `week_day_to_day_count $gps_end` | (
        while read day_count
        do
            week_day=`day_count_to_week_day $day_count`
            format_precise_url $week_day
        done
    )
)

origin_directory="$PWD"

set_if_empty csrs_root ~/csrs || true

copy_to_csrs "$rinex"
file_to_remove=$(basename "$rinex")

if [ -e "$command" ]
then
    copy_to_csrs "$command"
    file_to_remove="$file_to_remove
$(basename "$command")"
fi

cd "$csrs_root"

wget $url_list
base_list="$(echo "$url_list" | sed 's!^.*/!!')"
gzip -d $base_list

rinex_no_suffix=$(basename "$rinex" | sed 's/\...o//i')

./source/ppp34613 > $rinex_no_suffix.log <<PPP
$(basename "$rinex")
$(basename "$command")
0 0
0 0
$(echo "$base_list" | sed 's/\.Z$//')
PPP

rm $(basename "$rinex")
mv $rinex_no_suffix.* $(echo "$base_list" | sed 's/\.Z$//') "$origin_directory"

echo "$file_to_remove" | xargs -d '\n' rm
