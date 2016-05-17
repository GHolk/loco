# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias vi=vim
alias rm=gvfs-trash
alias octave="octave --no-gui"
alias mv="mv -i"
alias cp="cp -i"
alias manen="man -L en"

alias xm=xmms2

# add current dictionary into PATH
#PATH=".:$PATH"
myweb="myweb.ncku.edu.tw/~c34031328"
export LANGUAGE="zh_TW:zh_CN:en"
export HISTTIMEFORMAT="%F %T "

# npm path #
export PATH="~/node_modules/.bin:$PATH"


# too long option to remember. 
function pdfopt {
gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dQUIET \
	-dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen \
	-sOutputFile="$2" "$1"
}

# for convenient; translate escape charector
function ee {

	local s

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

		( * )
			s="s/\\\\/\\\\x5C/g; s/$1/\\\\x/g;" 
		;;

		esac
		
		shift
	fi

	if [ "$1" ]
	then echo "$1" | sed "$s" | xargs -0 echo -en
	# this kind of code bash only. 
	#then eval echo "$'$1'"
	else sed "$s" | xargs -0 echo -en 
	#else eval echo "$'$(sed \"$s\"
	fi

}

# color man page from arch wiki
#
#man() {
#    env LESS_TERMCAP_mb=$'\E[01;31m' \
#    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
#    LESS_TERMCAP_me=$'\E[0m' \
#    LESS_TERMCAP_se=$'\E[0m' \
#    LESS_TERMCAP_so=$'\E[38;5;246m' \
#    LESS_TERMCAP_ue=$'\E[0m' \
#    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
#    man "$@"
#}
