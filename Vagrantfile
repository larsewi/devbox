$script = <<-'SCRIPT'
apt-get update
apt-get install -y --autoremove autoconf libtool build-essential \
  gdb automake valgrind git liblmdb-dev libpcre2-dev libpam0g-dev \
  flex bison librsync-dev libyaml-dev libacl1-dev libxml2-dev \
  autoconf-archive pkg-config libssl-dev
cp -r /vagrant/dotfiles/.vim /home/vagrant/.vim
chown vagrant /home/vagrant/.vim
cp -R /vagrant/dotfiles/.vimrc /home/vagrant/.vimrc
chown vagrant /home/vagrant/.vimrc
echo "set -o vi" >> /home/vagrant/.bashrc
echo "export VISUAL=vim" >> /home/vagrant/.bashrc
echo "export EDITOR="$VISUAL"" >> /home/vagrant/.bashrc
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

  config.vm.define "cli" do |cli|
    cli.vm.box = 'alvistack/ubuntu-24.04'
    cli.vm.hostname = "cli"
    cli.vm.network "private_network", ip: "192.168.56.11"
    cli.vm.provision "shell", inline: $script
  end
end
