#!/usr/bin/env zsh

alias noproxy="env http_proxy='' https_proxy='' ftp_proxy=''"

export SSH_ASKPASS=""
export EDITOR="vim"
export ZSHRC="${HOME}/.zshrc"
export VIMRC="${HOME}/.vimrc"
alias zshrc="${EDITOR} ${ZSHRC} ; src"
alias szshrc="source ${HOME}/.zshrc"
if command -v vimx >& /dev/null; then
	alias vim="vimx"
fi
alias vimrc="${EDITOR} ${HOME}/.vimrc"
alias src="omz reload"


alias phtml="w3m -dump -T text/html"

alias gpt="git push --tags"
alias glt='git describe --tags $(git rev-list --tags --max-count=1)'
alias glct="git describe --abbrev=0"
alias glof="git log --follow -p --"
alias gtc="git tag --sort=-creatordate"
alias gplt='git push origin $(gtc | first)'
alias gff='git pull --ff-only'
alias imgv='w3m -o ext_image_viewer=0'

alias first="head -n 1"

alias ct='bat --style plain'
alias ka='k -Ah'

alias t='terraform'

export RIPGREP_CONFIG_PATH=$HOME/.rgrc

alias yank='yank-cli'

alias wm='watchman'
alias wms='wm show'
alias wmf='wm fix'


alias la='lsd -Alh'
alias l='lsd -alh'
alias ll='lsd -lh'
alias lt='lsd --tree'

alias b='btm'

alias p='pueue'
alias pl='pueue log'
alias pa='pueue add'
alias pst='pueue status'
alias pc='pueue clean --successful-only'
alias pca='pueue clean'
