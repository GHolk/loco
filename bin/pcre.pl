#!/usr/bin/env perl

my $string = $ARGV[0];
my $regexp = $ARGV[1];
my $modifier = $ARGV[2] || "";

if ($string =~ /(?$modifier)$regexp/) {
    print "$1\n";
    exit 0;
}
else {
    exit 1;
}
