
md2man = marked-man

default: ncku-ip.7 html-char.7

ncku-ip.7: ncku-ip.md
	$(md2man) $(md2man_flag) --version=v3 --manual='Taiwan Collage' $< >$@

html-char.7: html-char.md
	$(md2man) $(md2man_flag) --version=v3 --manual='Cheat Sheet' $< >$@

