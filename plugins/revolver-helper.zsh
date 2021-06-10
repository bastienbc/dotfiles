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
