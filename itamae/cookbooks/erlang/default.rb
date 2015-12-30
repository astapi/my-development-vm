node.reverse_merge!(
  erlang: {
    source: 'http://www.erlang.org/download/otp_src_18.0.tar.gz', 
    source_name: 'otp_src_18.0'
  }
)

%w(libncurses5-dev).each do |name|
  package name do
    action :install
  end
end

execute 'Download erlang' do
  #cwd node[:common][:config][:file_cache_path]
  cwd '/tmp'
  command "wget -O #{node[:erlang][:source_name]}.tar.gz #{node[:erlang][:source]}"
  not_if 'which erl'
end

execute 'Install erlang' do
  #cwd node[:common][:config][:file_cache_path]
  cwd '/tmp'
  command " \
    tar xzf #{node[:erlang][:source_name]}.tar.gz && \
    cd #{node[:erlang][:source_name]} && \
    ./configure && make && \
    make install
  "
  not_if 'which erl'
end

execute 'Remove erlang source' do
  #cwd node[:common][:config][:file_cache_path]
  cwd '/tmp'
  command " \
    rm -rf #{node[:erlang][:source_name]}.tar.gz && \
    rm -rf #{node[:erlang][:source_name]}
  "
end
