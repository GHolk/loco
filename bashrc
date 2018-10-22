#!/bin/bash

# If not running interactively, do not do anything
[[ $- != *i* ]] && return

export GPG_TTY=$(tty)
# gpg-connect-agent updatestartuptty /bye >/dev/null

PS1="\[\e[36;1m\]\H\[\e[0m\]:\[\e[32m\]\w:\[\e[33;1m\]\$ \[\e[0m\]"

# bash history control
HISTTIMEFORMAT="%F %T "
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize
shopt -s globstar  # dobule star ** match attributial depth dir

# friend less
eval "$(SHELL=/bin/sh lesspipe)"


alias rm=gvfs-trash
alias mv="mv -i"
alias cp="cp -i"
alias men="man -L en"
alias df="df -h"
alias ll="ls -la"

alias octave=octave-cli
alias ec="emacsclient -nw -c"
alias userctl="systemctl --user"

alias xm=xmms2
alias ap=apropos
alias ..="cd .. ; "
alias ...="cd - "


alias grep="grep --color"
alias egrep="egrep --color"
alias fgrep="fgrep --color"
alias ls="ls -F --color=auto"

# set colorful output
eval `dircolors`


ncku="ncku.edu.tw"

# function
## chain command
mcd() { 
    mkdir $@
    cd $1
}

cls() {
    cd $1
    ls
}

err() {
    echo "$@" >&2
}

gvfs() {
    gvfs-$*
}

## change and execute command
big5() {
    luit -encoding big5 "$@"
}
value() {
    local exit_state
    case "$1" in
        -q )
            shift
            eval quiet "$@"
            ;;
        -Q )
            shift
            eval quiet -Q "$@"
            ;;
        * )
            eval "$@"
            ;;
    esac
    exit_state=$?
    echo $exit_state
    return $exit_state
}
quiet() {
    if [ "$1" = -Q ]
    then
        shift
        eval "$@" >/dev/null 2>&1
    else
        eval "$@" >/dev/null
    fi
}
