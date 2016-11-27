execute 'Install brew' do
  command '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
  not_if 'which brew'
end

execute 'brew' do
  command 'brew cleanup'
  command 'brew update'
end

packages = %w(
  bash-completion
  git
  go
  heroku-toolbelt
  lv
  mercurial
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
  ghq
)
packages.map(&:split).each do |pkg, *opts|
  package pkg do
    options opts.join(' ') unless opts.empty?
  end
end

execute 'brew tap' do
  command 'brew tap peco/peco'
end
package 'peco'

execute 'brew cleanup' do
  command 'brew cleanup'
end
