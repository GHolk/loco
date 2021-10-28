#!/bin/bash

# If not running interactively, do not do anything
[ -z $_SOURCE_PROFILE ] && . $HOME/.profile
[[ $- != *i* ]] && return

[ -f /etc/bashrc ] && . /etc/bashrc # centos
[ -f /etc/bash.bashrc ] && . /etc/bash.bashrc # ubuntu

export GPG_TTY=$(tty)
# gpg-connect-agent updatestartuptty /bye >/dev/null

PS1_hostname="\[\e[36;1m\]\H\[\e[0m\]"
PS1_alert_exit_status="\[\e[1;31m\]\$(PS1_alert_exit_status)\[\e[0m\]"
PS1="\
$PS1_alert_exit_status\
\[\e[32m\]\w \[\e[33;1m\]\$ \[\e[0m\]"

## alert if exit value not zero
## alert only once by check history
PROMPT_COMMAND=PROMPT_COMMAND
PROMPT_COMMAND() {
    local last_command="$(history 1)"
    if [ "$last_command" = "$PROMPT_COMMAND_previous_command" ]
    then PROMPT_COMMAND_empty_command=t
    else
        PROMPT_COMMAND_empty_command=
        PROMPT_COMMAND_previous_command="$last_command"
    fi
}
PS1_alert_exit_status() {
    local status=$?
    if [ $status -ne 0 ] && [ -z $PROMPT_COMMAND_empty_command ]
    then echo "&$status "
    fi
}

# bash history control
HISTTIMEFORMAT="%F %T "
HISTSIZE=1000
HISTFILESIZE=1000
HISTCONTROL='ignorespace' # space leading command will not store
shopt -s lithist cmdhist # enable history store multi line
shopt -s histappend

# if histfile broken, fix it.
if [ "$(head -c 1 $HISTFILE)" != '#' ]
then sed -i -r '0,/^#[0-9]{10}$/{ /^#[0-9]{10}$/!d }' $HISTFILE
fi

shopt -s checkwinsize
shopt -s globstar  # dobule star ** match attributial depth dir

# friend less
eval "$(SHELL=/bin/sh lesspipe)"
export LESS="--no-init --ignore-case"


alias rm='gio trash'
alias rrm='command rm -r'
alias gcat='gio cat'
alias mv="mv -i"
alias cp="cp -i"
alias men="man -L en"
alias df="df -h"
alias ll="ls -la"

alias ps='ps -Fww'
alias pgrep='pgrep --list-full --full --ignore-case'
alias pstree='pstree --show-pids'
alias pwgen='pwgen --secure --symbols --numerals --capitalize'
alias diff='diff --color --unified'
alias nfe='numfmt --to iec-i'

alias octave=octave-cli
alias ec="emacsclient --tty --create-frame"
alias userctl="systemctl --user"
alias qrutf8='qrencode --type=UTF8'
alias cj='grep ~/loco/supcj.cin -e'
alias xml=xmlstarlet

# not check ssh public key. f is `-f` meaning force and no ask.
alias sshf='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias sshpw='ssh -o PreferredAuthentications=password'
alias sshp='ssh -p'
alias sshfw='ssh -N \
    -o ExitOnForwardFailure=yes -o ServerAliveInterval=5 -o GatewayPorts=yes'
alias sftpp='sftp -P'
alias ssh-key-lookup='ssh-keygen -F'
alias ssh-key-remove='ssh-keygen -R'

alias ccns-pass='env PASSWORD_STORE_DIR=$HOME/.password-store/ccns pass'

alias vin='vi -n'

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

if type complete _command fx >/dev/null 2>&1
then complete -F _command fx
fi
if type complete sudo nfdo >/dev/null 2>&1
then complete -F _sudo nfdo
fi

