
t = ~/.local/bin
s = /usr/local/bin
i = install $(BACKUP) $< $@
c = cp $(BACKUP) $< $@
BACKUP ?= --backup

all: $t/xwall $t/xop $t/chromium-app \
     $t/clipboard $t/selection \
     $t/pactl-mute $t/pactl-unmute \
     $t/qemu-windows $t/qemu-android \
     $t/urlencode $t/flash-iso-recovery \
     $t/pcre $t/landslide-standalone $t/scat \
     $t/ansi-color $t/xmotd $t/ikill $t/memory-notify \
     $t/bluetooth-restart $t/ffmpeg-mv $t/utc-to-wn-dow \
     $t/udisksctld $t/gkill $t/adb-clipboard

$t/utc-to-wn-dow: utc-to-wn-dow.sh
	$i

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

$t/pcre: pcre.pl
	ln -s `realpath $<` $@

$t/landslide-standalone: landslide-standalone.sh
	ln -s `realpath $<` $@
$t/scat: scat.sh
	ln -s `realpath $<` $@

$t/qemu-%: qemu-%.sh
	ln -s `realpath $<` $@

/usr/local/sbin/grub-reboot-timeout: grub-reboot-timeout.sh
	install $< $@

/etc/init.d/zram: zram.sh
	install $< $@

/etc/cron.daily/ccca-wiki-backup: ccca-wiki-backup.sh
	$i

$t/google-drive-download: google-drive-download.sh
	install $< $@

$t/st: st.awk
	install $< $@
$t/xmotd: xmotd.sh
	install $< $@

$t/pause: pause.sh
	install $< $@

$t/ansi-color: ansi-color.sh
	install $< $@

$t/ikill: ikill.sh
	install $< $@

$t/memory-notify: memory-notify.sh
	install $< $@

$t/bluetooth-restart: bluetooth-restart.sh
	install $< $@

$t/ffmpeg-mv: ffmpeg-mv.sh
	install $< $@

/usr/local/lib/regular-poweron.sh: regular-poweron.sh
	$c

$t/udisksctld: udisksctld.sh
	$i

$t/gkill: gkill.sh
	$i

$t/adb-clipboard: adb-clipboard.sh
	$i

.PHONY: all
