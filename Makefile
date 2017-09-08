
all: config # manual binary

define symbol_link  # (source name, destination path)
	ln -s "$(PWD)/$(1)" "$(2)"
endef

.PHONY: all config binary manual \
	bash tmux git manpath_file vim ssh

config: bash tmux git manpath_file vim ssh

bash: $(HOME)/.bashrc $(HOME)/.bash_profile
tmux: $(HOME)/.tmux.conf
git: $(HOME)/.gitconfig
manpath_file: $(HOME)/.manpath
vim: $(HOME)/.vimrc
ssh: $(HOME)/.ssh/config

$(HOME)/.ssh/config: ssh_config
	$(call symbol_link,$<,$@)

$(HOME)/.%: %
	$(call symbol_link,$<,$@)

supcj.gtab: supcj.cin
	gcin2tab supcj.cin
