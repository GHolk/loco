#!/usr/bin/env perl

use HTML::Parser() ;
use feature "switch";

my $flag_title = 0;

my $p = HTML::Parser->new
( 
	api_version => 3,
	start_h => [\&start, "tagname, attr"],
	text_h => [\&text, "text"],
	#end_h   => [\&end,   "tagname"],
	#marked_sections => 1,
);


sub start 
{
	my ($tagname, $attr) = @_ ;

	if ($tagname eq 'meta')
	{
		if ($attr->{name} eq 'author')
		{
			print "author: $attr->{content}\n";
		} 

		elsif ($attr->{name} eq 'date')
		{
			print "date: $attr->{content}\n";
		}

		elsif ($attr->{name} eq 'discription')
		{
			print "discription: $attr->{content}\n\n";
		}

	}

	elsif ($tagname eq 'title')
	{
		$flag_title = 1;
	}

}


sub text
{
	my $text = shift;

	if($flag_title == 1)
	{
		print "title: $text\n";
		$flag_title = 0;
	}

}


foreach my $file (@ARGV)
{
	print "file: $file\n";
	$p->parse_file($file);
}

exit


