$script = <<-'SCRIPT'
add-apt-repository ppa:jonathonf/vim
add-apt-repository -y ppa:ondrej/php
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
bash /tmp/nodesource_setup.sh
apt-get update
apt-get install -y --autoremove autoconf libtool build-essential gdb automake \
    valgrind git net-tools libssl-dev libpcre3 libpcre3-dev bison flex nodejs \
    libbison-dev libacl1 libacl1-dev libpq-dev lmdb-utils libdb-dev ccls tree \
    liblmdb-dev libpam0g-dev python3 python3-pip vim libtool-bin php7.3-dev
apt-get update
apt-get install -y --allow-unauthenticated --allow-downgrades --allow-remove-essential --allow-change-held-package php7.3-dev
cp -r /vagrant/dotfiles/.vim /home/vagrant/.vim
chown vagrant /home/vagrant/.vim
cp -R /vagrant/dotfiles/.vimrc /home/vagrant/.vimrc
chown vagrant /home/vagrant/.vimrc
echo "timedatectl set-timezone Europe/Oslo" >> ~/.bashrc
echo "export PATH='$PATH:/home/vagrant/.local/bin'" >> ~/.bashrc
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |v|
    v.cpus = 4
    v.memory = 4096
    v.gui = false
  end
  config.vm.synced_folder '~/ntech/', '/ntech/'

  config.vm.provision "shell" do |s|
      ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
      s.inline = <<-SHELL
        echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
        echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
      SHELL
    end

  config.vm.define "hub" do |hub|
    hub.vm.box = 'ubuntu/jammy64'
    hub.vm.hostname = "hub"
    hub.vm.network "private_network", ip: "192.168.56.10"
    hub.vm.network :forwarded_port, guest: 443, host: 9002
    hub.vm.provision "shell", inline: $script
  end

  config.vm.define "client" do |client|
    client.vm.box = 'ubuntu/jammy64'
    client.vm.hostname = "client"
    client.vm.network "private_network", ip: "192.168.56.11"
  end
end
