#!/usr/bin/env zsh


install_powerline_symbols() {
	if ! has_powerline_symbols
	then
		(
		[ ! -d "$HOME/.local/share/fonts/" ] && mkdir -p "$HOME/.local/share/fonts/"
		cd "$HOME/.local/share/fonts/"
		wget "https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf"
		wget "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.ttf"
		fc-cache -vf "$(pwd)"
		[ ! -d "$HOME/.config/fontconfig/conf.d/" ] && mkdir -p "$HOME/.config/fontconfig/conf.d/"
		cd "$HOME/.config/fontconfig/conf.d/"
		wget "https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf"
		wget "https://github.com/ryanoasis/nerd-fonts/raw/master/10-nerd-font-symbols.conf"
		xfconf-query -c xsettings -p /Gtk/FontName -s 'DejaVuSansMono Nerd Font Mono 10'
		)
	fi
}

has_powerline_symbols() {
	[ -f "$HOME/.config/fontconfig/conf.d/10-nerd-font-symbols.conf" ] && [ -f "$HOME/.local/share/fonts/DejaVu Sans Mono Nerd Font Complete Mono.ttf" ]
}
