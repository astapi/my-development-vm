node.reverse_merge!(
  elixir: {
    repo: 'https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb',
    repo_file: 'erlang-solutions.deb'
  }
)

package 'libssl-dev' do
  action :install
end

execute 'Add Erlang Solutions repo' do
  #cwd node[:common][:config][:file_cache_path]
  cwd '/tmp'
  command "wget -O #{node[:elixir][:repo_file]} #{node[:elixir][:repo]}"
  not_if "test -e ./#{node[:elixir][:repo_file]}"
end

execute 'Add erlang-solutions' do
  #cwd node[:common][:config][:file_cache_path]
  cwd '/tmp'
  command " \
    dpkg -i #{node[:elixir][:repo_file]} && \
    apt-get update
  "
  not_if 'which iex'
end

package 'elixir' do
  action :install
end
