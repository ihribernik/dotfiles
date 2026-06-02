#!/usr/bin/env bash

set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# shellcheck source=scripts/common/helpers.sh
source "${BASEDIR}/scripts/common/helpers.sh"

RUN_EXTRA_TOOLS="${RUN_EXTRA_TOOLS:-0}"

while [[ $# -gt 0 ]]; do
	case "$1" in
	--with-extras)
		RUN_EXTRA_TOOLS=1
		shift
		;;
	-h | --help)
		cat <<'EOF'
Usage: ./scripts/ubuntu/install-packages.sh [--with-extras]

Installs Ubuntu packages used by these dotfiles.

Options:
  --with-extras    Also run the optional language and tooling helpers.
EOF
		exit 0
		;;
	*)
		dotfiles_error "Unknown argument: $1"
		;;
	esac
done

dotfiles_require_command sudo
dotfiles_require_command apt-get

packages=(
	ack-grep
	apt-transport-https
	bat
	bash-completion
	build-essential
	ca-certificates
	clang
	curl
	fd-find
	fish
	fontconfig
	fzf
	git
	git-core
	git-doc
	git-man
	gnupg
	golang-go
	htop
	jq
	libnotify-bin
	luarocks
	python3-dev
	python3-pip
	python3-venv
	ripgrep
	screen
	tmux
	unzip
	vim
	wget
	xclip
)

dotfiles_log "Updating apt metadata"
sudo apt-get update

dotfiles_log "Installing base Ubuntu packages"
sudo apt-get install -y "${packages[@]}"

if command -v fc-cache >/dev/null 2>&1; then
	dotfiles_log "Refreshing font cache"
	fc-cache -fv
fi

dotfiles_log "Package install complete"
