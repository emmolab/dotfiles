# dotfiles

A personal terminal setup with a **clean operator-style feel**: dark, practical, and fast to read.

## Style: Midnight Signal

The theme aims for:
- high contrast without neon overload
- small but useful prompt context
- readable shell defaults
- practical tmux navigation
- a setup that still works well over SSH and on minimal Linux hosts

## Included

- `shell/common.sh` – shared shell config, prompt, aliases, helpers
- `shell/.bashrc` – Bash entrypoint for normal users
- `shell/.bash_profile` – Bash login entrypoint that loads `.bashrc`
- `shell/.zshrc` – Zsh entrypoint
- `root/.bashrc` – root-focused Bash prompt with stronger privilege contrast
- `root/.bash_profile` – small root login profile that sources `.profile` and `.bashrc`
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
- Bash login shells are supported via the included `.bash_profile`
- The prompt does not require Starship, Oh My Zsh, or external prompt frameworks

## Customization

If you want to tune colors later, start in:

- `shell/common.sh` for shared aliases/helpers
- `shell/.bashrc` for the normal-user Bash prompt
- `root/.bashrc` for the root-only Bash prompt and stronger privilege styling
- `tmux/.tmux.conf` for pane/status styling
- `git/.gitconfig` for git aliases

## Root usage

The repo includes a dedicated root prompt designed to be more obvious than the normal-user prompt without changing the overall Midnight Signal layout:

- bold two-line prompt
- stronger red emphasis so you can tell root apart immediately
- the same general structure as the normal-user prompt, so it still feels cohesive

To test or install it manually for root later, you can symlink:

```bash
sudo ln -sf /path/to/dotfiles/root/.bashrc /root/.bashrc
sudo ln -sf /path/to/dotfiles/root/.bash_profile /root/.bash_profile
```

Root dotfiles are intentionally kept as a separate manual step so normal-user installation stays predictable.
