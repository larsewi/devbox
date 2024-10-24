$script = <<-'SCRIPT'
apt-get update
apt-get install -y --autoremove autoconf libtool build-essential \
  gdb automake valgrind git liblmdb-dev libpcre2-dev libpam0g-dev \
  flex bison
cp -r /vagrant/dotfiles/.vim /home/vagrant/.vim
chown vagrant /home/vagrant/.vim
cp -R /vagrant/dotfiles/.vimrc /home/vagrant/.vimrc
chown vagrant /home/vagrant/.vimrc
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |v|
    v.cpus = 4
    v.memory = 4096
    v.gui = false
  end
  config.vm.synced_folder '~/ntech/cfengine', '/ntech/cfengine'

  config.vm.provision "shell" do |s|
      ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_ed25519.pub").first.strip
      s.inline = <<-SHELL
        echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
        echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
      SHELL
    end

  config.vm.define "hub" do |hub|
    hub.vm.box = 'alvistack/ubuntu-24.04'
    hub.vm.hostname = "hub"
    hub.vm.network "private_network", ip: "192.168.56.10"
    hub.vm.network :forwarded_port, guest: 443, host: 9002
    hub.vm.provision "shell", inline: $script
  end

  # config.vm.define "client" do |client|
  #   client.vm.box = 'ubuntu/jammy64'
  #   client.vm.hostname = "client"
  #   client.vm.network "private_network", ip: "192.168.56.11"
  # end
end
