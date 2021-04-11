#!/bin/sh
login="$1"
shift
for path in "$@"
do
    curl -u "$login" -H "OCS-APIRequest: true" -X POST \
        https://nextcloud.gholk.ml/ocs/v2.php/apps/files_sharing/api/v1/shares \
        -d path="$path" -d shareType=3 \
    | xmlstarlet sel -t -m /ocs --if meta/statuscode=200 \
             -m data -v id -o " " -v token -o " " -v url --break \
             --else -c / --break \
             --nl
done

