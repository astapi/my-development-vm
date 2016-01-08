git '~/dotfiles' do
  repository "git://github.com/tamai/dotfiles.git"
end

execute 'setup dotfiles' do
  command "\
    cd ~/dotfiles && \
    ./install.sh \
  "
  not_if "ls ~/.vimrc"
end

