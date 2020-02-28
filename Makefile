
.PHONY: all \
	config man bin \
	bash tmux git manpath_file vim ssh \
	cron install-gnss \
	octave test \
	install-man

c = cp $(BACKUP) $< $@
cf = cp $< $@
i = install $(BACKUP) $< $@
BACKUP = --backup

XDG_CONFIG_HOME ?= $(HOME)/.config

all: config bin # man

config: bash tmux git vim ssh

bash: $(HOME)/.bashrc $(HOME)/.profile $(HOME)/.bash_function $(HOME)/.inputrc
tmux: $(HOME)/.tmux.conf
git: $(XDG_CONFIG_HOME)/git/config $(XDG_CONFIG_HOME)/git/ignore
vim: $(HOME)/.vimrc
ssh: $(HOME)/.ssh/config
octave: $(HOME)/.octaverc

$(XDG_CONFIG_HOME)/git/%: git%
	mkdir -p `dirname $@`
	$c

$(HOME)/.octaverc: octave/octaverc
	$c

$(HOME)/.ssh/config: ssh_config
	$c

$(HOME)/.%: %
	$c

man: man/Makefile $(HOME)/.manpath
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

/etc/X11/xorg.conf.d/56-evdev-trackpoint-gholk.conf: evdev-trackpoint-gholk.conf
	$(cf)

/etc/sudoers.d/gholk-csa-sudo-conf: gholk-csa-sudo-conf
	cp $< $@
	chmod 0440 $@

$(HOME)/.local/share/anacron/anacrontab: anacrontab
	$c

/etc/sysctl.d/local.conf: local-sysctl.conf
	$c

/etc/X11/xorg.conf.d/20-intel-tearfree.conf: intel-tearfree.conf
	$(cf)

cron: crontab
	crontab < $<

install-gnss:
	cd gnss; \
	for script in *; \
	do \
	case $$script in \
	bashrc.sh) cp $$script $(HOME)/.local/bin/gnss-rc ;; \
	*) install $$script \
	$(HOME)/.local/bin/$$(echo $$script | sed -r 's/\..*?$$//') ;; \
	esac; \
	done

install-man:
	$(MAKE) -C man install
