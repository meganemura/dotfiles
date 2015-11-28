require "itamae/plugin/resource/cask"

execute 'brew' do
  command 'brew update'
  command 'brew upgrade'
end

packages = %w(
  bash-completion
  git hub
  go
  heroku-toolbelt
  lv
  mercurial
  mysql
  node
  postgresql
  the_platinum_searcher
  rbenv
  readline
  ruby-build
  scala giter8
  tig
  tmux reattach-to-user-namespace
  tree
  vim\ --with-lua
  wget
  caskroom/cask/brew-cask
)
packages.map(&:split).each do |pkg, *opts|
  package pkg do
    options opts.join(' ') unless opts.empty?
  end
end

casks = %w(
  virtualbox vagrant
  chefdk
  google-chrome
  google-japanese-ime
  iterm2
  karabiner
  seil
)
casks.each do |app|
  cask app
end

execute 'brew tap' do
  command 'brew tap peco/peco'
  command 'brew tap motemen/ghq'
end
package 'peco'
package 'ghq'

execute 'brew cleanup' do
  command 'brew cleanup'
end
