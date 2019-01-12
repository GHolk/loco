
t = ~/.local/bin

all: $t/xwall $t/xop $t/chromium-app \
     $t/clipboard $t/selection \
     $t/pactl-mute $t/pactl-unmute \
     $t/urlencode $t/flash-iso-recovery


$t/clipboard: aclp.sh
	ln -s `realpath $<` $@

$t/selection: aclp.sh
	ln -s `realpath $<` $@

$t/xwall: xwall.sh
	ln -s `realpath $<` $@

$t/xop: /usr/bin/xdg-open
	ln -s `realpath $<` $@

$t/chromium-app: chromium-app.sh
	ln -s `realpath $<` $@

$t/pactl-mute: pactl-mute.sh
	ln -s `realpath $<` $@
$t/pactl-unmute: pactl-mute.sh
	ln -s `realpath $<` $@

$t/urlencode: urlencode.js
	ln -s `realpath $<` $@
$t/umount-vg: umount-vg.sh
	ln -s `realpath $<` $@
$t/flash-iso-recovery: flash-iso-recovery.sh
	ln -s `realpath $<` $@

.PHONY: all
