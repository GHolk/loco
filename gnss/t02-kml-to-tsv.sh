#!/bin/sh
sed 's/<kml.*>/<kml>/' \
| xmlstarlet select -t -e xml \
    -m "/kml/Document/Folder[name='Points']/Placemark" \
    -e p -v description -e c -v Point/coordinates \
| xmlstarlet unesc \
| sed 's/&nbsp;/ /g' \
| xmlstarlet select -t -m /xml/p \
    -v 'normalize-space(c)' -o , \
    -v 'table/tr/td[.="UTC"]/following-sibling::td' --nl \
| sed 's/,/ /g'
