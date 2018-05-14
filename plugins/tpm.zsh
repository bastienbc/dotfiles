#!/usr/bin/env zsh
has_tpm() {
	[ -d "$HOME/.tmux/plugins/tpm" ]
}

install_tpm() {
	if ! has_tpm
	then
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	fi
}
if [ ! -f "$HOME/.tmux.conf" ]
then
	ln -s "${0:A:h:h}/.tmux.conf" "$HOME/.tmux.conf" >& /dev/null
fi
if [ ! -f "$HOME/.tmux-powerlinerc" ]
then
	ln -s "${0:A:h:h}/.tmux-powerlinerc" "$HOME/.tmux-powerlinerc" >& /dev/null
fi
