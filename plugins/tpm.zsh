#!/usr/bin/env zsh
BBC_REPOS_PATH=${0:A:h:h}

has_tpm() {
	[ -d "$HOME/.tmux/plugins/tpm" ]
}

install_tpm() {
	if ! has_tpm
	then
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	fi
	if [ ! -f "$HOME/.tmux.conf" ]
	then
		ln -s "$BBC_REPOS_PATH/.tmux.conf" "$HOME/.tmux.conf" >& /dev/null
	fi
	if [ ! -f "$HOME/.tmux-powerlinerc" ]
	then
		ln -s "$BBC_REPOS_PATH/.tmux-powerlinerc" "$HOME/.tmux-powerlinerc" >& /dev/null
	fi
}
