execute 'apt-get update' do
  command 'apt-get update'
end

%w(make gcc unzip git wget libmysql++-dev).each do |name|
  package name do
    action :install
  end
end

file "/etc/localtime" do
  action :delete
end

link "/etc/localtime" do
  to "/usr/share/zoneinfo/Japan"
end

#remote_directory '/home/vagrant/.ssh' do
#  mode '0700'
#  owner 'vagrant'
#  source '~/.ssh'
#end
