# Midnight Signal Bash profile

case $- in
  *i*) ;;
  *) return ;;
esac

[ -n "${__MIDNIGHT_SIGNAL_BASHRC_LOADED:-}" ] && return
__MIDNIGHT_SIGNAL_BASHRC_LOADED=1

[ -f "$HOME/.bashrc.local" ] && . "$HOME/.bashrc.local"
__ms_bash_dir="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
[ -f "$__ms_bash_dir/common.sh" ] && . "$__ms_bash_dir/common.sh"
unset __ms_bash_dir

shopt -s checkwinsize

__ms_bash_prompt() {
  local exit_code=$?
  local c_reset='\[\e[0m\]'
  local c_dim='\[\e[2m\]'
  local c_red='\[\e[38;5;203m\]'
  local c_green='\[\e[38;5;114m\]'
  local c_blue='\[\e[38;5;111m\]'
  local c_cyan='\[\e[38;5;117m\]'
  local c_gold='\[\e[38;5;221m\]'
  local c_purple='\[\e[38;5;141m\]'
  local c_gray='\[\e[38;5;244m\]'
  local status='' symbol='❯' git=''

  if [ "$exit_code" -ne 0 ]; then
    status="${c_red}[${exit_code}]${c_reset} "
    symbol='✖'
  fi

  local git_segment
  git_segment="$(ms_git_segment 2>/dev/null)"
  if [ -n "$git_segment" ]; then
    git=" ${c_purple} ${git_segment}${c_reset}"
  fi

  PS1="${status}${c_cyan}\u${c_dim}@${c_reset}${c_blue}\h${c_reset} ${c_gray}in${c_reset} ${c_gold}\w${c_reset}${git}\n${c_green}${symbol}${c_reset} "
}

if [ -n "${PROMPT_COMMAND:-}" ]; then
  case ";${PROMPT_COMMAND};" in
    *";__ms_bash_prompt;"*) ;;
    *) PROMPT_COMMAND="__ms_bash_prompt;${PROMPT_COMMAND}" ;;
  esac
else
  PROMPT_COMMAND=__ms_bash_prompt
fi
