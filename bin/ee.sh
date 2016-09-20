#!/usr/bin/sh

if [ "$1" ] && [ ${#1} -lt 3 ]
then 
	case "$1" in
	( "%" ) 
		s="s/+/ /g; s/\\\\/\\\\x5C/g; s/%/\\\\x/g;" 
	;;

	( "&" ) 
		s="s/&lt;/</g; s/&gt;/>/g; s/&amp;/\&/g;"
	;;

	( "r&" )
		s="s/</\&lt;/g; s/>/\&gt;/g; s/&/\&amp;/g;"
	;;

	( "*" )
		s="s/\\*/\\\\e/g;"
	;;

	( * )
		s="s/\\\\/\\\\x5C/g; s/$1/\\\\x/g;" 
	;;

	esac
	
	shift
fi

if [ -f "$1" ]
then sed "$s" "$1" | xargs -0 echo -en
# this kind of code bash only. 
#then eval echo "$'$1'"
elif [ "$1" ]
then echo "$1" | sed "$s" | xargs -0 echo -en
else
sed "$s" | xargs -0 echo -en 
#else eval echo "$'$(sed \"$s\"
fi

