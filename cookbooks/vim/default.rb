vim_dir = File.expand_path('~/.vim')
repository_root = File.expand_path('../../../', __FILE__)

directory "#{vim_dir}/bundle"

execute 'git submodule' do
  cwd repository_root
  command 'git submodule init'
  command 'git submodule update'
end

execute 'NeoBundleInstall' do
  command 'vim -c "silent! NeoBundleInstall" -c quit > /dev/null 2>&1'
end

execute 'vimproc: make' do
  cwd "#{vim_dir}/bundle/vimproc"
  case node[:platform]
  when 'darwin' then command 'make -f make_mac.mak'
  when 'linux' then command 'make -f make_unix.mak'
  end
end
