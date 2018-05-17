#!/usr/bin/env zsh


install_powerline_symbols() {
	if ! has_powerline_symbols
	then
		(
		cd "$HOME/.local/share/fonts/"
		wget "https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf"
		wget "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.ttf"
		fc-cache -vf $(pwd)
		cd "$HOME/.config/fontconfig/conf.d/"
		wget "https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf"
		wget "https://github.com/ryanoasis/nerd-fonts/raw/master/10-nerd-font-symbols.conf"
		)
	fi
}

has_powerline_symbols() {
	[ -f "$HOME/.config/fontconfig/conf.d/10-nerd-font-symbols.conf" ]
}
