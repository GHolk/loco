#!/bin/bash

# If not running interactively, do not do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi

PS1="\[\e[32m\]\w:\[\e[33;1m\]\$ \[\e[0m\]"

set completion-map-case On
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions


myweb="myweb.ncku.edu.tw/~c34031328"
ncku="ncku.edu.tw"
export \
    LANGUAGE="zh_TW:zh_CN:en" \
    HISTTIMEFORMAT="%F %T " \
    MAKEFILES="$HOME/.Makefile" \
    EDITOR=vi \
    PATH="$HOME/.local/bin:$PATH"

if [ -z $NODE_PATH ]
then export NODE_PATH=/usr/local/lib/node_modules
fi



## change and option ##
#alias vi=vim
alias rm=gvfs-trash
alias mv="mv -i"
alias cp="cp -i"
alias men="man -L en"
alias df="df -h"
alias ls="ls -CF --color=auto"
alias ll="ls -l"
alias telnet="telnet -E"

alias octave="octave --no-gui"
alias emacs="emacs -nw"

export GREP_COLORS=auto


## convient ##
alias xm=xmms2
alias ap=apropos
alias ..="cd .. ; "
alias ...="cd - "


mcd() { 
    mkdir $@
    cd $1
}

cls() {
    cd $1
    ls
}


# too long option to remember. 
pdfopt() {
gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dQUIET \
    -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen \
    -sOutputFile="$2" "$1"
}

clp() {
    echo -ne "\n\n********\n\n"
    cat
}

err() {
    echo $* >&2
}

gvfs() {
    gvfs-$*
}
