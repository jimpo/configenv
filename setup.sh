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
cp -i vimrc ~/.vimrc
cp -i ideavimrc ~/.ideavimrc
mkdir -p ~/.emacs.d
cp -ir emacs.d/* ~/.emacs.d
cp -ir oh-my-zsh/* ~/.oh-my-zsh
mkdir -p ~/.config/Code/User
cp -ir VSCode/* ~/.config/Code/User

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

# Install vimplug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install CSApprox
curl -o /tmp/CSApprox.zip -sSL https://www.vim.org/scripts/download_script.php?src_id=18594
pushd ~/.vim
unzip /tmp/CSApprox.zip
rm /tmp/CSApprox.zip
popd

# Capslock as meta remapping option
cd /usr/share/X11/xkb/rules
sudo sed -i 's/^  caps:menu\t\t=\t+capslock(menu)$/  caps:meta\t\t=\t+capslock(meta)\n\0/' base
sudo sed -i 's/^  caps:menu\( \+\)Make Caps Lock an additional Menu key$/  caps:meta\1Make Caps Lock an additional Meta key\n\0/' base.lst
sudo sed -i 's/^  caps:menu\t\t=\t+capslock(menu)$/  caps:meta\t\t=\t+capslock(meta)\n\0/' evdev
sudo sed -i 's/^  caps:menu\( \+\)Make Caps Lock an additional Menu key$/  caps:meta\1Make Caps Lock an additional Meta key\n\0/' evdev.lst

