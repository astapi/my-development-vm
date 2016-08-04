#git '~/dotfiles' do
#  repository "git://github.com/astapi/dotfiles.git"
#end

execute 'clone' do
  command "git clone git://github.com/astapi/dotfiles.git \
           && chown vagrant:vagrant dotfiles \
          "
  not_if "test -e ~/dotfiles"
end

execute 'setup dotfiles' do
  command "\
    cd ~/dotfiles && \
    chmod 777 ./install.sh && \
    ./install.sh \
  "
  not_if "ls ~/.vimrc"
end

