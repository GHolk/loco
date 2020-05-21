#!/bin/sh
url="$1"
shift
option='format=KMZ-LinesPoints'

curl --remote-name --remote-header-name "$url?$option"
