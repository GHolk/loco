#!/bin/sh
lon=$1
lat=$2
cat <<OCTAVE
d2r = @(d) deg2rad(d);
rx = @(x) [1, 0, 0; 0, cos(x), -sin(x); 0, sin(x), cos(x)];
ry = @(y) [cos(y), 0, sin(y); 0, 1, 0; -sin(y), 0, cos(y)];
rz = @(z) [cos(z), -sin(z), 0; sin(z), cos(z), 0; 0, 0, 1];
rll =  @(lon, lat) rx(d2r(lat))*rz(d2r(lon));
rm = rll($lon, $lat);

OCTAVE

awk '
/@/ { time = $7 }
(NF == 3) { m[$1,$2] = $3 }
($1 == 2 && $2 == 2) {
#print $0
print "res = transpose(rm) * ["
print m[0,0], m[0,1], m[0,2]
print m[0,1], m[1,1], m[1,2]
print m[0,2], m[1,2], m[2,2]
print "] * rm;"
print "res = res.^0.5;"
#printf "disp([%s res(2,2) res(3,3) res(1,1)]);", time
printf "printf(\"%d %%.5f %%.5f %%.5f\\n\", res(2,2), res(3,3), res(1,1));", time
}'
