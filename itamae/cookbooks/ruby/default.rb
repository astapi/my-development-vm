%w(libffi-dev build-essential libffi-dev libssl-dev libreadline-dev zlib1g-dev ruby-dev).each do |name|
  package name do
    action :install
  end
end

RBENV_DIR = "/usr/local/rbenv"
RBENV_SCRIPT = "/etc/profile.d/rbenv.sh"

git RBENV_DIR do
  repository "git://github.com/sstephenson/rbenv.git"
end

remote_file RBENV_SCRIPT do
  source "../common/rbenv.sh"
end

execute "set owner and mode for #{RBENV_SCRIPT} " do
  command "chown root: #{RBENV_SCRIPT}; chmod 644 #{RBENV_SCRIPT}"
  user "root"
end

execute "set owner and mode for #{RBENV_DIR} " do
  command "chmod 777 #{RBENV_DIR}"
  user "root"
end

execute "mkdir #{RBENV_DIR}/plugins" do
  not_if "test -d #{RBENV_DIR}/plugins"
end

git "#{RBENV_DIR}/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
end

node["rbenv"]["versions"].each do |version|
  execute "install ruby #{version}" do
    command ". #{RBENV_SCRIPT}; rbenv install #{version}"
    not_if ". #{RBENV_SCRIPT}; rbenv versions | grep #{version}"
  end
end

execute "change owner" do
  user "root"
  command "chown -R #{node["user"]}:#{node["user"]} #{RBENV_DIR}"
end

execute "set global ruby #{node["rbenv"]["global"]}" do
  user node["user"]
  command ". #{RBENV_SCRIPT}; rbenv global #{node["rbenv"]["global"]}; rbenv rehash"
  not_if ". #{RBENV_SCRIPT}; rbenv global | grep #{node["rbenv"]["global"]}"
end

node["rbenv"]["gems"].each do |gem|
  execute "gem install #{gem}" do
    user node["user"]
    command ". #{RBENV_SCRIPT}; rbenv exec gem install #{gem}; rbenv rehash"
    not_if ". #{RBENV_SCRIPT}; rbenv exec gem list | grep #{gem}"
  end
end

