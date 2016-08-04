#!/usr/bin/env perl

use HTML::Parser() ;
use feature "switch";

my $p = HTML::Parser->new
( 
	api_version => 3,
	start_h => [\&start, "tagname, attr"],
	text_h => [\&text, "text"],
	end_h => [\&end,   "tagname"],
	#marked_sections => 1,
);


sub end
{
	my $tagname = shift;
	if($tagname eq 'p' && $flag{p} == 1){
		$flag{p} = 2 ;
	}
}

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
		$flag{title} = 1;
	}
	
	elsif ($tagname eq 'p' && $flag{p} == 0)
	{
		$flag{p} = 1;
	}

}


sub text
{
	my $text = shift;

	if($flag{title} == 1)
	{
		$meta{title} = $text;
		$flag{title} = 0;
	}elsif($flag{p} == 1)
	{
		$meta{p} .= $text;
	}


}

my $format;

foreach my $argv (@ARGV)
{

	if ($argv eq '-l') {
		$format = "list";
		next;
	} elsif ($argv eq '-w') {
		$format = "web";
		next;
	}

	local (%meta, %flag) ;
	$flag{title} = 0;
	$flag{p} = 0;

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

	} elsif ($format eq 'web'){

		print <<WEB;

<h2 title="$meta{discription}">
<a href="$file">
$meta{title}
</a></h2>

<small>
<u>$meta{author}</u>
@ $meta{date}
</small>

<p>
$meta{p}
</p>

<hr />

WEB

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


