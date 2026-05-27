# Midnight Signal root Bash profile
# Keeps the normal-user prompt structure, but raises the privilege contrast
# so root sessions are unmistakable at a glance.

case $- in
  *i*) ;;
  *) return ;;
esac

[ -n "${__MIDNIGHT_SIGNAL_ROOT_BASHRC_LOADED:-}" ] && return
__MIDNIGHT_SIGNAL_ROOT_BASHRC_LOADED=1

[ -f "$HOME/.bashrc.local" ] && . "$HOME/.bashrc.local"
__ms_root_dir="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
[ -f "$__ms_root_dir/../shell/common.sh" ] && . "$__ms_root_dir/../shell/common.sh"
unset __ms_root_dir

shopt -s checkwinsize

__ms_root_prompt() {
  local exit_code=$?
  local c_reset='\[\e[0m\]'
  local c_red='\[\e[38;5;196m\]'
  local c_red_soft='\[\e[38;5;203m\]'
  local c_blue='\[\e[38;5;117m\]'
  local c_gold='\[\e[38;5;221m\]'
  local c_purple='\[\e[38;5;141m\]'
  local c_gray='\[\e[38;5;244m\]'
  local status='' git='' symbol='#'

  if [ "$exit_code" -ne 0 ]; then
    status="${c_red_soft}[${exit_code}]${c_reset} "
  fi

  local git_segment
  git_segment="$(ms_git_segment 2>/dev/null)"
  if [ -n "$git_segment" ]; then
    git=" ${c_purple} ${git_segment}${c_reset}"
  fi

  PS1="${status}${c_red}root${c_reset}${c_gray}@${c_blue}\h${c_reset} ${c_gray}in${c_reset} ${c_gold}\w${c_reset}${git}\n${c_red}${symbol}${c_reset} "
}

if [ -n "${PROMPT_COMMAND:-}" ]; then
  case ";${PROMPT_COMMAND};" in
    *";__ms_root_prompt;"*) ;;
    *) PROMPT_COMMAND="__ms_root_prompt;${PROMPT_COMMAND}" ;;
  esac
else
  PROMPT_COMMAND=__ms_root_prompt
fi
alias please=''
alias cls='clear'

# Root quality-of-life aliases
alias ll='ls -lah --group-directories-first'
alias ports='ss -tulpn'
