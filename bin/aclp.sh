#!/bin/sh
#
# this script wrap xsel

if [ "$0" = clipboard ]
then board=clipboard
else board=primary # selection
fi

if [ -t 0 ]
then if [ -n "$*" ]
then echo -n "$*" | xsel --input --$board
else xsel --output --$board
fi
else xsel --input --$board
fi




