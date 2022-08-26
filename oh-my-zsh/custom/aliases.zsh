alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# For GrapheneOS build
alias signify=signify-openbsd

clean_merged() {
    git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d
}

serve-static-dir() {
    python3 -m http.server 8000
}
