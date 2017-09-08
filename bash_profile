#!/bin/bash

export LANGUAGE="zh_TW:zh_CN:en"
export HISTTIMEFORMAT="%F %T "
export EDITOR=vi
export GOPATH=$HOME/.local/share/go
export PATH="$HOME/.local/bin:$PATH"
export INFOPATH=/usr/share/info:$HOME/.local/share/info

# config by ~/.manpath
# export MANPATH=:$HOME/.local/share/man

# no makefile now
# export MAKEFILES="$HOME/.Makefile"

if [ -z $NODE_PATH ]
then export NODE_PATH=/usr/local/lib/node_modules
fi

if [ -n "$PS1" ]
then . $HOME/.bashrc
fi