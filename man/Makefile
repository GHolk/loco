
md2man = marked-man
md2man_flag = --manual='NCKU CCNS'

all: ncku-ip.7 html-char.7 ntu-ip.7 tanet.7

%.7: %.md
	$(md2man) -o $@ $(md2man_flag) $<
	sed -i '1i.mso zh.tmac' $@

html-char.7: html-char.md
	$(md2man) -o $@ $(md2man_flag) $<

npm:
	./link-npm-man
