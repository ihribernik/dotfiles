#!/usr/bin/env bash

set -euo pipefail

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

if [[ ! -s "${NVM_DIR}/nvm.sh" ]]; then
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | PROFILE=/dev/null bash
fi

# shellcheck source=/dev/null
source "${NVM_DIR}/nvm.sh"

nvm install --lts
nvm alias default "lts/*"
nvm use --lts
npm install -g tree-sitter-cli
