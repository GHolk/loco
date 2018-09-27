#!/bin/sh

vg=$1
lv=$(lvs --options lv_name --noheading $vg)
lvchange --activate n $lv
vgchange --activate n $vg

