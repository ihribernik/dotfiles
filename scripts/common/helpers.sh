#!/usr/bin/env bash

set -euo pipefail

DOTFILES_BACKUP_ROOT="${DOTFILES_BACKUP_ROOT:-$HOME/.dotfiles-backups}"
DOTFILES_RUN_TIMESTAMP="${DOTFILES_RUN_TIMESTAMP:-$(date -u +"%Y%m%dT%H%M%SZ")}"

dotfiles_log() {
	printf '[dotfiles] %s\n' "$*"
}

dotfiles_error() {
	printf '[dotfiles] ERROR: %s\n' "$*" >&2
	exit 1
}

dotfiles_require_command() {
	command -v "$1" >/dev/null 2>&1 || dotfiles_error "Required command not found: $1"
}

dotfiles_ensure_dir() {
	mkdir -p "$1"
}

dotfiles_backup_dir() {
	local backup_dir="${DOTFILES_BACKUP_ROOT}/${DOTFILES_RUN_TIMESTAMP}"
	mkdir -p "${backup_dir}"
	printf '%s\n' "${backup_dir}"
}

dotfiles_same_link() {
	local source="$1"
	local target="$2"

	if [[ -L "${target}" ]]; then
		local current_target
		current_target="$(readlink "${target}")"
		[[ "${current_target}" == "${source}" ]]
		return
	fi

	return 1
}

dotfiles_backup_target() {
	local target="$1"
	local backup_dir backup_target

	[[ -e "${target}" || -L "${target}" ]] || return 0

	backup_dir="$(dotfiles_backup_dir)"
	backup_target="${backup_dir}${target}"

	mkdir -p "$(dirname "${backup_target}")"
	mv "${target}" "${backup_target}"
	dotfiles_log "Backed up ${target} to ${backup_target}"
}

dotfiles_install_link() {
	local source="$1"
	local target="$2"

	[[ -e "${source}" || -L "${source}" ]] || dotfiles_error "Source does not exist: ${source}"

	dotfiles_ensure_dir "$(dirname "${target}")"

	if dotfiles_same_link "${source}" "${target}"; then
		dotfiles_log "Already linked: ${target}"
		return 0
	fi

	if [[ -e "${target}" || -L "${target}" ]]; then
		dotfiles_backup_target "${target}"
	fi

	ln -s "${source}" "${target}"
	dotfiles_log "Linked ${target} -> ${source}"
}
