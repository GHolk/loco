#!/usr/bin/env zsh
export PATH=/bin:/usr/bin:/usr/ucb:/usr/local/bin:/usr/sbin:/sbin:/etc:/usr/local/sbin
export PAGER=less
export TERM=vt100
export GREP_COLORS=auto
PS1="%{[32m%}%~:%{[33;1m%}%% %{[0m%}"


## change and option ##
alias mv="mv -i"
alias cp="cp -i"
alias manen="man -L en"
alias df="df -h"

alias ll="ls -l"
alias la="ls -a"



## convient ##
alias ap=apropos
alias .=source
alias ..="cd .. ; "
alias ...="cd - "


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
myweb="myweb.ncku.edu.tw/~c34031328"
diy="574730f77628e1670d000056@diy-locoescp.rhcloud.com"
export LANGUAGE="zh_TW:zh_CN:en"
export HISTTIMEFORMAT="%F %T "


