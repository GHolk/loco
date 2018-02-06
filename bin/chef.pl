#!/usr/bin/env perl

use Acme::Chef;

my $chef_code = '';
while (<>) {
    $chef_code = $chef_code . $_;
}

my $chef = Acme::Chef->compile($chef_code);
print $chef->execute();

