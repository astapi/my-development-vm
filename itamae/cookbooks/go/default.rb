#execute 'add repository' do
#  command 'add-apt-repository -y ppa:evarlast/golang1.5'
#  user 'root'
#end
#
#execute 'apt update' do
#  command 'apt-get update'
#  user 'root'
#end

package 'golang' do
  action :install
  not_if 'which go'
end

execute 'add gopath to zshrc' do
  command "echo 'export GOROOT=/usr/local/opt/go/libexec' >> ~/.zshrc && \
    echo 'export GOPATH=$HOME/.go' >> ~/.zshrc && \
    echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> ~/.zshrc \
    "
  not_if "grep ~/.zshrc 'GOROOT'"
end
