#!/usr/bin/env zsh

if [ ! -f "${HOME}/.peco/config.json" ]
then
	if [ ! -d "${HOME}/.peco" ]
	then
		ln -s "${0:A:h:h}/.peco" "${HOME}/.peco" >& /dev/null
	else
		ln -s "${0:A:h:h}/.peco/config.json" "${HOME}/.peco/config.json" >& /dev/null
	fi
fi

if [ ! -f "${HOME}/.local/bin/pip" ]
then
	curl https://bootstrap.pypa.io/get-pip.py | python3 - --user
fi

function _gen_rgrc () {
	local rgrc_content
	rgrc_content="${(Xe)"$( < $1 )"}"
	if [ -n "$(diff <(echo "${rgrc_content}") $HOME/.rgrc 2>/dev/null)" ]; then
		cat <<< "${rgrc_content}" > $HOME/.rgrc
	fi
}

if [ ! -f "${HOME}/.rgignore" ]
then
	ln -s "${0:A:h:h}/.rgignore" "${HOME}/.rgignore" >& /dev/null
fi

function vimin () {
	xargs -0 sh -c 'vim '"$@"' "$@" < /dev/tty' vim
}

function vimg () {
	local RG_FILES
	IFS=$'\n' RG_FILES=($(rg -l -0 "$@" | fzf${TMUX:+-tmux} -m -0 -1 --read0))
	[ -n "${RG_FILES}" ] && vim "${RG_FILES[@]}"
}

function wdl () {
	local BOOKMARK=$(wd list | sed '1d' | awk -F ' *-> *' '{ print $2 "\0" $1 }' | peco --null --select-1)
	[[ -n "${BOOKMARK}" ]] && wd $( head -n 1 <<< "${BOOKMARK}" )
}

function vimf() {
	local out
	local folder="$1"
	[ "$#" -gt 0 ] && shift
	: ${folder:=.}
	IFS=$'\n' out=($(find "$folder" \( \
		-path '*/.git' -o \
		-path '*/.svn' \) -prune -o \
		"$@" -print0 | fzf${TMUX:+-tmux} -0 -m -1 --read0 ))
	[ -n "$out" ] && vim "${out[@]}"
}

function vimp() {
	vim $(xsel -o)
}

function cf() {
	local out
	IFS=$'\n' out=($(find . \( \
		-path '*/.git' -o \
		-path '*/.svn' \) -prune -o \
		"$@" -type f -print0 | fzf${TMUX:+-tmux} -0 +m -1 --read0 ))
	[ -n "$out" ] && cd $(dirname $out)
}

function ff() {
	local out
	IFS=$'\n' out=($(find . \( \
		-path '*/.git' -o \
		-path '*/.svn' \) -prune -o \
		"$@" -type d -print0 | fzf${TMUX:+-tmux} -0 +m -1 --read0 ))
	[ -n "$out" ] && cd $out
}

function qarray() {
	local sep="$1";shift
	eval 'echo "${(j:'"$sep"':)${(qq)@## *}}"'
}

function ghq_update() {
	ghq list -e -p | xargs -i{} -n 1 -P 4 -r git -C {} pull --ff-only
}
