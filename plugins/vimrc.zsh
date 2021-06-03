#!/usr/bin/env zsh

if [ ! -f "${HOME}/.vim/UltiSnips/spec.snippets" ]
then
	mkdir -p "$HOME/.vim/UltiSnips" >& /dev/null
	ln -s "${0:A:h:h}/spec.snippets" "$HOME/.vim/UltiSnips" >& /dev/null
fi
