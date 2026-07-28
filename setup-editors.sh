#!/bin/sh

cp -i vimrc ~/.vimrc
cp -i ideavimrc ~/.ideavimrc
cp -ir nvim ~/.config
mkdir -p ~/.emacs.d
cp -ir emacs.d/* ~/.emacs.d
mkdir -p ~/.config/Code/User
cp -ir VSCode/* ~/.config/Code/User

# Install vimplug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install CSApprox for vim
curl -o /tmp/CSApprox.zip -sSL https://www.vim.org/scripts/download_script.php?src_id=18594
unzip -d ~/.vim /tmp/CSApprox.zip
rm /tmp/CSApprox.zip

