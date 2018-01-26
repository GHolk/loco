#!/bin/sh
#
# this script wrap xsel

if [ `basename $0` = clipboard ]
then board=clipboard
else board=primary # selection
fi

if [ -t 0 ]
then if [ $# -gt 0 ]
then echo -n "$*" | xsel --input --$board
else xsel --output --$board
fi
else xsel --input --$board
fi

