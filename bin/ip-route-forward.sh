#!/bin/sh
local_net_range=$1
local_net_device=$2
local_net_ip=$3
inter_net_device=$4

# allow host access guest
ip address add $local_net_ip dev $local_net_device
ip route add $local_net_range via $local_net_ip

# allow guest access internet
sysctl sys.net.ipv4.conf.$local_net_device.forwarding=1
sysctl sys.net.ipv4.conf.$inter_net_device.forwarding=1
iptables -t nat -A POSTROUTING \
         -s $local_net_range \
         \! -d $local_net_range \
         -j MASQUERADE -o $inter_net_device
