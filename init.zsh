#!/usr/bin/env zsh

setopt AUTO_NAME_DIRS
setopt CDABLE_VARS
setopt HIST_FIND_NO_DUPS

source $HOME/.zplug/repos/bastienbc/dotfiles/plugins/revolver-helper.zsh
revolver-load-zplug

revolver-loading 'Configuring plugins'
zplug "zplug/zplug", hook-build:'zplug --self-manage'
zplug "peco/peco", as:command, from:gh-r
zplug "molovo/revolver", \
  as:command, \
  use:revolver
zplug 'rauno56/watchman', \
	as:command, \
	use:'target/release/watchman', \
	hook-build:'cargo build --release', \
	rename-to:"wm"
zplug 'vladimirmarkelov/pwatch', \
	as:command, \
	use:'target/release/pwatch', \
	hook-build:'cargo build --release', \
	rename-to:"pw"
zplug 'bootandy/dust', \
	as:command, \
	use:'target/release/dust', \
	hook-build:'cargo build --release', \
	rename-to:"dust"
zplug 'mmstick/parallel', \
	as:command, \
	use:'target/release/parallel', \
	hook-build:'cargo build --release', \
	rename-to:"para"
zplug 'sharkdp/bat', \
	as:command, \
	use:'target/release/bat', \
	hook-build:'cargo build --release', \
	rename-to:"bat"
zplug 'svenstaro/genact', \
	from:gh-r, \
	as:command, \
	rename-to:"genact"
zplug 'BurntSushi/xsv', \
	use:'target/release/xsv', \
	hook-build:'cargo build --release', \
	as:command, \
	rename-to:"xsv"
zplug 'BurntSushi/ripgrep', \
	use:'target/release/rg', \
	hook-build:'cargo build --release', \
	as:command, \
	rename-to:"rg"
zplug 'stedolan/jq', \
	from:gh-r, \
	as:command
zplug 'junegunn/fzf-bin', \
	as:command, \
	from:gh-r, \
	rename-to:"fzf"
zplug "icetee/pv", \
	as:command, \
	use:'bin/pv', \
	hook-build:'./configure prefix=$HOME/.local && make && make install'
zplug 'sharkdp/fd', \
	as:command, \
	use:'target/release/fd', \
	hook-build:'cargo build --release', \
	rename-to:"fd"
zplug 'watchexec/watchexec', \
	as:command, \
	use:'target/release/watchexec', \
	hook-build:'cargo build --release', \
	rename-to:"watchx"
zplug 'clvv/fasd',\
   as:command,\
   from:github,\
   use:'bin/fasd',\
   hook-build:'PREFIX=$HOME make install',\
   rename-to:'fasd'
zplug 'motemen/ghq',\
   as:command,\
   from:github,\
   use:'ghq',\
   hook-build:'make deps && make build',\
   rename-to:'ghq'
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "holman/spark", as:command, use:spark
zplug "bastienbc/autostore", as:command, use:autostore,\
	hook-build:'perl ./Build.PL && ./Build && ./Build installdeps && ./Build install --install_base ${HOME}/perl5'
zplug "bastienbc/series-rename", as:command, use:'series-rename',\
	hook-build:'perl ./Build.PL && ./Build && ./Build installdeps && ./Build install --install_base ${HOME}/perl5'
zplug 'bastienbc/dotfiles', as:plugin, use:'install_deps.zsh', defer:2
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
# zplug "plugins/thefuck",  from:oh-my-zsh, as:plugin, hook-build:"pip install --upgrade --user thefuck"
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
zplug 'mrowa44/emojify', as:command, use:emojify
zplug "zsh-users/zsh-syntax-highlighting", defer:2, as:plugin
zplug-install-load
revolver-loading-stop


autoload -U compinit zrecompile
for f in ${0:A:h}/plugins/*.zsh ${0:a} ${0:A:h}/*.zsh
do
	zrecompile -p $f && rm -f $f.zwc.old
done


