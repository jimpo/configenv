autoload -U select-word-style
select-word-style bash

export EDITOR=vim

export PATH="$PATH:$HOME/.rbenv/bin"
eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export PATH="$PATH:$HOME/.cabal/bin"

export GOROOT="/opt/go/1.12.6"
export GOPATH="$HOME/Code/go"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

export PATH="/opt/texlive/2018/bin/x86_64-linux:$PATH"
export PATH="/opt/jdk-13.0.2/bin:$PATH"

export PATH="$PATH:$HOME/Android/Sdk/platform-tools"

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
base16_chalk

source $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# https://wiki.archlinux.org/index.php/GNOME/Keyring#With_a_display_manager
if [ "$DESKTOP_SESSION" = "i3" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

