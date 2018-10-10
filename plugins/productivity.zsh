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

function vimin0 () {
	xargs -0 -r sh -c 'vim '"$@"' "$@" < /dev/tty' vim
}

function vimin () {
	xargs -r sh -c 'vim '"$@"' "$@" < /dev/tty' vim
}

function vimg () {
	rg -l -0 "$@" | fzf${TMUX:+-tmux} -m -0 -1 --read0 --print0 | vimin0
}

function wdl () {
	local BOOKMARK=$(wd list | sed '1d' | awk -F ' *-> *' '{ print $2 "\0" $1 }' | peco --null --select-1)
	[[ -n "${BOOKMARK}" ]] && wd $( head -n 1 <<< "${BOOKMARK}" )
}

function vimf() {
	fd -t f -0 "$@" | fzf${TMUX:+-tmux} -0 -m -1 --read0 --print0 | vimin0
}

function vimp() {
	vim $(xsel -o)
}

function cf() {
	local out
	IFS=$'\n' out=($(fd -0 -t f "$@" | fzf${TMUX:+-tmux} -0 +m -1 --read0 ))
	[ -n "$out" ] && cd $(dirname $out)
}

function ff() {
	local out
	IFS=$'\n' out=($(fd -0 -t d "$@" | fzf${TMUX:+-tmux} -0 +m -1 --read0 ))
	[ -n "$out" ] && cd $out
}

function qarray() {
	local sep="$1";shift
	eval 'echo "${(j:'"$sep"':)${(qq)@## *}}"'
}

function ghq-update() {
	ghq list -e -p | xargs -i{} -n 1 -P 4 -r -- chronic bash -c '(echo -n {} ; git -C {} pull --ff-only)'
}

function xsels() {
	local P=$(xsel -p -o)
	local C=$(xsel -b -o)
	xsel -b -i <<<"$P"
	xsel -p -i <<<"$C"
}
