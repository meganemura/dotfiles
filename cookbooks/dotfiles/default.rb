home_dir = File.expand_path('~')
repository_root = File.expand_path('../../../', __FILE__)

%w(
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
  .config
).each do |target|
  link "#{home_dir}/#{target}" do
    to "#{repository_root}/#{target}"
    force
  end
end
