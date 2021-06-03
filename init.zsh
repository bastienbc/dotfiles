#!/usr/bin/env zsh

setopt AUTO_NAME_DIRS
setopt CDABLE_VARS
setopt HIST_FIND_NO_DUPS

source $HOME/.zplug/repos/bastienbc/dotfiles/plugins/revolver-helper.zsh
revolver-load-zplug

revolver-loading 'Configuring plugins'
zplug "zplug/zplug", hook-build:'zplug --self-manage'
zplug "molovo/revolver", as:command, use:revolver
zplug "holman/spark", as:command, use:spark
zplug 'mrowa44/emojify', as:command, use:emojify
zplug 'bastienbc/dotfiles', as:plugin, use:'plugins/*.zsh', defer:1
zplug "mafredri/zsh-async", from:github
zplug "plugins/kubectl",  from:oh-my-zsh, as:plugin, hook-load:"unalias k 2>/dev/null"
zplug "plugins/colorized",  from:oh-my-zsh, as:plugin
zplug "supercrabtree/k", from:github, as:plugin, use:'k.sh'
zplug "plugins/cp",  from:oh-my-zsh, as:plugin
zplug "plugins/fasd",  from:oh-my-zsh, as:plugin
zplug "plugins/git",  from:oh-my-zsh, as:plugin
zplug "plugins/golang",  from:oh-my-zsh, as:plugin
zplug "plugins/history-substring-search", from:oh-my-zsh, as:plugin, defer:1
zplug "plugins/jsontools",  from:oh-my-zsh, as:plugin
zplug "plugins/perl",  from:oh-my-zsh, as:plugin
zplug "plugins/python",  from:oh-my-zsh, as:plugin
zplug "plugins/terraform",  from:oh-my-zsh, as:plugin
zplug "plugins/rsync",  from:oh-my-zsh, as:plugin
zplug "plugins/transfer",  from:oh-my-zsh, as:plugin
zplug "plugins/thefuck",  from:oh-my-zsh, as:plugin
zplug "plugins/tig",  from:oh-my-zsh, as:plugin
zplug "plugins/tmux",  from:oh-my-zsh, as:plugin
zplug "plugins/vi-mode",  from:oh-my-zsh, as:plugin
zplug "plugins/vundle",  from:oh-my-zsh, as:plugin
zplug "plugins/wd",  from:oh-my-zsh, as:plugin
zplug "plugins/helm",  from:oh-my-zsh, as:plugin
zplug "plugins/zsh-navigation-tools",  from:oh-my-zsh, as:plugin
zplug "plugins/zsh_reload",  from:oh-my-zsh, as:plugin
zplug "robbyrussell/oh-my-zsh", use:'lib/{completion,theme-and-appearance,compfix,directories,history}.zsh', as:plugin
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "zlsun/solarized-man", from:github, as:plugin
zplug 'zsh-users/zsh-autosuggestions', as:plugin
zplug 'zsh-users/zsh-completions', as:plugin
zplug 'MichaelAquilina/zsh-emojis', as:plugin
zplug "b4b4r07/emoji-cli", as:plugin
zplug "zsh-users/zsh-syntax-highlighting", defer:2, as:plugin
zplug-install-load
revolver-loading-stop


revolver-loading 'Compiling local plugins'
autoload -U compinit zrecompile
for f in ${0:A:h}/plugins/*.zsh ${0:a} ${0:A:h}/*.zsh
do
	zrecompile -p $f && rm -f $f.zwc.old
done
revolver-loading-stop


if zplug check zsh-users/zsh-autosuggestions; then
	ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
	ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
fi

_gen_rgrc "${0:A:h}/.rgrc"

if zplug check "plugins/history-substring-search"; then
	bindkey '^[OA' history-substring-search-up
	bindkey '^[OA' history-substring-search-down
fi

export GOPATH="${HOME}/.go:${GOPATH}"
export GHQ_ROOT="${HOME}/.ghq"
export PATH="${PATH}:${HOME}/.cargo/bin:${HOME}/.go/bin:${HOME}/bin"
