# Box / OS
VAGRANT_BOX = 'ubuntu/focal64'

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/focal64'
  config.vm.hostname = 'dev'
  config.vm.provider "virtualbox" do |v|
    v.name = 'dev'
    v.memory = 2048
  end
  config.vm.synced_folder '~/cfengine', '/cfengine'
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get upgrade -y
    apt-get install -y git
    apt-get install -y python3 python3-pip
    apt-get install -y build-essential gdb automake autoconf libtool valgrind
    apt-get install -y libssl-dev libpcre3 libpcre3-dev
    apt-get install -y bison libbison-dev libacl1 libacl1-dev libpq-dev
    apt-get install -y lmdb-utils liblmdb-dev libpam0g-dev flex
    apt-get autoremove -y
    apt-get clean -y

    # vim
    echo "set nu" > .vimrc
    echo "set autoindent" >> .vimrc
    echo "syntax on" >> .vimrc
    echo "set tabstop=2" >> .vimrc
    echo "set softtabstop=2" >> .vimrc
    echo "set shiftwidth=2" >> .vimrc
    echo "set expandtab" >> .vimrc

    # paths
    export PATH=$PATH:/var/cfengine/bin/

  SHELL
end