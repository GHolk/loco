#!/usr/bin/bash

if [ -d "$1" ]
then
	cd "$1" || ( echo "can not cd $1 !">&2 ; exit 1 )
	shift
fi


if [ -s index.html ] 
then 
	mv index.html index_old.html || \
	( echo "cant overwrite index_old.html">&2 ;  exit 10 )
fi

# 重導向 stdout 到 index.html ，
# 並保存 stdout 到 &6 。
# 在 */index.sh 中可以用 >&6 來訪問 stdout ，
# 預設則輸出到 index.html. 
exec 6>&1
exec >./index.html

if [ -s index.sh ] && [ -x index.sh ]
then exec ./index.sh $@
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
	sed -e "1i$head" 

fi

if [ -n "$see" ]
then less "$dir/index.html"
fi

if [ -n "$open" ]
then xdg-open "$dir/index.html"
fi

