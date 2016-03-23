# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias emacs='emacs -nw'

alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

clean_merged() {
    git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d
}
