#!/usr/bin/env zsh

install_xfce_theme() {
	if ! has_xfce_theme
	then
		[ ! -d "$HOME/.local/share/themes" ] && mkdir -p "$HOME/.local/share/themes"
		(
			local REPO="$HOME/.local/repo/solarized-dark-xfce"
			[ ! -d "$REPO" ] && mkdir -p "$REPO"
			git clone https://github.com/mzgnr/solarized-dark-xfce.git "$REPO" >& /dev/null
			ln -fs "$REPO/xfce-theme/Numix Solarized" "$HOME/.local/share/themes/Numix Solarized"
			[ ! -d "$HOME/.config/xfce4/terminal" ] && mkdir -p "$HOME/.config/xfce4/terminal"
			ln -fs "$REPO/xfce-terminal/terminalrc" "$HOME/.config/xfce4/terminal/terminalrc"
            xfconf-query -c xfwm4 -p /general/theme -s "Numix Solarized"
		)
	fi
}

has_xfce_theme() {
	[ -d "$HOME/.local/share/themes/Numix Solarized" ] \
		&& [ -f "$HOME/.config/xfce4/terminal/terminalrc" ]
}
