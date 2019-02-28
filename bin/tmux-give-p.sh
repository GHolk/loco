#!/bin/sh

set_if_empty() {
    local name value
    name=$1
    value="$2"
    if eval [ -z \"\$$name\" ]
    then
        eval $name='"$value"'
        return 0
    else
        return 1
    fi
}

get_pane() {
    tmux capture-pane -b current_pane
    tmux save-buffer -b current_pane -
}

ensure_give_menu() {
    tmux select-window -t $ptt_pane
    if get_pane | grep -q "(0)Give *給其他人Ptt幣"
    then
        tmux select-window -t $script_pane
       return 0
    else
        tmux select-window -t $script_pane
        clear
        cat <<GIVE_P_SCREEN
【Ｐtt量販店】                   批踢踢實業坊                                  


                    > (0)Give        給其他人Ptt幣
                      (1)ViolateLaw  繳罰單
                      (2)From        暫時修改故鄉
                      (3)OSong       心情點播機

[2/28 星期四 21:20]二二八紀念日   線上97496人, 我是gholk          [呼叫器]打開 


GIVE_P_SCREEN
        echo please go to this menu before run this script
        exit 2
    fi
}


send_wait() {
    tmux send-keys $*
    sleep 0.3s
}

send_password() {
    tmux paste-buffer -b ptt_password
    echo send password
    sleep 0.3s
}

request_password() {
    get_pane | fgrep -q '請輸入您的密碼:'
}

if [ -z "$TMUX" ]
then
    cat <<USAGE
using this script:

 1. open tmux
 2. run "ssh bbsu@ptt.cc" to login ptt in window 0
 3. you should run this script in window 1
 4. money=30 sh $0 iXXXXGAY5566 gholk ffaarr
USAGE
    exit 4
fi

set_if_empty ptt_pane 0
set_if_empty script_pane 1
set_if_empty user_interval 2

ensure_give_menu

set_if_empty money $1
[ -n "$1" ] && shift

if [ -z "$money" ]
then
    echo please input money
    read money
fi

if ! tmux save-buffer -b ptt_password - >/dev/null
then
    tmux command-prompt -p 'please input ptt password' \
         'set-buffer -b ptt_password "%1"'
    while ! tmux save-buffer -b ptt_password - >/dev/null 2>&1
    do sleep 1s
    done
fi



set_if_empty username_list "$*"
if [ -z "$username_list" ]
then
    echo please input username list
    echo each row contain one user
    username_list="`cat`"
fi


set -e

for username in $username_list
do
    sleep $user_interval
    
    tmux select-window -t $ptt_pane

    send_wait 0 Enter
    send_wait -l "$username"
    send_wait Enter
    send_wait $money Enter

    if request_password
    then
        send_password
    else
        send_wait y Enter
    fi

    send_wait Enter Enter

    tmux select-window -t $script_pane

    echo send $username finish
done

tmux delete-buffer -b ptt_password
tmux delete-buffer -b current_pane
echo finish all user
