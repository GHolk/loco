#!/bin/sh

url="$1"
base_name="$2"

w3m -dump_source "$url" > "$base_name.html"
w3m -dump "$base_name.html" > "$base_name.txt"

