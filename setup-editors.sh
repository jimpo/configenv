#!/bin/sh

cp ${CP_FLAG:--i} vimrc ~/.vimrc
cp ${CP_FLAG:--i} ideavimrc ~/.ideavimrc
cp -r ${CP_FLAG:--i} nvim ~/.config
# ~/.config/emacs, not ~/.emacs.d: emacs prefers ~/.emacs.d whenever it exists,
# so a stray one shadows everything copied here.
mkdir -p ~/.config/emacs
cp -r ${CP_FLAG:--i} emacs.d/* ~/.config/emacs
mkdir -p ~/.config/Code/User
cp -r ${CP_FLAG:--i} VSCode/* ~/.config/Code/User

# Install vimplug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install CSApprox for vim
curl -o /tmp/CSApprox.zip -sSL https://www.vim.org/scripts/download_script.php?src_id=18594
unzip -d ~/.vim /tmp/CSApprox.zip
rm /tmp/CSApprox.zip

