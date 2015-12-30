package 'zsh' do
  action :install
end

remote_file '/home/vagrant/.zshrc' do
  source "../common/zshrc"
end

directory '/home/vagrant/.vim' do
  action :create
  user 'vagrant'
end

directory '/home/vagrant/.vim/bundle' do
  action :create
  user 'vagrant'
end

git '/home/vagrant/.vim/bundle/neobundle.vim' do
  repository "git://github.com/Shougo/neobundle.vim.git"
  user 'vagrant'
end

remote_file '/home/vagrant/.vimrc' do
  source "../common/vimrc"
end
