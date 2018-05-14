#!/usr/bin/env zsh

if [ ! -f "${HOME}/.Xresources" ]
then
	ln -s "${0:A:h:h}/.Xresources" "$HOME/.Xresources" >& /dev/null
fi

if [ ! -f "${HOME}/.xinitrc" ]
then
	ln -s "${0:A:h:h}/.xinitrc" "$HOME/.xinitrc" >& /dev/null
elif ! grep FROMBBCPLUGIN "$HOME/.xinitrc" >& /dev/null
then
	tail -n 1 "${0:A:h:h}/.xinitrc"  >> "$HOME/.xinitrc"
fi

