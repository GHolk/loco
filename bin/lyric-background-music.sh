#!/bin/sh

if [ $# -lt 3 ]
then
    cat >&2 <<USAGE
usage:
        `basename $0` lyric.srt background.jpg music.mp3 mv.mpg

* lyric.srt only accept srt format.
* background.jpg can be other common image format.
* music.mp3 can be other common music format.
* mv.mpg can be other common video format.

USAGE
exit 22
fi

lyric="$1"
image="$2"
music="$3"
mv="$4"

ffmpeg -loop 1 \
       -i "$image" \
       -i "$music" \
       -vf subtitles="f=$lyric:force_style='FontName=宋體,FontSize=16'" \
       -shortest "$mv"
