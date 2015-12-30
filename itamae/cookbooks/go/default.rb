execute 'add repository' do
  command 'add-apt-repository ppa:evarlast/golang1.5'
  user 'root'
end

execute 'apt update' do
  command 'apt-get update'
  user 'root'
end

package 'golang' do
  action :install
end
