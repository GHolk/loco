#!/bin/sh

export LANGUAGE="zh_TW:zh_CN:en"
export EDITOR=vi
export GOPATH=$HOME/.local/share/go
export PATH="$HOME/.local/bin:$PATH"
export INFOPATH=/usr/share/info:$HOME/.local/share/info
export _SOURCE_PROFILE=1

if tty -s
then
    export $(
        . /etc/X11/Xsession.d/90gpg-agent
        echo SSH_AUTH_SOCK=$SSH_AUTH_SOCK
        echo GPG_AGENT_INFO=$GPG_AGENT_INFO
    )
fi

# unset SSH_AGENT_PID
# unset GPG_AGENT


# config by ~/.manpath
# export MANPATH=:$HOME/.local/share/man

# no makefile now
# export MAKEFILES="$HOME/.Makefile"

if [ -n "$PS1" ] && [ -n "$BASH_VERSION" ]
then . $HOME/.bashrc
fi
