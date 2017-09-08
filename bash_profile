#!/bin/bash

export LANGUAGE="zh_TW:zh_CN:en"
export HISTTIMEFORMAT="%F %T "
# export MAKEFILES="$HOME/.Makefile"
export EDITOR=vi
export GOPATH=$HOME/.local/share/go
export INFOPATH=/usr/share/info:$HOME/.local/share/info
export PATH="$HOME/.local/bin:$PATH"

if [ -z $NODE_PATH ]
then export NODE_PATH=/usr/local/lib/node_modules
fi