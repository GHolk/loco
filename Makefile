
all: bash tmux git manpath vim ssh

define symbol_link  # (source name, destination path)
	ln -s "$(PWD)/$(1)" "$(2)"
endef

supcj.gtab: supcj.cin
	gcin2tab supcj.cin

bash: $(HOME)/.bashrc $(HOME)/.bash_profile
tmux: $(HOME)/.tmux.conf
git: $(HOME)/.gitconfig
manpath: $(HOME)/.manpath
vim: $(HOME)/.vimrc
ssh: $(HOME)/.ssh/config

$(HOME)/.ssh/config: ssh_config
	$(call symbol_link,$<,$@)

$(HOME)/.%: %
	$(call symbol_link,$<,$@)

.PHONY: bash tmux git man ssh
