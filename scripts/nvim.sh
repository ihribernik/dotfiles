#!/usr/bin/bash

sudo apt-get install ninja-build gettext cmake unzip curl build-essential -y
git clone https://github.com/neovim/neovim $HOME/dev/personal/neovim
cd $HOME/dev/personal/neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install