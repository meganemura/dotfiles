#!/bin/sh
set -e

DOTFILES_ROOT=$(dirname $0)
cd $DOTFILES_ROOT

# Dotfiles
# ========
dotfiles=(
    .gemrc
    .vimrc
    .vim
    .tmux.conf
    .screenrc
)
for dotfile in ${dotfiles[@]}; do
    ln -s $DOTFILES_ROOT/$dotfile ~/$dotfile || true
done

# Vim
# ===
VIM_ROOT=$DOTFILES_ROOT/.vim

for tmpdir in bundle tmp; do
    rm -rf $VIM_ROOT/$tmpdir
    mkdir -p $VIM_ROOT/$tmpdir
done

git submodule init
git submodule update

# vim -c "silent! NeoBundleInstall" -c quit
vim -c "NeoBundleInstall" -c quit
cd $VIM_ROOT/bundle/vimproc
case "$(uname)" in
    "Linux"  ) make -f make_unix.mak ;;
    "Darwin" ) make -f make_mac.mak ;;
esac
cd -
