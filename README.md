# dotfiles

```bash
# macOS: Install Xcode Command Line Tools
[ $(uname) = 'Darwin' ] && xcode-select --print-path || xcode-select --install

# macOS: Install brew
which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

DOTFILES_DIR="$HOME/src/github.com/meganemura"
mkdir -p $DOTFILES_DIR
git clone https://github.com/meganemura/dotfiles.git $DOTFILES_DIR
cd $DOTFILES_DIR
./install.sh
```
