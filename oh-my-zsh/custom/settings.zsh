autoload -U select-word-style
select-word-style bash

export EDITOR=vim

if [ -z "$ZSH_INIT_ONCE" ] ; then
    [ -d "$HOME/.rbenv/bin" ] && export PATH="$PATH:$HOME/.rbenv/bin"
    which rbenv > /dev/null && eval "$(rbenv init -)"

    export PATH="$PATH:$HOME/Android/Sdk/platform-tools"

    source $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

    # https://wiki.archlinux.org/index.php/GNOME/Keyring#With_a_display_manager
    if [ "$DESKTOP_SESSION" = "i3" ];then
        eval $(gnome-keyring-daemon --start)
        export SSH_AUTH_SOCK
    fi

    export ZSH_INIT_ONCE=1
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
base16_chalk

export CCACHE_DIR=$HOME/.ccache
