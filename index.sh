#!/usr/bin/bash

find -path './.*' -prune -o -print |  sed -r -e 's/"/%22/g' \
	-e 's/.*(gif|jpg|png)$/<img src="&">/i' \
	-e 's/^[^<].*[^>]$/<a href="&">&<\/a>/' \
	-e '1i<link rel="stylesheet" type="text/css" href="http://gholk.github.io/Documents/word.css">' \
	-e '1i<meta charset="UTF-8">' > index.html

