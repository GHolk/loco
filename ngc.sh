#!/usr/bin/env bash

gcin2tab ~/C/ime/supcj.cin 
cp ~/C/ime/supcj.gtab /usr/share/gcin/table/NewCJ3.gtab
kill `pidof gcin`

#raw=$*
#files=${raw% -*}
#arg=${raw##* -}
#
#for file in $files
#
#	do
#	gcin2tab $file
#	cp ${file%.*}.gtab /usr/share/gcin/table/
#	done
#
