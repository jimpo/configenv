autoload -U select-word-style
select-word-style bash

export EDITOR=vim

if [ -z "$ZSH_INIT_ONCE" ] ; then
    [ -d "$HOME/.rbenv/bin" ] && export PATH="$PATH:$HOME/.rbenv/bin"
    which rbenv > /dev/null && eval "$(rbenv init -)"

    # https://wiki.archlinux.org/index.php/GNOME/Keyring#With_a_display_manager
    if [ "$DESKTOP_SESSION" = "i3" ];then
        eval $(gnome-keyring-daemon --start)
        export SSH_AUTH_SOCK
    fi

    source "$HOME/.cargo/env"

    export PATH="$PATH:/usr/local/go/bin"
    export PATH="$PATH:/usr/local/cuda/bin"

    export PATH="$PATH:$HOME/.foundry/bin"
    export PATH="$PATH:$HOME/.pixi/bin"
    export PATH="$PATH:$HOME/.sp1/bin"
    export PATH="$PATH:$HOME/go/bin"
    export PATH="$PATH:${ASDF_DATA_DIR:-$HOME/.asdf}/shims"

    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    export ZSH_INIT_ONCE=1
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

base16_chalk

export CCACHE_DIR=$HOME/.ccache
