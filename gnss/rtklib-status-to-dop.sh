#!/bin/sh
sed 's/\r//' | awk -F ': ' '
/valid satellite/ { satellite = $2 }
/receiver clock/ {
    time_string = time = $2
    gsub("[:/]", " ", time)
    time = substr(time, 1, 19)
    time = mktime(time)
}
/DOP/ { split($2, dop, ",")
    if (time_string !~ "-") {
        print time, satellite, dop[1], dop[2], dop[3], dop[4]
    }
}' 
