#!/bin/sh

ffmpeg_volume() {
    local input=$1 scale=$2 output=$3
    ffmpeg -i $input -filter:a volume=$scale $output
}

ffmpeg_resolution() {
    local input=$1 width=$2 output=$3
    ffmpeg -i $input -vf scale=$width:-1 $output
}


ffmpeg_lyric() {
    local lyric="$1" image="$2" music="$3" mv="$4"

    ffmpeg -loop 1 \
           -i "$image" \
           -i "$music" \
           -vf subtitles="f=$lyric:force_style='FontSize=16'" \
           -vf scale=640:-1 \
           -shortest "$mv"
}
