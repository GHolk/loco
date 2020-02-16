#!/bin/sh

check_upgrade_mail() {
    local upgrade_list
    if upgrade_list=$(aptitude search '~U')
    then echo "$upgrade_list" | mail -s 'apt upgrade available' root
    fi
}

check_upgrade_xmotd() {
    local upgrade_count
    upgrade_count=$(aptitude search '~U' | wc -l)
    if [ $upgrade_count -gt 0 ]
    then echo $upgrade_count package upgrade available
    fi
}
