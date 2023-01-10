#!/usr/bin/env bash

dir="$(pwd)"

ln -s "$dir"/fish ~/.config/fish
ln -s "$dir"/emacs/init.el ~/.emacs.d/init.el
# ln -s "$dir"/nvim/init.vim ~/.config/nvim/init.vim
ln -s "$dir"/nvim/init.lua ~/.config/nvim/init.lua
