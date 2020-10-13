#!/bin/sh

year_start=$1
year_end=$2

for file in *.COR
do 
    awk -v name=$(basename $file .COR) -v OFS='\t' \
        '{print $3,$2,$4,$1,name}' $file
done |
    proj -f %.5f +init=epsg:3826 |
    awk -v OFS='\t' -v year_start=$year_start -v year_end=$year_end '
(year_start <= $4 && $4 <= year_end) {
    name = $5
    year = $4
    for (i=1; i<=3; i++) {
        station[name] = 1
        time[year] = 1
        point[name, year, i] = $(i)
    }
}

END {
    type[1]="east"; type[2]="north"; type[3]="height"

    printf "%s\t%s\t", "type", "year"
    for (name in station) printf "%s\t", name
    printf "\n"

    for (i in type) for (year in time) {
        printf "%s\t%s\t", type[i], year
        for (name in station) {
            if (point[name,year,i]) printf "%f", point[name,year,i]
            else printf "NaN"
            printf "\t"
        }
        printf "\n"
    }
}
' | sort -n
