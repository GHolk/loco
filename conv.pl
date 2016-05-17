#!/usr/bin/perl

# byte order:		big-endian
# header format
#
# 0x00 - 0x0c		"ScreenI2UTF8\0"
# 0x0d			encoding (Big5 is 0x18)
# 0x0e - 0x0f		table size
# 0x10 -		encoding name (end with padding '\0')

$header = "ScreenI2UTF8\x00\x18\x00\x00BIG 5\x00";

while (<STDIN>) {
	next if /^\s*#/ || /^\s*$/ ;
	
	($f, $t, $other) = split;
	next if hex($t)>=0x10000;
	$size += 1;
	$mapping .= pack("nn", hex($f) & 0x7fff, hex($t));
}
substr($header, 14, 2, pack("n", $size));

print $header , $mapping;
