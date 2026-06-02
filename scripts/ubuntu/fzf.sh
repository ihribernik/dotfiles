#!/usr/bin/env bash

set -euo pipefail

if [[ ! -d "$HOME/dev/personal/fzf" ]]; then
    git clone https://github.com/junegunn/fzf.git "$HOME/dev/personal/fzf"
fi

cd "$HOME/dev/personal/fzf"
git pull --ff-only
./install --key-bindings --completion --no-bash --no-update-rc
