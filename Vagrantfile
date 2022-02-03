Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/focal64'
  config.vm.hostname = 'dev'
  config.vm.provider "virtualbox" do |v|
    v.name = 'dev'
    v.memory = 2048
  end
  config.vm.synced_folder '~/cfengine', '/cfengine'
  config.vm.provision "shell", inline: <<-SHELL
    # packages
    apt-get update
    apt-get upgrade -y
    xargs --arg-file=/vagrant/packages apt-get install -y
    apt-get autoremove -y
    apt-get clean -y

    # dotfiles
    cp -f /vagrant/.vimrc ~/
    cp -f /vagrant/.bash_profile ~/
    runuser -l vagrant -c "cp -f /vagrant/.vimrc ~/"
    runuser -l vagrant -c "cp -f /vagrant/.bash_profile ~/"
  SHELL
end
