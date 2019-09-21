#!/bin/sh

# make cursor stay at end of line
printf "press any key to continue"

stty raw -echo
head -c 1 >/dev/null
stty -raw echo

# make cursor move new line start
printf "\n"
