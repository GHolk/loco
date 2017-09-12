
md2man = marked-man
md2man_flag = --manual='NCKU CCNS'

all: ncku-ip.7 html-char.7 ntu-ip.7

%.7: %.md Makefile
	$(md2man) -o $@ $(md2man_flag) $<

npm:
	./link-npm-man
