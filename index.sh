#!/usr/bin/bash

OPTIND=1

while getopts 'vo' a
do
	case $a in
	( v )
		v='less index.html' ;;
	( o )
		o='xdg-open index.html' ;;
	esac
done


eval d=\$$OPTIND
if [ -d "$d" ]
then
	cd "$d" || ( echo "can not cd $d !">&2 ; exit 1 )
	shift
fi


if [ -s index.html ] 
then 
	mv index.html index_old.html || \
	( echo "cant overwrite index_old.html">&2 ;  exit 10 )
fi

if [ -s index.sh ] && [ -x index.sh ]
then ./index.sh $@ >index.html
else

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

find . -not -path '*/.*' |\
	sed -r -e "s/'/%27/g; s/.*($imgtype)$/<img src='&' title='&'>/i; s/^[^<].*[^>]$/<a href='&'>&<\\/a>/" |\
	#sort $sortarg |\
	sed -e "1i$head" >index.html

fi

$v
$o
