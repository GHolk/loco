# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

## change and option ##
alias vi=vim
alias rm=gvfs-trash
alias octave="octave --no-gui"
alias mv="mv -i"
alias cp="cp -i"
alias manen="man -L en"
alias df="df -h"
export GREP_COLORS=auto

## convient ##
alias xm=xmms2
alias ap=apropos
alias ..="cd .. ; "
alias ...="cd - "
alias ptt="ssh bbsu@ptt.cc" # to input ENTER


function mcd 
{ 
	mkdir $@
	cd $1
}

function cls
{
	cd $1
	ls
}


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

