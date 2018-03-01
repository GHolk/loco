
install: ~/.local/share/applications/chrome-ophjlpahpchlmihnnnihgmmeilfjmjj-Default.desktop \
         /usr/share/applications/gholk-powertop.desktop

~/.local/share/applications/chrome-ophjlpahpchlmihnnnihgmmeilfjmjj-Default.desktop: chrome-ophjlpahpchlmihnnnihgmmeilfjmjjc-Default.desktop
	xdg-desktop-menu install $< ~/.local/share/desktop-directories/chrome-apps.directory

/usr/share/applications/gholk-powertop.desktop: gholk-powertop.desktop
	sudo xdg-desktop-menu install $<

.PHONY: install
