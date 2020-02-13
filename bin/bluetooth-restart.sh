#!/bin/sh
if type rfkill >/dev/null
then
    rfkill block bluetooth
    rfkill unblock bluetooth
else
    systemctl restart bluetooth
fi

