#!/bin/sh
url=http://atom.local:5566/
if [ $# -gt 0 ]
then curl --silent --data-urlencode clip="$*" $url >/dev/null
else curl --silent $url |
        sed -n '/textarea id=.disp/ {n; s/<.textarea>$//; p; q }'
fi

