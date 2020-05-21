
install: ~/.local/share/applications/chrome-ophjlpahpchlmihnnnihgmmeilfjmjj-Default.desktop \
         /usr/local/share/applications/gholk-powertop.desktop
	xdg-desktop-menu install --mode user \
		gholk-wifi-hotspot-restart.desktop \
		gholk-bluetooth-restart.desktop

~/.local/share/applications/chrome-ophjlpahpchlmihnnnihgmmeilfjmjj-Default.desktop: chrome-ophjlpahpchlmihnnnihgmmeilfjmjjc-Default.desktop
	xdg-desktop-menu install --mode user \
		~/.local/share/desktop-directories/chrome-apps.directory $<

/usr/local/share/applications/gholk-powertop.desktop: gholk-powertop.desktop
	xdg-desktop-menu install --mode system $<

.PHONY: install
