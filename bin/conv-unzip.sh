#!/bin/sh
encoding="$1"
zip="$2"

env LANG=c 7z x "$zip"
convmv -f $encoding -t utf *
