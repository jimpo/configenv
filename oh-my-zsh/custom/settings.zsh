autoload -U select-word-style
select-word-style bash

export EDITOR=vim

export PATH="$PATH:$HOME/.rbenv/bin"
eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export GOROOT="$HOME/.goroot/1.10.2"
export GOPATH="$HOME/Code/go"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

# pipenv
export PATH="$PATH:$HOME/.local/bin"

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
base16_chalk

alias opam2="OPAMROOT=~/.opam2 /home/jimpo/.opam/4.05.0/lib/opam-devel/opam"
