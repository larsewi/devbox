Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/focal64'
  config.vm.hostname = 'dev'
  config.vm.provider "virtualbox" do |v|
    v.cpus = 2
    v.memory = 4096
  end
  config.vm.synced_folder '~/ntech/', '/ntech/'
  config.vm.provision "shell", path: "setup.sh"

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
