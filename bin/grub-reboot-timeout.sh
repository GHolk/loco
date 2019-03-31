#!/bin/sh

set -e

grub_reboot_env_script='
#!/bin/sh
exec tail -n +3 "$0"
if [ -n "$gholk_reboot_entry" ]
then
    insmod datehook
    if [ "$DAY" -eq "$gholk_reboot_date" -a \
         "$HOUR" -eq "$gholk_reboot_hour" ]
    then set default=$gholk_reboot_entry
    fi
fi
'

if ! [ -f /etc/grub.d/*_reboot_env_timeout ]
then
    cat <<WARN_GRUB
you should check environment in grub script
to reboot to specific entry.

for example, put this as /etc/grub.d/42_reboot_env_timeout,
then run update-grub:

#############################################
$grub_reboot_env_script
#############################################

WARN_GRUB
fi

if [ -n "$1" ]
then next_entry=$1
else 
    cat <<EXIT
usage
    $0 1
    # set grub boot entry to 1 in this hour
EXIT
    exit 22
fi


set_date_hour_entry() {
    date=$1
    hour=$2
    entry=$3
    grub-editenv - set gholk_reboot_date=$date \
                       gholk_reboot_hour=$hour \
                       gholk_reboot_entry=$next_entry
}

remove_entry_after_reboot() {
    # at will run expire job after reboot
    at now + 30 minutes <<AT
$0 unset
AT
}

if [ $next_entry = unset ]
then
    grub-editenv - unset gholk_reboot_date \
                         gholk_reboot_hour \
                         gholk_reboot_entry
else
    set_date_hour_entry $(date -u +"%e %k") $next_entry
    remove_entry_after_reboot
fi

