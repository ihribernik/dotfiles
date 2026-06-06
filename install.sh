#!/usr/bin/env bash

set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/common/helpers.sh
source "${BASEDIR}/scripts/common/helpers.sh"

INCLUDE_OPTIONAL=0

while [[ $# -gt 0 ]]; do
	case "$1" in
	--include-optional)
		INCLUDE_OPTIONAL=1
		shift
		;;
	-h | --help)
		cat <<'EOF'
Usage: ./install.sh [--include-optional]

Installs core dotfiles on Ubuntu-like environments.
EOF
		exit 0
		;;
	*)
		dotfiles_error "Unknown argument: $1"
		;;
	esac
done

dotfiles_log "Installing core dotfiles from ${BASEDIR}"

core_dirs=(
	"$HOME/dev/personal"
	"$HOME/dev/work"
	"$HOME/.config"
	"$HOME/.local/bin"
)

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
dotfiles_install_link "${BASEDIR}/dotfiles/fish" "$HOME/.config/fish"

if [[ "${INCLUDE_OPTIONAL}" -eq 1 ]]; then
	dotfiles_log "Installing optional configs"
else
	dotfiles_log "Skipping optional configs. Use --include-optional to install them."
fi

dotfiles_log "Install complete"
