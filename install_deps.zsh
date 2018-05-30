#!/usr/bin/env zsh

if ! has_powerline_symbols
then
	revolver-loading 'Installing powerline fonts'
	install_powerline_symbols
fi
if [ ! -d ~/.vim/bundle/Vundle.vim ]
then
	revolver-loading 'Installing Vundle'
	vundle
fi
if ! has_mdv
then
	revolver-loading 'Installing mdv'
	install_mdv
fi
if ! has_tpm
then
	revolver-loading 'Installing tpm'
	install_tpm
fi

if ! has_tmux_powerline
then
	revolver-loading 'Installing tmux-powerline'
	install_tmux_powerline
fi


if zplug check zsh-users/zsh-autosuggestions; then
	ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
	ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
fi

_gen_rgrc "${0:A:h}/.rgrc"

if zplug check "plugins/history-substring-search"; then
	bindkey '^[OA' history-substring-search-up
	bindkey '^[OA' history-substring-search-down
fi
