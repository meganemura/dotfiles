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
    .screenrc
    .tmux.conf
    .vim
    .vimrc
)
for dotfile in ${dotfiles[@]}; do
    ln -sfh $DOTFILES_ROOT/$dotfile ~/$dotfile || true
done

# Vim
# ===
echo "setup vim (this may take a while)"
VIM_ROOT=$DOTFILES_ROOT/.vim

for tmpdir in tmp undo; do
    rm -rf $VIM_ROOT/$tmpdir
    mkdir -p $VIM_ROOT/$tmpdir
done

mkdir -p $VIM_ROOT/bundle
git submodule init
git submodule update

vim -c "silent! NeoBundleInstall" -c quit > /dev/null 2>&1

(
  cd $VIM_ROOT/bundle/vimproc
  case "$(uname)" in
      "Linux"  ) make -f make_unix.mak ;;
      "Darwin" ) make -f make_mac.mak ;;
  esac
) > /dev/null

echo "Finished!"
