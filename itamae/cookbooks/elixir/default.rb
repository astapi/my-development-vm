node.reverse_merge!(
  elixir: {
    repo: 'https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb',
    repo_file: 'erlang-solutions.deb'
  }
)

node.reverse_merge!(
  elixir: {
    zip: 'https://github.com/elixir-lang/elixir/releases/download/v1.2.0/Precompiled.zip',
    zip_file: 'Precompiled.zip'
  }
)

%w(libssl-dev inotify-tools).each do |lib|
  package lib do
    action :install
  end
end

#execute 'Add Erlang Solutions repo' do
#  #cwd node[:common][:config][:file_cache_path]
#  cwd '/tmp'
#  command "wget -O #{node[:elixir][:repo_file]} #{node[:elixir][:repo]}"
#  not_if "test -e ./#{node[:elixir][:repo_file]}"
#end
#
#execute 'Add erlang-solutions' do
#  #cwd node[:common][:config][:file_cache_path]
#  cwd '/tmp'
#  command " \
#    dpkg -i #{node[:elixir][:repo_file]} && \
#    apt-get update
#  "
#  not_if 'which iex'
#end
#
#package 'elixir' do
#  action :install
#end

execute 'Download elixir' do
  cwd '/tmp'
  command "wget #{node[:elixir][:zip]}"
  not_if "test -e ./#{node[:elixir][:zip_file]}"
end

execute 'unzip elixir and setup path' do
  cwd '/tmp'
  command "\
    sudo unzip #{node[:elixir][:zip_file]} -d /opt/elixir && \
    echo 'export PATH=/opt/elixir/bin:$PATH' >> ~/.zshrc \
    echo 'export PATH=/opt/elixir/bin:$PATH' >> ~/.bashrc \
  "
  not_if 'which iex'
end
