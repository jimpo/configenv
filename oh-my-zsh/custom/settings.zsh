autoload -U select-word-style
select-word-style bash

export GOPATH="$HOME/Code/golang"

export PATH="$PATH:$HOME/.rbenv/bin:$GOPATH/bin"
eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
