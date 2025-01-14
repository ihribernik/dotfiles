#!/usr/bin/bash

git clone git@github.com:junegunn/fzf.git $HOME/dev/personal/fzf
cd $HOME/dev/personal/fzf
sudo make clean
sudo make install