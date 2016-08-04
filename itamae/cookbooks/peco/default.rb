execute 'Download peco' do
  cwd '/tmp'
  command "wget -O https://github.com/peco/peco/releases/download/v0.3.6/peco_linux_amd64.tar.gz"
  not_if 'which peco'
end

execute 'install' do
  cwd '/tmp'
  command "tar zxvf peco_linux_amd64.tar.gz \
    && cd peco_linux_amd64 \
    && cp peco /usr/loca/bin"
  not_if 'which peco'
end
