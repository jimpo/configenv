#!/bin/sh

# cp clobber behavior: interactive by default (prompt before overwrite); pass -f
# to force-overwrite (non-interactive, e.g. automated provisioning). Exported so
# setup-shell.sh / setup-editors.sh use the same behavior.
CP_FLAG=-i
[ "$1" = "-f" ] && CP_FLAG=-f
export CP_FLAG

sh setup-shell.sh
sh setup-editors.sh

# add customization files
cp $CP_FLAG dotfiles/tmux.conf ~/.tmux.conf
cp $CP_FLAG dotfiles/gitconfig ~/.gitconfig
cp -r $CP_FLAG dotfiles/config/jj ~/.config

[ -d ~/.config/base16-shell ] || \
    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
