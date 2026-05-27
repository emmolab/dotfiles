# Shared shell configuration for the Midnight Signal setup.

# Avoid loading twice.
[ -n "${__MIDNIGHT_SIGNAL_LOADED:-}" ] && return
__MIDNIGHT_SIGNAL_LOADED=1

# History defaults
HISTCONTROL=ignoredups:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT='%F %T '
shopt -s histappend 2>/dev/null || true

# Less noisy and safer defaults
umask 022
set -o notify 2>/dev/null || true

# Preferred editor / pager
export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-$EDITOR}"
export PAGER="${PAGER:-less -FRX}"

# Useful environment tweaks
export CLICOLOR=1
export LS_COLORS="${LS_COLORS:-di=1;34:ln=1;36:so=1;35:pi=33:ex=1;32:bd=1;33;40:cd=1;33;40}"

# Core aliases
alias ls='ls --color=auto'
alias ll='ls -lah --group-directories-first'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias md='mkdir -p'
alias rd='rmdir'
alias reload='exec "$SHELL" -l'
alias ports='ss -tulpn'
alias path='printf "%s\n" "${PATH//:/\n}"'
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log --oneline --decorate --graph -20'
alias gs='git status -sb'
alias docker-compose='docker compose'
alias please='sudo $(history -p !!)'

# Helper: make and enter directory
mkcd() {
  mkdir -p -- "$1" && cd -- "$1"
}

# Helper: extract common archives
extract() {
  [ -f "$1" ] || { printf 'extract: %s not found\n' "$1" >&2; return 1; }
  case "$1" in
    *.tar.bz2|*.tbz2) tar xjf "$1" ;;
    *.tar.gz|*.tgz) tar xzf "$1" ;;
    *.tar.xz|*.txz) tar xJf "$1" ;;
    *.tar) tar xf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.gz) gunzip "$1" ;;
    *.xz) unxz "$1" ;;
    *.zip) unzip "$1" ;;
    *.7z) 7z x "$1" ;;
    *) printf 'extract: cannot handle %s\n' "$1" >&2; return 1 ;;
  esac
}

# Helper: print repo default branch when origin is configured
git_default_branch() {
  git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'
}

# Helper: git branch / dirty marker for prompts
ms_git_segment() {
  command -v git >/dev/null 2>&1 || return 0
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 0

  local branch dirty
  branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null) || return 0
  [ -n "$(git status --porcelain 2>/dev/null)" ] && dirty='*' || dirty=''
  printf '%s%s' "$branch" "$dirty"
}
