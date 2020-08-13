#!/bin/bash
# ADD DOTFILES

shopt -s expand_aliases
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

cd ~/
config add .bashrc .vimrc .astylerc conf-scripts

cd .config
config add awesome Code sublime-text-3 gtk-2.0 gtk-3.0 guake powerline-shell

cd ~/.local/share
config add color-schemes konsole
