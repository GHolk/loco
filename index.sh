#!/usr/bin/bash

# deal with short arguments, store in `$args` . 

## option ##
#
# g : do not treat `*.gif` as img; gif animated is large. 
# o : xdg-open index.html after script. 
# R : random sort the content of html. 
#

for arg in $@
do
	if [[ $arg =~ ^-[^-] ]] 
	then 
		args="$args$arg"
		shift
	fi
done

# deside what sufix is images
imgtype="gif|jpg|png"

if [[ $args =~ g ]]
then imgtype="jpg|png" 
fi

if [[ $args =~ R ]]
then sortarg='-R'
fi

if [ -z $@ ]
then dirs="./"
fi

for dir in $@ $dirs
do

	find $dir -path '*/.*' -prune -o -print |\
		sed -r -e 's/^\.\///g' \
			-e 's/"/%22/g' \
			-e "s/.*($imgtype)$/<img src=\"&\" title=\"&\">/i" \
			-e 's/^[^<].*[^>]$/<a href="&">&<\/a>/' |\
		sort $sortarg |\
		sed -e '1i<link rel="stylesheet" type="text/css" href="http://gholk.github.io/Documents/word.css">' \
			-e '1i<meta charset="UTF-8">' >\
			"${dir}/index.html"
	
	if [[ $args =~ v ]]
	then less "$dir/index.html"
	fi
	
	if [[ $args =~ o ]]
	then xdg-open "$dir/index.html"
	fi

done

exit

