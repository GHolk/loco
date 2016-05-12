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
<meta charset="UTF-8">\
<style>\
img { max-width: 80%; }\
a { display: block; }\
</style>\
'

# deside what sufix is images
imgtype="gif|jpg|png"

while true
do

	# parse option
	if [[ $1 =~ ^-[^-] ]] 
	then 
		if [[ $1 =~ g ]]
		then imgtype="jpg|png"
		fi

		if [[ $1 =~ R ]]
		then sortarg=" -R "
		fi

		if [[ $1 =~ v ]]
		then see=1
		fi

		if [[ $1 =~ o ]]
		then open="xdg-open"
		fi

		if [[ $1 =~ d ]]
		then 
			if [[ $2 =~ ^[0-9]$ ]]
			then farg=" -maxdepth $2 "
				shift
			else farg=" -maxdepth 1 "
			fi
		fi

		shift
		continue

	fi

### argument for find

	dir="${1%/}"
	if [ "$dir" == "" ]
	then dir="./"
	fi

	find "$dir" $farg -path '*/.*' -prune -o -printf "%P\n" |\
		sed -r -e "s#^$dir##g" \
			-e 's/"/%22/g' \
			-e "s/.*($imgtype)$/<img src=\"&\" title=\"&\">/i" \
			-e 's/^[^<].*[^>]$/<a href="&">&<\/a>/' |\
		sort $sortarg |\
		sed -e "1i$head" > "${dir}/index.html"
	
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

