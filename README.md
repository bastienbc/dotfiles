# Install

Add this on top of your .zshrc, it will install zplug and install everything for you:

```sh
if [ ! -d "$HOME/.zplug/repos/bastienbc" ]
then
	git clone https://github.com/bastienbc/dotfiles $HOME/.zplug/repos/bastienbc/dotfiles
fi
source $HOME/.zplug/repos/bastienbc/dotfiles/init.zsh
```
