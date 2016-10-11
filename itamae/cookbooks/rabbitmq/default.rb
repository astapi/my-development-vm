execute 'add packaege' do
  cwd '/tmp'
  command "\
    echo 'deb http://www.rabbitmq.com/debian/ testing main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list && \
    wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
  "
end

execute 'install rabbitmq' do
  cwd '/tmp'
  command " \
    sudo apt-get update && \
    sudo apt-get -y install rabbitmq-server
  "
end
