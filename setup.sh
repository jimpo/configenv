#!/bin/sh

sh setup-shell.sh
sh setup-editors.sh

# add customization files
cp -i tmux.conf ~/.tmux.conf
cp -i gitconfig ~/.gitconfig
cp -ir jj ~/.config

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

