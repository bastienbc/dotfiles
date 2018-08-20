#!/usr/bin/env zsh

install_mdv() {
	if ! has_mdv  && type pip >& /dev/null
	then
		pip install --user --upgrade mdv
	fi
}

has_mdv() {
	type mdv >& /dev/null
}
