#!/bin/sh
# zenity is able to send notification too

message_box_width=50
run_and_cat_motd() {
    run-parts --lsbsysinit /etc/update-motd.d
    cat /etc/motd
}

notify-send --urgency=critical \
            --expire-time=60000 \
            motd \
            "$(run_and_cat_motd | fmt -w $message_box_width)"
