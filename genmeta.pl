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
	if($tagname eq 'p' && $flag{t} == 1){
		$flag{t} = 2 ;
	} elsif ($tagname eq 'h1'){
		$meta{t} = "";
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

		elsif ($attr->{name} eq 'description')
		{
			$meta{description} = $attr->{content};
		}

	}

	elsif ($tagname eq 'title')
	{
		$flag{title} = 1;
	}
	
	elsif ($tagname eq 'main' && $flag{t} == 0)
	{
		$flag{t} = 1;
	}

}


sub text
{
	my $text = shift;

	if($flag{title} == 1)
	{
		$meta{title} = $text;
		$flag{title} = 0;
	}elsif($flag{t} == 1)
	{
		$meta{t} .= $text;
		if( length $meta{t} > 300 ) {
			$meta{t} = substr $meta{t}, 0, 300;
			$flag{t} = 2;
		}
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
	$flag{t} = 0;

	my $file = $argv;
	$p->parse_file($file);

	if ($format eq "list"){
		print <<LIST;

<li>
<a href="$file" title="$meta{description}">
$meta{title}
</a>
<small>$meta{date}</small>
</li>

LIST

	} elsif ($format eq 'web'){

		print <<WEB;

<h2 title="$meta{description}">
<a href="$file">
$meta{title}
</a></h2>

<small>
<u>$meta{author}</u>
@ $meta{date}
</small>

<p>
$meta{t}
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
$meta{description}
</p>

<hr />

SECT

	}

}

exit


