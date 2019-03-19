#!/bin/sh

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
    grub-editenv - set gholk_reboot_date=$date
    grub-editenv - set gholk_reboot_hour=$hour
    grub-editenv - set gholk_reboot_entry=$next_entry
}

remove_entry_after_reboot() {
    # at will run expire job after reboot
    at now + 30 minutes <<AT
$0 unset
AT
}

if [ $next_entry = unset ]
then
    grub-editenv - unset gholk_reboot_date
    grub-editenv - unset gholk_reboot_hour
    grub-editenv - unset gholk_reboot_entry
else
    set_date_hour_entry $(date -u +"%e %k") $next_entry
    remove_entry_after_reboot
fi

