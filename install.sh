#!/usr/bin/env bash

set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/common/helpers.sh
source "${BASEDIR}/scripts/common/helpers.sh"

dotfiles_log "Installing core dotfiles from ${BASEDIR}"

core_dirs=(
	"$HOME/dev/personal"
	"$HOME/dev/work"
	"$HOME/.config"
	"$HOME/.local/bin"
)

dotfiles_log "generating parent folders"

for dir in "${core_dirs[@]}"; do
	dotfiles_ensure_dir "$dir"
done

dotfiles_install_link "${BASEDIR}/dotfiles/git/.gitconfig" "$HOME/.gitconfig"
dotfiles_install_link "${BASEDIR}/dotfiles/git/.gitconfig_work" "$HOME/.gitconfig_work"
dotfiles_install_link "${BASEDIR}/dotfiles/.editorconfig" "$HOME/.editorconfig"
dotfiles_install_link "${BASEDIR}/dotfiles/.wezterm.lua" "$HOME/.wezterm.lua"
dotfiles_install_link "${BASEDIR}/dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
dotfiles_install_link "${BASEDIR}/dotfiles/bash/.bash_aliases" "$HOME/.bash_aliases"
dotfiles_install_link "${BASEDIR}/dotfiles/bash/.bash_personal" "$HOME/.bash_personal"
dotfiles_install_link "${BASEDIR}/dotfiles/bash/.bashrc" "$HOME/.bashrc"
dotfiles_install_link "${BASEDIR}/dotfiles/nvim" "$HOME/.config/nvim"

source "${BASEDIR}/scripts/ubuntu/install-packages.sh"
source "${BASEDIR}/scripts/ubuntu/install-extras.sh"

dotfiles_log "Install complete"
