#!/usr/bin/env zsh
has_tpm() {
	[ -d "$HOME/.tmux/plugins/tpm" ]
}

install_tpm() {
	if ! has_tpm
	then
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	fi
	$HOME/.tmux/plugins/tpm/bin/install_plugins
}

has_tmux_powerline() {
	[ -d "$HOME/.tmux/tmux-powerline" ]
}

install_tmux_powerline() {
	if ! has_tmux-powerline
	then
		git clone https://github.com/erikw/tmux-powerline ~/.tmux/tmux-powerline
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

mkdir -p "$HOME/.tmux/segments"

for segment in tmux-mem-cpu-right
do
    if [ ! -f "$HOME/.tmux/segments/$segment.sh" ]
    then
        ln -s "${0:A:h:h}/tmux/$segment.sh" "$HOME/.tmux/segments/$segment.sh" >& /dev/null
    fi
done
