#!/bin/sh
input="$1"
output="$2"
gs -q -sDEVICE=pdfwrite -sOutputFile="$output" "$input"
