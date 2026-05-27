#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LATEST_BACKUP="$(find "$HOME/.dotfiles-backups" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort | tail -n 1 || true)"

unlink_if_owned() {
  local source="$1"
  local target="$2"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    rm -f "$target"
    printf 'unlink  %s\n' "$target"
  else
    printf 'skip    %s (not linked to this repo)\n' "$target"
  fi
}

restore_backup_if_present() {
  local name="$1"
  local target="$2"

  if [ -n "$LATEST_BACKUP" ] && [ -e "$LATEST_BACKUP/$name" ]; then
    mv "$LATEST_BACKUP/$name" "$target"
    printf 'restore %s\n' "$target"
  fi
}

unlink_if_owned "$REPO_DIR/shell/.bashrc" "$HOME/.bashrc"
unlink_if_owned "$REPO_DIR/shell/.zshrc" "$HOME/.zshrc"
unlink_if_owned "$REPO_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
unlink_if_owned "$REPO_DIR/git/.gitconfig" "$HOME/.gitconfig"
unlink_if_owned "$REPO_DIR/.inputrc" "$HOME/.inputrc"

restore_backup_if_present .bashrc "$HOME/.bashrc"
restore_backup_if_present .zshrc "$HOME/.zshrc"
restore_backup_if_present .tmux.conf "$HOME/.tmux.conf"
restore_backup_if_present .gitconfig "$HOME/.gitconfig"
restore_backup_if_present .inputrc "$HOME/.inputrc"

printf '\nDone. You may need to restart your shell.\n'
