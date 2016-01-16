package 'zsh' do
  action :install
  not_if 'which zsh'
end

# for vagrant
execute 'change login shell' do
  command 'chsh -s /usr/bin/zsh vagrant'
end

