#!/usr/bin/env perl

use HTML::Parser() ;
use feature "switch";

my $p = HTML::Parser->new( api_version => 3,
	start_h => [\&start, "tagname, attr"],
	#end_h   => [\&end,   "tagname"],
	#marked_sections => 1,
);

$p->parse_file("ncku-id.html");

sub start 
{
	my ($tagname, $attr) = @_ ;

	given($tagname)
	{
		when( 'meta')
		{
		given($attr->{name})
		{
			when( 'author')
			{
			print "author: $attr->{content}\n";
			}

			when( 'date')
			{
			print "date: $attr->{content}\n";
			}
		}
		}
	}

}

exit
