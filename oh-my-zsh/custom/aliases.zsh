alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias unicodeit='python -m unicodeit.cli'

alias claude="$HOME/.claude/local/claude"

# For GrapheneOS build
alias signify=signify-openbsd

clean_merged() {
    main_branch="$(git config init.defaultBranch)"
    git branch --merged "$main_branch" | grep -v "\* $main_branch" | xargs -n 1 git branch -d
}

serve-static-dir() {
    dir="$1"
    flags=()
    if [[ -n $dir ]] ; then
        flags+=('-d' "$dir")
    fi
    python3 -m http.server "${flags[@]}" 8000
}
