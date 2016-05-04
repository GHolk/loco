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

# add current dictionary into PATH
#PATH=".:$PATH"
myweb="myweb.ncku.edu.tw/~c34031328"
export LANGUAGE="zh_TW:zh_CN:en"


# febo with for. 
#
#function febo {
#
#sum=(0 1)
#i=0
#
#while [ $i -lt $1 ]
#do
#	if (( i % 2 ))
#	then
#		echo $(( sum[0] += sum[1] ))
#	else
#		echo $(( sum[1] += sum[0] ))
#	fi
#	((i++))
#done
#
#}


# horible febo with recursive cause crash. 
# indeed *fibo* ...
#
#febo(){
#
#i=$1
#(( j = i-1 , k = i-2 ))
#
#if (( i <= 1 )) 
#then 
#	echo 1
#else 
#	echo $(expr `febo $j` + `febo $k` )
#fi
#
#}

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
