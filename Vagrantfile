Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/focal64'
  config.vm.hostname = 'dev'
  config.vm.provider "virtualbox" do |v|
    v.cpus = 2
    v.memory = 4096
  end
  config.vm.synced_folder '~/cfengine', '/cfengine'
  config.vm.provision "shell", inline: <<-SHELL
    # packages
    apt-get update
    apt-get upgrade -y
    xargs --arg-file=/vagrant/packages apt-get install -y
    apt-get install -y python3 python3-pip
    pip3 install cfbs cf-remote
    apt-get autoremove -y
    apt-get clean -y

    # dotfiles
    cp -rf /vagrant/dotfiles/. ~/
    runuser -l vagrant -c "cp -rf /vagrant/dotfiles/. ~/"
  SHELL

  config.vm.define "hub" do |hub|
    hub.vm.hostname = "hub"
    hub.vm.network "private_network", ip: "192.168.56.10"
    hub.vm.network :forwarded_port, guest: 443, host: 9002
  end

  config.vm.define "host" do |host|
    host.vm.hostname = "host"
    host.vm.network "private_network", ip: "192.168.56.11"
  end

end
