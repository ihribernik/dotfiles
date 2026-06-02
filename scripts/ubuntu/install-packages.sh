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
        -h|--help)
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
    git
    git-core
    git-doc
    git-man
    gnupg
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

if [[ -x "${BASEDIR}/scripts/ubuntu/nvm_setup.sh" ]]; then
    dotfiles_log "Running nvm helper"
    "${BASEDIR}/scripts/ubuntu/nvm_setup.sh"
fi

run_helper_script() {
    local script="$1"

    if [[ ! -e "${script}" ]]; then
        dotfiles_log "Skipping missing helper $(basename "${script}")"
        return 0
    fi

    if [[ ! -s "${script}" ]]; then
        dotfiles_log "Skipping empty helper $(basename "${script}")"
        return 0
    fi

    if [[ ! -x "${script}" ]]; then
        dotfiles_log "Skipping non-executable helper $(basename "${script}")"
        return 0
    fi

    dotfiles_log "Running extra script $(basename "${script}")"
    "${script}"
}

extra_scripts=(
    "${BASEDIR}/scripts/ubuntu/golang.sh"
    "${BASEDIR}/scripts/ubuntu/docker.sh"
    "${BASEDIR}/scripts/ubuntu/nvim.sh"
    "${BASEDIR}/scripts/ubuntu/fzf.sh"
    "${BASEDIR}/scripts/ubuntu/kubectl.sh"
    "${BASEDIR}/scripts/ubuntu/lazygit.sh"
    "${BASEDIR}/scripts/ubuntu/minikube.sh"
    "${BASEDIR}/scripts/ubuntu/rustup.sh"
    "${BASEDIR}/scripts/ubuntu/kind.sh"
)

if [[ "${RUN_EXTRA_TOOLS}" == "1" ]]; then
    for script in "${extra_scripts[@]}"; do
        run_helper_script "${script}"
    done
else
    dotfiles_log "Skipping extra installers. Use --with-extras or set RUN_EXTRA_TOOLS=1 to run them."
fi

if command -v fc-cache >/dev/null 2>&1; then
    dotfiles_log "Refreshing font cache"
    fc-cache -fv
fi

dotfiles_log "Package install complete"
