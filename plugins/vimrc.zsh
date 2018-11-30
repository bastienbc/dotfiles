#!/usr/bin/env zsh

if [ ! -f "${HOME}/.vimrc" ]
then
	ln -s "${0:A:h:h}/.vimrc" "$HOME/.vimrc" >& /dev/null
fi

if [ ! -f "${HOME}/.vim/UltiSnips/spec.snippets" ]
then
	mkdir -p "$HOME/.vim/UltiSnips" >& /dev/null
	ln -s "${0:A:h:h}/spec.snippets" "$HOME/.vim/UltiSnips" >& /dev/null
fi
