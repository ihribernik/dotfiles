#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

source "${DOTFILES_DIR}/common/helpers.sh"

dotfiles_log "Installing extra packages from ${SCRIPT_DIR}"

source "${SCRIPT_DIR}/docker.sh"
source "${SCRIPT_DIR}/kubectl.sh"
source "${SCRIPT_DIR}/lazygit.sh"
source "${SCRIPT_DIR}/nvim.sh"
source "${SCRIPT_DIR}/rustup.sh"

dotfiles_log "done with extra packages"
