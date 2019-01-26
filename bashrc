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


alias rm='gio trash'
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

if [ -e .bash_function ]
then . ./.bash_function
fi
