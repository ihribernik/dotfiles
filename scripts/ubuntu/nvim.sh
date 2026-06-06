#!/usr/bin/env bash

set -euo pipefail

sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential

if [[ ! -d "$HOME/dev/personal/neovim/.git" ]]; then
	git clone https://github.com/neovim/neovim "$HOME/dev/personal/neovim"
fi

cd "$HOME/dev/personal/neovim"
git fetch --tags origin
git checkout stable
git pull --ff-only origin stable
make CMAKE_BUILD_TYPE=Release
sudo make install
