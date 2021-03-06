root_dir = File.expand_path('../..', __FILE__)

if node[:platform] == 'darwin'
  include_recipe File.join(root_dir, 'cookbooks', 'mac')
  include_recipe File.join(root_dir, 'cookbooks', 'brew')
end

include_recipe File.join(root_dir, 'cookbooks', 'dotfiles')
include_recipe File.join(root_dir, 'cookbooks', 'vim')
include_recipe File.join(root_dir, 'cookbooks', 'ruby')
