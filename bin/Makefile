
t = ~/.local/bin

all: $t/clipboard $t/selection $t/xwall $t/xop $t/chromium-app

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

.PHONY: all
