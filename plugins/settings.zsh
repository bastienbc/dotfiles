#!/usr/bin/env zsh

export BAT_THEME='Solarized (dark)'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export WATCH_COMMAND='zsh -c'

setopt AUTO_NAME_DIRS
setopt CDABLE_VARS
setopt HIST_FIND_NO_DUPS

export GOPATH="${HOME}/.go:${GOPATH}"
export GHQ_ROOT="${HOME}/.ghq"
export PATH="${PATH}:${HOME}/.cargo/bin:${HOME}/.go/bin:${HOME}/.local/bin:${HOME}/bin"
