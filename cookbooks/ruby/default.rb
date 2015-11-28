package 'rbenv'

ruby_versions = %w(
  2.1.4
  2.2.3
)

ruby_versions.each do |version|
  execute 'install rubies' do
    command "rbenv install #{version}"
    not_if "rbenv versions --bare | grep #{version}"
  end
end

execute 'rbenv global' do
  command "rbenv global #{ruby_versions.first}"
  not_if "rbenv global | grep #{ruby_versions.first}"
end
