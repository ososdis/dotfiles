#!/bin/bash
# ADD DOTFILES

shopt -s expand_aliases
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
cd ~/
config add .bashrc .vimrc .astylerc conf-scripts
