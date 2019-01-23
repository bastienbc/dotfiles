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
	xargs -0 -r -o vim "$@"
}

function vimin () {
	xargs -r -o vim "$@"
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

function klogz {
	if [ -t 1 ];
	then
		ACTUALIZE="-f"
	else
		MULTI="-m"
	fi
	kubectl get pods | fzf --header-lines=1 --select-1 $MULTI | awk '{print $1;}' | xargs -I{} kubectl logs $ACTUALIZE "$@" {}
}

function kdelpz {
	kubectl get pods | fzf --header-lines=1 --select-1 -m | awk '{print $1;}' | xargs -n 1 -I{} kubectl delete --wait=false pod "$@" {}
}

function kexz {
	kubectl get pods | fzf --header-lines=1 --select-1 | awk '{print $1;}' | xargs -I{} --open-tty kubectl exec -it {} "$@"
}

function kgz {
	kubectl get pods | fzf --header-lines=1 --select-1 -m | awk '{print $1;}'
}

function kgzec {
	local SECRETS=$(kubectl get secrets | fzf --header-lines=1 --select-1 -m | awk '{print $1;}' | xargs -n 1 -I{} -r kubectl get secrets {} -o json | jq -s 'reduce .[] as $x ( {}; . * $x.data )')
	jq -r 'keys[]' <<< "${SECRETS}" | fzf --select-1 -m | \
	while read var; do
		echo "'$var': '$(jq -r '."'$var'"' <<< "${SECRETS}" | base64 -d)'"
	done
}

function kpfz {
	local SVC=$(kubectl get svc | fzf -1 | awk '{print $1;}')
	if [ -z "${SVC}" ]; then
		exit 0
	fi
	local PORTS=()
	local SELECTS=($(kubectl get svc -o json "${SVC}" | jq -r '.spec.ports[] | [ .name, .port ] | @csv' | sed 's/"//g' | fzf -1 -m | tr '\n' ' ' ))
	for value in ${SELECTS[@]}; do
		IFS=',' read name port <<< "$value"
		read "PORT?${name}[${port}]: "
		if [ -z "$PORT" ]; then
			PORT=$port
		fi
		PORTS=($PORTS "$PORT:$port")
	done
	echo -e "${PORTS[@]}" | xargs -r kubectl port-forward "svc/${SVC}"
}
