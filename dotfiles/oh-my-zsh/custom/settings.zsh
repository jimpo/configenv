# Base16 Shell
# `base16_chalk` is one of the functions profile_helper.sh defines, so it is
# only callable once that has been sourced. Machines without base16-shell fall
# through to their terminal's own colors.
BASE16_SHELL="$HOME/.config/base16-shell/"
if [ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ]; then
    source "$BASE16_SHELL/profile_helper.sh"
    base16_chalk
fi

export STOW_DIR="$HOME/.stow"

