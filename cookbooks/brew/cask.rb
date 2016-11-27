execute 'brew' do
  command 'brew cask cleanup'
end

casks = %w(
  google-chrome
  google-japanese-ime
  iterm2
)
casks.each do |app|
  cask app
end

