node.reverse_merge!(
  elixir: {
    zip: 'https://github.com/elixir-lang/elixir/releases/download/v1.2.4/Precompiled.zip',
    zip_file: 'Precompiled.zip'
  }
)

%w(libssl-dev inotify-tools).each do |lib|
  package lib do
    action :install
  end
end

execute 'Download elixir' do
  cwd '/tmp'
  command "wget #{node[:elixir][:zip]}"
  not_if "test -e ./#{node[:elixir][:zip_file]}"
end

execute 'unzip elixir' do
  cwd '/tmp'
  command "\
    sudo unzip #{node[:elixir][:zip_file]} -d /opt/elixir
  "
  not_if 'which iex'
end

execute 'setup path' do
  command "\
    echo 'export PATH=/opt/elixir/bin:$PATH' >> ~/.zshrc && \
    echo 'export PATH=/opt/elixir/bin:$PATH' >> ~/.bashrc \
  "
  not_if 'grep ~/.zshrc elixir'
end
