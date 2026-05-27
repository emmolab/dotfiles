#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="$HOME/.dotfiles-backups"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="$BACKUP_ROOT/$STAMP"

mkdir -p "$BACKUP_DIR"

link_file() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    printf 'skip    %s (already linked)\n' "$target"
    return
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    mv "$target" "$BACKUP_DIR/$(basename "$target")"
    printf 'backup  %s -> %s\n' "$target" "$BACKUP_DIR/$(basename "$target")"
  fi

  ln -s "$source" "$target"
  printf 'link    %s -> %s\n' "$target" "$source"
}

link_file "$REPO_DIR/shell/.bashrc" "$HOME/.bashrc"
link_file "$REPO_DIR/shell/.zshrc" "$HOME/.zshrc"
link_file "$REPO_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
link_file "$REPO_DIR/git/.gitconfig" "$HOME/.gitconfig"
link_file "$REPO_DIR/.inputrc" "$HOME/.inputrc"

printf '\nDone. Backups stored in %s\n' "$BACKUP_DIR"
printf 'Restart your shell or run: exec "$SHELL" -l\n'
