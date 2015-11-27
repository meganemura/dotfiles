execute 'Disable OS X Dashboard' do
  # To enable this, run `defaults delete com.apple.dashboard mcx-disabled`
  command 'defaults write com.apple.dashboard mcx-disabled -boolean true'
  command 'killall Dock'
end
