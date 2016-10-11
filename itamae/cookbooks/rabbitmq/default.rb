execute 'add packaege' do
  cwd '/tmp'
  command "\
    echo 'deb http://www.rabbitmq.com/debian/ testing main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list && \
    wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
  "
  not_if 'which rabbitmqctl'
end

execute 'install rabbitmq' do
  cwd '/tmp'
  command " \
    sudo apt-get update && \
    sudo apt-get -y install rabbitmq-server
  "
  not_if 'which rabbitmqctl'
end

template '/etc/default/rabbitmq-server' do
  action :create
  user 'root'
  source 'templates/rabbitmq-server.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'rabbitmq-server' do
  action :restart
  user 'root'
end
