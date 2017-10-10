#!/bin/bash

# If not running interactively, do not do anything
[[ $- != *i* ]] && return

PS1="\[\e[32m\]\w:\[\e[33;1m\]\$ \[\e[0m\]"

alias rm=gvfs-trash
alias mv="mv -i"
alias cp="cp -i"
alias men="man -L en"
alias df="df -h"
alias ll="ls -la"

alias octave="octave --no-gui"
# alias emacs="emacs -nw"
alias ec="emacsclient -nw -c"

alias xm=xmms2
alias ap=apropos
alias ..="cd .. ; "
alias ...="cd - "


alias grep="grep --color"
alias ls="ls -F --color=auto"

# set colorful output
if command -v dircolors >/dev/null
then eval `dircolors`
fi


myweb="myweb.ncku.edu.tw/~c34031328"
ncku="ncku.edu.tw"

mcd() { 
    mkdir $@
    cd $1
}

cls() {
    cd $1
    ls
}

err() {
    echo $* >&2
}

gvfs() {
    gvfs-$*
}

less-big5() {
    iconv -f big5 "$@" | less
}
