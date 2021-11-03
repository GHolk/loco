#!/bin/sh
psparent="ps --no-headers -o ppid:1"

pid_xfce=$($psparent $$)
pid_xfce_child=$(pgrep --parent $pid_xfce | grep -v "^$$\$")

export pid_xfce pid_xfce_child psparent
nohup sh -c '
while ps "$pid_xfce" >/dev/null
do sleep 1
done

for pid in $pid_xfce_child
do
    if [ "$($psparent $pid)" -eq 1 ]
    then kill -s HUP $pid
    fi
done
' >>$HOME/.xsession-errors 2>&1 &
