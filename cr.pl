#!/usr/bin/env perl
# transfer row and column. 

use utf8;

my @rows = <>;
my @cols;

for ($i=0; $i<$#rows; $i++)
{
	my @tmp=split //,$rows[$i];
	$cols[$i]=\@tmp;
}

for ($i=0; $i<30; $i++)
{
	foreach $col (@cols)
	{
		print $$col[$i] ;
	}
	print "\n";
}

