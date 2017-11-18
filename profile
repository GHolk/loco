#!/bin/sh

export LANGUAGE="zh_TW:zh_CN:en"
export EDITOR=vi
export GOPATH=$HOME/.local/share/go
export PATH="$HOME/.local/bin:$PATH"
export INFOPATH=/usr/share/info:$HOME/.local/share/info

if [ -n "$SSH_AUTH_SOCK" ] && \
   ( gpgconf --list-options gpg-agent | \
        grep -q '^enable-ssh-support.*1$' )
then export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi


# config by ~/.manpath
# export MANPATH=:$HOME/.local/share/man

# no makefile now
# export MAKEFILES="$HOME/.Makefile"

if [ -n "$PS1" ] && [ -n "$BASH_VERSION" ]
then . $HOME/.bashrc
fi
