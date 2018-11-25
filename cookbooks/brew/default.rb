execute 'brew' do
  command 'brew cleanup'
  command 'brew update'
end

packages = %w(
  bash-completion
  ghq
  git
  go
  lv
  mercurial
  peco
  python3
  rbenv
  readline
  ruby-build
  the_platinum_searcher
  tig
  tmux reattach-to-user-namespace
  tree
  vim\ --with-lua
  wget
)
packages.map(&:split).each do |pkg, *opts|
  package pkg do
    options opts.join(' ') unless opts.empty?
  end
end

execute 'brew cleanup' do
  command 'brew cleanup'
end
