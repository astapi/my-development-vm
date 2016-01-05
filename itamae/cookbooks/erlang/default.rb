node.reverse_merge!(
  erlang: {
    #source: 'http://www.erlang.org/download/otp_src_18.0.tar.gz', 
    source: 'http://www.erlang.org/download/otp_src_18.2.tar.gz',
    source_name: 'otp_src_18.2'
  }
)

%w(libncurses5-dev libssl-dev build-essential libncurses-dev erlang-jinterface erlang-odbc plplot12-driver-wxwidgets).each do |name|
  package name do
    action :install
  end
end

%w(openjdk-7-jdk m4 unixODBC fop unixodbc-dev libwxbase2.8 libwxgtk2.8-dev libqt4-opengl-dev libgtk2.0-dev xsltproc).each do |name|
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
    touch lib/wx/SKIP && \
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
