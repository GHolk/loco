#!/usr/bin/env perl

use strict;
use warnings;

sub read_u32 {
    my $file = shift;
    return read_pack($file, "L", 4);
}

sub read_string {
    my $file = shift;
    my $length = shift;
    return read_pack($file, "a$length", $length);
}

sub read_pack {
    my ($file, $template, $length) = @_;
    my $byte;
    read $file, $byte, $length;
    return unpack $template, $byte;
}

sub read_header {
    my $file = shift;
    my $info = {};
    $info->{version} = read_string $file, 60;
    $info->{init_tick} = read_u32 $file;
    $info->{init_time_integer} = read_pack($file, "Q", 8);
    $info->{init_time_float} = read_pack($file, "d", 16);
    return $info;
}

my $file = \*STDIN;
my $info = read_header $file;

print $info->{version}, "\n";
print $info->{init_tick}, "\n";
print $info->{init_time_integer}, "\n";
print $info->{init_time_float}, "\n";
