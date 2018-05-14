#!/usr/bin/env zsh


install_powerline_symbols() {
	if ! has_powerline_symbols
	then
		cd "$HOME/.local/share/fonts/"
		wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
		fc-cache -vf $(pwd)
		cd "$HOME/.config/fontconfig/conf.d/"
		wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
	fi
}

has_powerline_symbols() {
	[ -f "$HOME/.config/fontconfig/conf.d/10-powerline-symbols.conf" ]
}
