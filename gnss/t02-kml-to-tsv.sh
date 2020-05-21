xmlstarlet select -N kml=http://www.opengis.net/kml/2.2 -T -t -v //kml:description - \
| w3m -T text/html -dump \
| awk '
    ($1 == "UTC" && "Hgt" in r) {print r["Lon"], r["Lat"], r["Hgt"], r["UTC"]}
    {r[$1] = substr($2,1,length($2)-1)}
'
