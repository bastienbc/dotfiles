#!/usr/bin/env zsh

prompt_pure_update_vim_prompt() {
	zle || {
		print "error: pure_update_vim_prompt must be called when zle is active"
		return 1
	}
	local VNMODE='%F{magenta}[NORMAL]'
	local VIMODE='%F{yellow}[INSERT]'
	echo "$(date): $KEYMAP" >> /tmp/keymap_used
	VIM_PROMPT="${${KEYMAP/vicmd/$VNMODE}/(main|viins)/$VIMODE}"
	zle reset-prompt
	zle -R
}

function zle-line-init zle-keymap-select {
	prompt_pure_update_vim_prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

#prompt_newline='%666v'
RPROMPT='${VIM_PROMPT} %F{white}%*'
PROMPT='%(1j.[%j] .)'
PROMPT+='%(12V.%F{242}%12v${PURE_PROMPT_SYMBOL:-❯}%f .)'
PROMPT+='%(?.%F{cyan}.%F{red}${PURE_PROMPT_SYMBOL:-❯} $? %F{cyan})'
PROMPT+='${PURE_PROMPT_SYMBOL:-❯}%f '
