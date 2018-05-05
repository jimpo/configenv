ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[blue]%}[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

vim_ins_mode="%{$fg[yellow]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg[magenta]%}[CMD]%{$reset_color%}"

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

function vi_mode_custom_prompt_info() {
  echo "${${${KEYMAP:-main}/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
}

PROMPT='%{$fg[cyan]%}%n:%{$fg[green]%}%~% %{$fg[white]%}%  %B%#%b '
RPS1='$(git_custom_status)$(vi_mode_custom_prompt_info)%{$fg[red]%}[%*]%{$reset_color%}$EPS1'
