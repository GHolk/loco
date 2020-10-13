#!/bin/sh

ffmpeg_karaokay_size=640:480
ffmpeg_karaokay_audio_scale=1
ffmpeg_karaokay_lyric_ss_second=1.5
ffmpeg_karaokay_lyric_font_size=24
ffmpeg_karaokay_lyric_mojim_format=*.lrc

ffmpeg_volume() {
    local input=$1 scale=$2 output=$3
    ffmpeg -i $input -filter:a volume=$scale $output
}

ffmpeg_resolution() {
    local input=$1 width=$2 output=$3
    ffmpeg -i $input -vf scale=$width:-1 $output
}

ffmpeg_padding() {
    local input=$1 output=$2
    # pad to 640x480, place origin vedio at left 0 top 120
    ffmpeg -i $input -vf "pad=width=640:height=480:x=0:y=120:color=black" $output
}

ffmpeg_all() {
    local input="$1" lyric=$2 output=$3
    ffmpeg -i "$input" -i "$input" \
           -ss 1 -vf scale=560:-1,subtitles="f=$lyric:force_style='FontSize=24'",pad="640:480:-1:-1" \
           -af volume=$ffmpeg_karaokay_audio_scale \
           -map 0:a -map 1:v $output
}

ffmpeg_lyric() {
    local lyric="$1" image="$2" music="$3" mv="$4"

    ffmpeg -loop 1 \
           -i "$image" \
           -i "$music" \
           -vf subtitles="f=$lyric:force_style='FontSize=16'",scale=640:-1 \
           -shortest "$mv"
}
