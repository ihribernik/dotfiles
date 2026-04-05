#!/usr/bin/env bash

set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=scripts/common/helpers.sh
source "${BASEDIR}/scripts/common/helpers.sh"

dotfiles_require_command sudo
dotfiles_require_command apt-get

packages=(
    ack-grep
    apt-transport-https
    bat
    build-essential
    ca-certificates
    clang
    curl
    fd-find
    fish
    git
    git-core
    git-doc
    git-man
    htop
    jq
    luarocks
    python3-dev
    python3-pip
    python3-venv
    ripgrep
    screen
    tmux
    vim
    xclip
)

dotfiles_log "Updating apt metadata"
sudo apt-get update

dotfiles_log "Installing base Ubuntu packages"
sudo apt-get install -y "${packages[@]}"

if [[ -x "${BASEDIR}/scripts/ubuntu/nvm_setup.sh" ]]; then
    dotfiles_log "Running nvm bootstrap helper"
    "${BASEDIR}/scripts/ubuntu/nvm_setup.sh"
fi

extra_scripts=(
    "${BASEDIR}/scripts/ubuntu/golang.sh"
    "${BASEDIR}/scripts/ubuntu/docker.sh"
    "${BASEDIR}/scripts/ubuntu/nvim.sh"
    "${BASEDIR}/scripts/ubuntu/fzf.sh"
)

if [[ "${RUN_EXTRA_TOOLS:-0}" == "1" ]]; then
    for script in "${extra_scripts[@]}"; do
        if [[ -x "${script}" ]]; then
            dotfiles_log "Running extra bootstrap script $(basename "${script}")"
            "${script}"
        fi
    done
else
    dotfiles_log "Skipping extra tool installers. Set RUN_EXTRA_TOOLS=1 to run Go/Docker/Neovim/fzf helpers."
fi

if command -v fc-cache >/dev/null 2>&1; then
    dotfiles_log "Refreshing font cache"
    fc-cache -fv
fi

dotfiles_log "Bootstrap complete"
