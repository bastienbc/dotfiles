#!/usr/bin/env zsh

install_xfce_theme() {
	local REPO="$HOME/.local/repo/solarized-dark-xfce"
	if ! has_xfce_theme
	then
		(
			[ ! -d "$REPO" ] && mkdir -p "$REPO"
			git clone https://github.com/mzgnr/solarized-dark-xfce.git "$REPO"
			[ ! -d "$HOME/.local/share/themes" ] && mkdir -p "$HOME/.local/share/themes"
			ln -fs "$REPO/xfce-theme/Numix Solarized" "$HOME/.local/share/themes/Numix Solarized"
			[ ! -d "$HOME/.config/xfce4/terminal" ] && mkdir -p "$HOME/.config/xfce4/terminal"
			ln -fs "$REPO/xfce-terminal/terminalrc" "$HOME/.config/xfce4/terminal/terminalrc"
			xfconf-query -c xsettings -p /Net/ThemeName -s "Numix Solarized"
            xfconf-query -c xfwm4 -p /general/theme -s "Numix Solarized"
		)
	fi
}

has_xfce_theme() {
	local REPO="$HOME/.local/repo/solarized-dark-xfce"
	git -C "$REPO" fetch >& /dev/null
	[ -d "$REPO" ] && ( [ "$(git -C "$REPO" rev-parse HEAD)" = "$(git -C "$REPO" rev-parse @{u})" ] || git -C "$REPO" pull --rebase )
	[ -d "$HOME/.local/share/themes/Numix Solarized" ] && [ -f "$HOME/.config/xfce4/terminal/terminalrc" ]
}
