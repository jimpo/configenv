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
mkdir -p ~/.emacs.d
cp -ir emacs.d/* ~/.emacs.d
cp -ir oh-my-zsh/* ~/.oh-my-zsh

# Install vimplug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install CSApprox
curl -o /tmp/CSApprox.zip -sSL https://vim.sourceforge.io/scripts/download_script.php?src_id=18594
pushd ~/.vim
unzip /tmp/CSApprox.zip
rm /tmp/CSApprox.zip
popd
