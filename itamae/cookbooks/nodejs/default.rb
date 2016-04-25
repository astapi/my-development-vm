%w(build-essential).each do |lib|
  package lib do
    action :install
  end
end

execute 'uninstall default nodejs' do
  command "apt-get --purge remove nodejs"
end

execute 'Alternatively' do
  cwd '/tmp'
  command "curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -"
end

%w(nodejs).each do |lib|
  package lib do
    action :install
  end
end
