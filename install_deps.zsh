#!/usr/bin/env zsh
export PATH=$PATH:$HOME/.local/bin

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

if ! has_xfce_theme
then
	revolver-loading 'Installing xfce theme'
	install_xfce_theme
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

if ! command -v chronic >& /dev/null ; then
	echo "chronic should be installed. Ususally moreutils package."
fi

if ! command -v cpan >& /dev/null || ! perl -MModule::Build -e 1 >& /dev/null ; then
	echo "Package to build perl module are missing. Needs cpan & Module::Build."
fi

if ! command -v cargo >& /dev/null ; then
	echo "Need cargo to build rust source"
fi

if ! command -v go >& /dev/null ; then
	echo "Need golang package to buil go source"
fi
