#!/usr/bin/env zsh

if [ ! -f "${HOME}/.vimrc" ]
then
	ln -s "${0:A:h:h}/.vimrc" "$HOME/.vimrc" >& /dev/null
fi
