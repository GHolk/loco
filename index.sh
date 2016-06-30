#!/usr/bin/bash

# deal with short arguments, store in `$args` . 

## option ##
#
# g : do not treat `*.gif` as img; gif animated is large. 
# o : xdg-open index.html after script. 
# R : random sort the content of html. 
# v : use less to open each index. 
# d : set the depth of search. if call -d without argument; 
#     set depth to 1. default set no limit. 
#

# define head of html

head='\
<html>\
<meta charset="UTF-8">\
<style>\
img { max-width: 80%; }\
a { display: block; }\
</style>\
'

# deside what sufix is images
imgtype="gif|jpg|png"
out=" >index.html "

while true
do

	# parse option
	if [[ $1 =~ ^-[^-] ]] 
	then 
		case $1 in
		( *g* ) imgtype="jpg|png"
		;;&

		( *R* ) sortarg=" -R "
		;;&

		( *v* ) see=1
		;;&

		( *o* ) open="xdg-open"
		;;&

		( *d* )
			if [[ $2 =~ ^[0-9]$ ]]
			then farg=" -maxdepth $2 "
				shift
			else farg=" -maxdepth 1 "
			fi
		;;&

		( *V* ) out=
		;;&
		esac


		shift
		continue

	fi

### argument for find

	if [ "$1" ]
	then dir="${1%/}"
	else dir="."
	fi

	if [ "$out" ] 
	then out=" >\"$dir/index.html\" "
	fi

	find "$dir" $farg -path '*/.*' -prune -o -print |\
		sed -r -e "s/'/%27/g; s/.*($imgtype)$/<img src='&' title='&'>/i; s/^[^<].*[^>]$/<a href='&'>&<\\/a>/" |\
		sort $sortarg |\
		eval sed -e '"1i$head"' $out
	
	if [ $see ]
	then less "$dir/index.html"
	fi

	if [ $open ]
	then xdg-open "$dir/index.html"
	fi

	if [ $2 ]
	then shift
	else exit 0
	fi

done

