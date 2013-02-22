#!/bin/sh

# install Oh My Zsh
if [[ ! -e $HOME/.oh-my-zsh ]] ; then
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

# add customization files
mv -i screenrc ~/.screenrc
mv -i dotemacs ~/.emacs
