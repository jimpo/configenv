ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[blue]%}[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(git_current_branch)
  if [ -n "$cb" ]; then
    echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(git_current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
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

function prompt_pwd() {
	local cwd="${PWD/#$HOME/~}"
	local -a parts
	parts=("${(s:/:)cwd}")
	if (( ${#parts} > 4 )); then
		parts=("${parts[1]}" "${parts[2]}" "..." "${parts[-2]}" "${parts[-1]}")
	fi
	echo "${(j:/:)parts}"
}

PROMPT='%{$fg[cyan]%}%n@%m %{$fg[green]%}[$(prompt_pwd)]% %{$fg[white]%}%  %B%#%b '
RPS1='$(git_custom_status)$(vi_mode_custom_prompt_info)%{$fg[red]%}[%*]%{$reset_color%}$EPS1'
