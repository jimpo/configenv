#!/bin/sh

# install Oh My Zsh
if [ ! -d $HOME/.oh-my-zsh ] ; then
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

# change default shell to ZSH
chsh -s $(which zsh)

# add customization files
cp -i tmux.conf ~/.tmux.conf
cp -i gitconfig ~/.gitconfig
cp -ir emacs.d/* ~/.emacs.d
cp -ir oh-my-zsh/* ~/.oh-my-zsh
