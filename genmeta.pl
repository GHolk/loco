#!/usr/bin/env perl

use HTML::Parser() ;
use feature "switch";

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
			$meta{author} = $attr->{content};
		} 

		elsif ($attr->{name} eq 'date')
		{
			$meta{date} = $attr->{content};
		}

		elsif ($attr->{name} eq 'discription')
		{
			$meta{discription} = $attr->{content};
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
		$meta{title} = $text;
		$flag_title = 0;
	}

}

my $format;

foreach my $argv (@ARGV)
{

	my $flag_title = 0;
	local %meta ;


	if ($argv eq '-l') {
		$format = "list";
		next;
	}

	my $file = $argv;
	$p->parse_file($file);

	if ($format eq "list"){
		print <<LIST;

<li>
<a href="$file" title="$meta{discription}">
$meta{title}
</a>
<small>$meta{date}</small>
</li>

LIST

	} else {
		print <<SECT;

<h2>
<a href="$file">
$meta{title}
</a></h2>

<small>
<u>$meta{author}</u>
@
$meta{date}
</small>

<p>
$meta{discription}
</p>

<hr />

SECT

	}

}

exit


