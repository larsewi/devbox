$script = <<-'SCRIPT'
sudo add-apt-repository ppa:jonathonf/vim
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
apt-get update
apt-get install -y --autoremove build-essential gdb automake autoconf libtool \
    valgrind git net-tools libssl-dev libpcre3 libpcre3-dev bison flex \
    libbison-dev libacl1 libacl1-dev libpq-dev lmdb-utils libdb-dev \
    liblmdb-dev libpam0g-dev python3 python3-pip ccls vim nodejs tree
cp -r /vagrant/dotfiles/.vim /home/vagrant/.vim
chown vagrant /home/vagrant/.vim
cp -R /vagrant/dotfiles/.vimrc /home/vagrant/.vimrc
chown vagrant /home/vagrant/.vimrc
vim +PlugInstall +qall
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |v|
    v.cpus = 2
    v.memory = 4096
    v.gui = false
  end
  config.vm.synced_folder '~/ntech/', '/ntech/'

  config.vm.define "hub" do |hub|
    hub.vm.box = 'ubuntu/jammy64'
    hub.vm.hostname = "hub"
    hub.vm.network "private_network", ip: "192.168.56.10"
    hub.vm.network :forwarded_port, guest: 443, host: 9002
    hub.vm.provision "shell", inline: $script
  end

  config.vm.define "host" do |host|
    host.vm.box = 'ubuntu/jammy64'
    host.vm.hostname = "host"
    host.vm.network "private_network", ip: "192.168.56.11"
    host.vm.provision "shell", inline: $script
  end
end
