.PHONY: all npm install

PREFIX = $(HOME)/.local

md2man = marked-man
md2man_flag = --manual='NCKU CCNS'

all: ncku-ip.7 html-char.7 ntu-ip.7 tanet.7 http.7

%.7: %.md
	$(md2man) -o $@ $(md2man_flag) $<
	sed -i '1i.mso zh.tmac' $@

html-char.7: html-char.md
	$(md2man) -o $@ $(md2man_flag) $<

http.7: rfc7231.7
	ln -s $< $@

install:
	for i in `seq 1 9`; \
	do \
		mkdir -p $(PREFIX)/share/man/man$$i; \
		for man in *.$$i; \
		do \
			cp --backup --no-dereference \
				$$man $(PREFIX)/share/man/man$$i; \
		done \
	done

npm:
	./link-npm-man
