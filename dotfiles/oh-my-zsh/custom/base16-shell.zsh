# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell"
BASE16_DEFAULT_THEME=chalk
if [ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ]; then
    source "$BASE16_SHELL/profile_helper.sh"
fi

