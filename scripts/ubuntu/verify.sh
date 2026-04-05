#!/usr/bin/env bash

set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# shellcheck source=scripts/common/helpers.sh
source "${BASEDIR}/scripts/common/helpers.sh"

check_link() {
    local target="$1"
    local source="$2"

    if dotfiles_same_link "${source}" "${target}"; then
        dotfiles_log "OK ${target}"
        return 0
    fi

    dotfiles_error "Expected ${target} -> ${source}"
}

check_link "$HOME/.gitconfig" "${BASEDIR}/dotfiles/git/.gitconfig"
check_link "$HOME/.gitconfig_work" "${BASEDIR}/dotfiles/git/.gitconfig_work"
check_link "$HOME/.editorconfig" "${BASEDIR}/dotfiles/.editorconfig"
check_link "$HOME/.tmux.conf" "${BASEDIR}/dotfiles/tmux/.tmux.conf"
check_link "$HOME/.bash_aliases" "${BASEDIR}/dotfiles/bash/.bash_aliases"
check_link "$HOME/.bash_personal" "${BASEDIR}/dotfiles/bash/.bash_personal"
check_link "$HOME/.bashrc" "${BASEDIR}/dotfiles/bash/.bashrc"
check_link "$HOME/.config/nvim" "${BASEDIR}/dotfiles/nvim"
check_link "$HOME/.config/fish" "${BASEDIR}/dotfiles/fish"

for dir in "$HOME/dev/personal" "$HOME/dev/work" "$HOME/.config" "$HOME/.local/bin"; do
    [[ -d "${dir}" ]] || dotfiles_error "Missing required directory: ${dir}"
    dotfiles_log "OK ${dir}"
done

dotfiles_log "Verification complete"
