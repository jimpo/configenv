# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

clean_merged() {
    git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d
}

monitor-on() {
    xrandr --output DP-1-1 --auto --left-of eDP-1-1
}

monitor-off() {
    xrandr --output DP-1-1 --off
}

serve-static-dir() {
    python3 -m http.server 8000
}
