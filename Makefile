
.PHONY: all \
	config man bin \
	bash tmux git manpath_file vim ssh

all: config man ime # binary

define symbol_link  # (source name, destination path)
	ln -s "$(PWD)/$(1)" "$(2)"
endef

config: bash tmux git manpath_file vim ssh

bash: $(HOME)/.bashrc $(HOME)/.profile
tmux: $(HOME)/.tmux.conf
git: $(HOME)/.gitconfig
manpath_file: $(HOME)/.manpath
vim: $(HOME)/.vimrc
ssh: $(HOME)/.ssh/config

$(HOME)/.ssh/config: ssh_config
	$(call symbol_link,$<,$@)

$(HOME)/.%: %
	$(call symbol_link,$<,$@)

man: man/Makefile
	$(MAKE) -C $@

bin:
	$(MAKE) -C $@

ime: supcj.scim supcj-cn.scim
supcj.gtab: supcj.cin
	gcin2tab supcj.cin

supcj.scim: supcj.cin
	ex -S cin2scim.ex supcj.scim

supcj-cn.%: supcj.%
	sed -i '/BEGIN_TABLE/,$$d' $@
	sed -n '/BEGIN_TABLE/,$$p' $< | cconv -f UTF8-TW -t UTF8-CN >>$@ 

/etc/X11/xorg.conf.d/56evdev-trackpoint-gholk.conf: evdev-trackpoint-gholk.conf
	ln -s `realpath $<` $@

/etc/sudoers.d/gholk-csa-sudo-conf: gholk-csa-sudo-conf
	cp $< $@
	chmod 0440 $@
