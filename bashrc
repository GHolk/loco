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

# npm path #
export PATH="~/node_modules/.bin:$PATH"

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
