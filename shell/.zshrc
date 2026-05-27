# Midnight Signal Zsh profile

[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
__ms_zsh_file="${(%):-%N}"
__ms_zsh_dir="${__ms_zsh_file:A:h}"
[ -f "$__ms_zsh_dir/common.sh" ] && source "$__ms_zsh_dir/common.sh"
unset __ms_zsh_file __ms_zsh_dir

setopt AUTO_CD HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS SHARE_HISTORY PROMPT_SUBST
bindkey -v

autoload -Uz colors && colors
autoload -Uz add-zsh-hook

__ms_zsh_prompt() {
  local exit_code=$?
  local status=""
  local symbol="❯"
  local git_segment="$(ms_git_segment 2>/dev/null)"
  local git=""

  if [[ $exit_code -ne 0 ]]; then
    status="%F{203}[$exit_code]%f "
    symbol='✖'
  fi

  if [[ -n "$git_segment" ]]; then
    git=" %F{141} $git_segment%f"
  fi

  PROMPT="${status}%F{117}%n%f%F{244}@%f%F{111}%m%f %F{244}in%f %F{221}%~%f${git}
%F{114}${symbol}%f "
}

add-zsh-hook precmd __ms_zsh_prompt
