#!/bin/bash -e

DOTFILES_ROOT=$(cd $(dirname $0); pwd)

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