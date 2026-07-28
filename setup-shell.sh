#!/bin/sh

ZSH_THEME_NAME="jimpo"
ZSH_PLUGINS="git jj vi-mode fzf docker"

# install Oh My Zsh
if [ ! -d $HOME/.oh-my-zsh ] ; then
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

# customize the zshrc installed by Oh My Zsh
sed -i \
    -e "s/^ZSH_THEME=.*/ZSH_THEME=\"$ZSH_THEME_NAME\"/" \
    -e "s/^plugins=(.*)\$/plugins=($ZSH_PLUGINS)/" \
    ~/.zshrc

# change default shell to ZSH
chsh -s $(which zsh)

cp -ir oh-my-zsh/* ~/.oh-my-zsh

