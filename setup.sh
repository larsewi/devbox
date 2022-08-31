#!/bin/bash

sudo add-apt-repository ppa:jonathonf/vim

curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh

apt-get update
apt-get install -y --autoremove \
    build-essential \
    gdb \
    automake \
    autoconf \
    libtool \
    valgrind \
    git \
    net-tools \
    libssl-dev \
    libpcre3 \
    libpcre3-dev \
    bison \
    flex \
    libbison-dev \
    libacl1 \
    libacl1-dev \
    libpq-dev \
    lmdb-utils \
    libdb-dev \
    liblmdb-dev \
    libpam0g-dev \
    python3 \
    python3-pip \
    ccls \
    vim \
    nodejs

pip3 install cfbs cf-remote

cp -r /vagrant/dotfiles/.vim /home/vagrant/.vim
chown vagrant /home/vagrant/.vim

cp -R /vagrant/dotfiles/.vimrc /home/vagrant/.vimrc
chown vagrant /home/vagrant/.vimrc

echo "export PATH=\$PATH:/var/cfengine/bin/" >> /home/vagrant/.bashrc
chown vagrant /home/vagrant/.bashrc
