#!/bin/bash -e

DOTFILES_ROOT=$(cd $(dirname $0); pwd)

dotfiles=(
    .bash_aliases
    .bash_functions
    .gemrc
    .git_aliases
    .git_ghq
    .npmrc
    .pryrc
    .screenrc
    .tigrc
    .tmux.conf
    .vim
    .vimrc
)
for dotfile in ${dotfiles[@]}; do
    ln -s $DOTFILES_ROOT/$dotfile ~/$dotfile || true
done
