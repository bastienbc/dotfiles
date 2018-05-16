#!/usr/bin/env zsh

zstyle ':vcs_info:git*+set-message:*' hooks getGitTag

function +vi-getGitTag() {
	local tag
	tag="$(git describe --tags 2> /dev/null)"
	if [ $? -eq 0 ]; then
		hook_com[branch]="${hook_com[branch]}${tag:+ <${tag}>}"
	fi
}

prompt_pure_update_vim_prompt() {
	zle || {
		print "error: pure_update_vim_prompt must be called when zle is active"
		return 1
	}
	local VNMODE='%F{magenta}[NORMAL]'
	VIM_PROMPT="${${KEYMAP/vicmd/$VNMODE}/(main|viins)/}"
	zle reset-prompt
	zle -R
}

function zle-line-init zle-keymap-select {
	prompt_pure_update_vim_prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

#prompt_newline='%666v'
RPROMPT='%F{white}%*'
prompt_newline='${VIM_PROMPT:+ $VIM_PROMPT }'$'\n%{\r%}'
PROMPT='%(1j.[%j] .)'
PROMPT+='%(12V.%F{242}%12v${PURE_PROMPT_SYMBOL:-❯}%f .)'
PROMPT+='%(?.%F{cyan}.%F{red}${PURE_PROMPT_SYMBOL:-❯} $? %F{cyan})'
PROMPT+='${PURE_PROMPT_SYMBOL:-❯}%f '
