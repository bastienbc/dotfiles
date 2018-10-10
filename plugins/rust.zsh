#!/usr/bin/env zsh

function has_rust() {
	command -v rustc >& /dev/null
}


function install_rust() {
	if ! has_rust; then
		curl https://sh.rustup.rs -sSf | sh -s -- -y > /dev/null
	fi
}
