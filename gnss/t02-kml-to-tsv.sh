#!/bin/sh
# output:
# longitude latitude height utc-time satellite-number
# stdev-east stdev-north stdev-height

sed 's/<kml.*>/<kml>/' \
| xmlstarlet select -t -e xml \
    -m "/kml/Document/Folder[name='Points']/Placemark" \
    -e p -v description -e c -v Point/coordinates \
| xmlstarlet unesc \
| sed 's/&nbsp;/ /g' \
| xmlstarlet select -t -m /xml/p \
    -v 'normalize-space(c)' -o , \
    -m table \
    -v 'tr/td[.="UTC"]/following-sibling::td' -o , \
    -v 'tr/td[.="Used"]/following-sibling::td' -o , \
    -v 'tr/td[.="PDOP"]/following-sibling::td' -o , \
    -m 'tr[contains(td, "Sigma")]/following-sibling::tr[position() <= 3]' \
        -v 'td[2]' --if 'position() < 3' -o , --break --break \
    --break --nl \
| sed 's/m//g; s/,/ /g'
