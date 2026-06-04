#!/usr/bin/env bash

set -euo pipefail



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
  npm
  nodejs
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
