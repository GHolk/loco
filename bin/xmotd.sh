#!/bin/sh
# zenity is able to send notification too

notify-send --urgency=critical \
            --expire-time=60000 \
            motd \
            "$(run-parts --lsbsysinit /etc/update-motd.d; cat /etc/motd)"
