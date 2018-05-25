#!/usr/bin/env zsh

: ${REVOLVER_STARTED:=0}
revolver-loading() {
	if type revolver > /dev/null
	then
		if [ "$REVOLVER_STARTED" -eq 1 ]
		then
			revolver update "$@"
		else
			revolver --style dots start "$@"
			REVOLVER_STARTED=1
		fi
	else
		echo "$@"
	fi
}

revolver-loading-stop() {
	if type revolver > /dev/null && [ "$REVOLVER_STARTED" -eq 1 ]
	then
		revolver stop 2>&1 > /dev/null
		REVOLVER_STARTED=0
		echo
		printf '\e[1A\e[2K'
	fi
}

zplug-install-load () {
	# Install plugins if there are plugins that have not been installed
	revolver-loading 'Checking plugins'
	if type zplug >& /dev/null && ! zplug check --verbose; then
		revolver-loading-stop
		printf "Install? [y/N]: "
		if read -q; then
			echo; zplug install
		fi
	fi
	revolver-loading 'Loading plugins'
	zplug load
}

expand-or-complete-with-dots() {
	#echo -n "\e[31m...\e[0m"
	#printf '\e[s'
	echo
	revolver --style 'dots' start 'waiting'
	if ! zle menu-expand-word
	then
	#	printf '\e[2K\e[u'
		zle menu-complete-word
	fi

	revolver stop
	REVOLVER_STARTED=0
	echo
	zle redisplay
}

revolver-load-zplug() {
	if [ ! -d "$HOME/.zplug" ]
	then
		revolver-loading 'Install zplug'
		git clone https://github.com/zplug/zplug "$HOME/.zplug/repos/zplug/zplug"
		ln -s "$HOME/.zplug/repos/zplug/zplug/init.zsh" "$HOME/.zplug/init.zsh"
	elif [ -x $HOME/.zplug/repos/molovo/revolver/revolver ]
	then
		ln -fs $HOME/.zplug/repos/molovo/revolver/revolver $HOME/bin
	fi
	revolver-loading 'Source zplug'
	source ~/.zplug/init.zsh
}
