#!/usr/bin/bash

if [ ! -d $HOME/dev/personal/fzf ]; then
	git clone git@github.com:junegunn/fzf.git $HOME/dev/personal/fzf
fi

cd $HOME/dev/personal/fzf
sudo make clean
sudo ./install --key-bindings --completion --no-bash