# dotfiles

A personal terminal setup with a **clean operator-style feel**: dark, practical, and fast to read.

This repo is intentionally original. It takes broad inspiration from simple symlink-based dotfile repos, but the structure, theme, prompt, aliases, and tmux layout here are custom.

## Style: Midnight Signal

The theme aims for:
- high contrast without neon overload
- small but useful prompt context
- readable shell defaults
- practical tmux navigation
- a setup that still works well over SSH and on minimal Linux hosts

## Included

- `shell/common.sh` – shared shell config, prompt, aliases, helpers
- `shell/.bashrc` – Bash entrypoint
- `shell/.zshrc` – Zsh entrypoint
- `tmux/.tmux.conf` – tmux theme + sane keybinds
- `git/.gitconfig` – quality-of-life git defaults and aliases
- `.inputrc` – better shell history/search behavior
- `install.sh` – backup + symlink installer
- `uninstall.sh` – remove symlinks and restore backups when present

## Highlights

- custom prompt with:
  - username@host
  - working directory
  - git branch + dirty marker
  - exit-code warning when the previous command failed
- shell aliases for safer day-to-day work
- `extract`, `mkcd`, and `git_default_branch` helpers
- tmux with vim-style pane movement and a status bar matching the shell theme
- backups before any dotfile is replaced

## Install

```bash
cd ~
git clone https://github.com/emmolab/dotfiles.git
cd dotfiles
./install.sh
```

Or clone somewhere else and run the installer there.

## Uninstall

```bash
cd ~/dotfiles
./uninstall.sh
```

## Notes

- Existing files are backed up to `~/.dotfiles-backups/<timestamp>/`
- The installer creates symlinks instead of copying files
- Bash and Zsh are both supported
- The prompt does not require Starship, Oh My Zsh, or external prompt frameworks

## Customization

If you want to tune colors later, start in:

- `shell/common.sh` for prompt colors and aliases
- `tmux/.tmux.conf` for pane/status styling
- `git/.gitconfig` for git aliases
