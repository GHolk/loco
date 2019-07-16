
.PHONY: all \
	config man bin \
	bash tmux git manpath_file vim ssh \
        cron

all: config man ime # binary

define symbol_link  # (source name, destination path)
	ln -s "$(PWD)/$(1)" "$(2)"
endef

config: bash tmux git manpath_file vim ssh

bash: $(HOME)/.bashrc $(HOME)/.profile $(HOME)/.bash_function
tmux: $(HOME)/.tmux.conf
git: $(HOME)/.gitconfig
manpath_file: $(HOME)/.manpath
vim: $(HOME)/.vimrc
ssh: $(HOME)/.ssh/config

$(HOME)/.ssh/config: ssh_config
	cp $< $@

$(HOME)/.%: %
	cp $< $@

man: man/Makefile
	$(MAKE) -C $@

bin:
	$(MAKE) -C $@

ime: supcj.scim supcj-cn.scim
supcj.gtab: supcj.cin
	gcin2tab supcj.cin

supcj.scim: supcj.cin
	sh $@.sh >$@

supcj-cn.scim: supcj.scim
	sh $@.sh >$@

/etc/X11/xorg.conf.d/56evdev-trackpoint-gholk.conf: evdev-trackpoint-gholk.conf
	ln -s `realpath $<` $@

/etc/sudoers.d/gholk-csa-sudo-conf: gholk-csa-sudo-conf
	cp $< $@
	chmod 0440 $@

$(HOME)/.local/share/anacron/anacrontab: anacrontab
	ln -s `realpath $<` $@

/etc/sysctl.d/local.conf: local-sysctl.conf
	cp $< $@

cron: crontab
	crontab < $<

