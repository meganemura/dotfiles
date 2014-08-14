#!/bin/bash
set -e

# Home directory
mkdir -p $HOME/bin
mkdir -p $HOME/projects

DOTFILES_ROOT=$(cd $(dirname $0); pwd)
cd $DOTFILES_ROOT

# Dotfiles
# ========
dotfiles=(
    .bash_aliases
    .bash_functions
    .gemrc
    .git_aliases
    .git_ghq
    .screenrc
    .tmux.conf
    .vim
    .vimrc
)
for dotfile in ${dotfiles[@]}; do
    ln -sfh $DOTFILES_ROOT/$dotfile ~/$dotfile || true
done
