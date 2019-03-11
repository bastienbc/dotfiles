#!/usr/bin/env zsh

zstyle ':vcs_info:git*+set-message:*' hooks getGitTag

function +vi-getGitTag() {
    hook_com[branch]=$'\ue725'" ${hook_com[branch]}"
	local tag
	tag="$(git describe --tags --exact-match 2> /dev/null)"
	if [ $? -eq 0 ]; then
		hook_com[branch]=$(echo "${hook_com[branch]}${tag:+ \uf73e ${tag}}")
	else
		local sha
		sha="$(git rev-parse --verify --short HEAD 2> /dev/null)"
		if [ $? -eq 0 ]; then
			hook_com[branch]=$(echo "${hook_com[branch]}${sha:+ \ue729 ${sha}}")
		fi
	fi
	local stash
	stash="$(git stash list -q 2> /dev/null)"
	if [ -n "$stash" ]
	then
		hook_com[branch]="${hook_com[branch]} $(wc -l <<< "$stash") "$'\ue78f'
	fi

	local local_changes
	local_changes="$(git rev-list @ '^@{upstream}' 2> /dev/null)"
	if [ $? -eq 0 ]; then
		local nb_changes="$(sed '/^\s*$/d' <<< "$local_changes" | wc -l)"
		[ "$nb_changes" -ne 0 ] && hook_com[branch]="${hook_com[branch]} $nb_changes"$'\uf077'
	else
		hook_com[branch]="${hook_com[branch]} "$'\uf127'
	fi
	hook_com[branch]="${hook_com[branch]} "
}

prompt_pure_get_k8s_info() {
	local RET_CODE=$?
	local K8S_CURRENT="$(kubectl config current-context)"
	local K8S_CONTEXT="$(kubectl config get-contexts "${K8S_CURRENT}")"
	local K8S_SERVER="$(awk '{print $3;}' <<< "${K8S_CONTEXT}" | sed '1d;s|^.*/||g')"
	local K8S_NAMESPACE="$(awk 'FNR == 2 { print $5; }' <<< "${K8S_CONTEXT}")"
	echo -n "%F{blue}\ufcb4 [${K8S_CURRENT}/%F{103}${K8S_SERVER}%F{blue}/%F{69}${K8S_NAMESPACE}%F{blue}]%f"
	return $RET_CODE
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
PROMPT='%(1j.[%j '$'\uf04c''] .)'
if [ -z "$NO_KUBE_PROMPT" ]; then
	PROMPT+='$(prompt_pure_get_k8s_info) '
fi
PROMPT+='%(12V.%F{242}%12v${PURE_PROMPT_SYMBOL:-❯}%f .)'
PROMPT+='%(?.%F{cyan}.%F{red}${PURE_PROMPT_SYMBOL:-❯} $? %F{cyan})'
PROMPT+='${PURE_PROMPT_SYMBOL:-❯}%f '
