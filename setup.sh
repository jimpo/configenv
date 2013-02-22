#!/bin/sh

# install Oh My Zsh
if [ ! -d $HOME/.oh-my-zsh ] ; then
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

# change default shell to ZSH
chsh -s $(which zsh)

# add customization files
cp -i zshrc ~/.zshrc
cp -i dotemacs ~/.emacs
cp -i screenrc ~/.screenrc
cp -ir oh-my-zsh ~/.oh-my-zsh

# set global git options
git config --global user.name   'Jim Posen'
git config --global user.email  'jim.posen@gmail.com'
git config --global core.editor 'emacs -nw'
