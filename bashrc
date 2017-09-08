#!/bin/bash

# If not running interactively, do not do anything
[[ $- != *i* ]] && return

PS1="\[\e[32m\]\w:\[\e[33;1m\]\$ \[\e[0m\]"

# ignore case, not distinct `_` `-`
set completion-ignore-case On
set completion-map-case On


myweb="myweb.ncku.edu.tw/~c34031328"
ncku="ncku.edu.tw"

alias rm=gvfs-trash
alias mv="mv -i"
alias cp="cp -i"
alias men="man -L en"
alias df="df -h"
alias ls="ls -F"
alias ll="ls -la"

alias octave="octave --no-gui"
alias emacs="emacs -nw"

alias xm=xmms2
alias ap=apropos
alias ..="cd .. ; "
alias ...="cd - "

# set colorful output
GREP_COLORS=auto
if command -v dircolors
then eval `dircolors`
fi


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
