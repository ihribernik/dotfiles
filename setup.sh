#!/usr/bin/env bash

set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

RUN_BOOTSTRAP=1
RUN_INSTALL=1
PACKAGE_ARGS=()
INSTALL_ARGS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        --with-extras)
            PACKAGE_ARGS+=("--with-extras")
            shift
            ;;
        --include-optional)
            INSTALL_ARGS+=("--include-optional")
            shift
            ;;
        --skip-packages)
            RUN_BOOTSTRAP=0
            shift
            ;;
        --skip-install)
            RUN_INSTALL=0
            shift
            ;;
        -h|--help)
            cat <<'EOF'
Usage: ./setup.sh [--with-extras] [--include-optional] [--skip-packages] [--skip-install]

Runs the full Ubuntu setup flow for this repo.

Options:
  --with-extras       Also run optional Ubuntu tooling helpers.
  --include-optional  Install optional app-specific configs.
  --skip-packages     Skip package installation and only run dotfile install.
  --skip-install      Skip dotfile install and only run bootstrap.
EOF
            exit 0
            ;;
        *)
            printf '[dotfiles] ERROR: Unknown argument: %s\n' "$1" >&2
            exit 1
            ;;
    esac
done

if [[ "${RUN_BOOTSTRAP}" -eq 1 ]]; then
    "${BASEDIR}/scripts/ubuntu/install-packages.sh" "${PACKAGE_ARGS[@]}"
fi

if [[ "${RUN_INSTALL}" -eq 1 ]]; then
    "${BASEDIR}/install.sh" "${INSTALL_ARGS[@]}"
fi
