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

for conf in .tmux.conf .tmux-powerlinerc
do
	if [ ! -f "$HOME/$conf" ]
	then
		ln -s "${0:A:h:h}/$conf" "$HOME/$conf" >& /dev/null
	fi
done

mkdir -p "$HOME/.tmux/themes"

for theme in short long
do
	if [ ! -f "$HOME/.tmux/themes/$theme.sh" ]
	then
		ln -s "${0:A:h:h}/tmux/$theme.sh" "$HOME/.tmux/themes/$theme.sh" >& /dev/null
	fi
done
