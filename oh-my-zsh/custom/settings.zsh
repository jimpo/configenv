autoload -U select-word-style
select-word-style bash

export EDITOR=vim

export PATH="$PATH:$HOME/.rbenv/bin"
eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export GOPATH="$HOME/Code/golang"
export PATH="$PATH:$GOPATH/bin"

# pipenv
export PATH="$PATH:$HOME/.local/bin"
