#!/bin/bash

red='\e[0;31m'
orange='\e[0;33m'
green='\e[0;32m'
end='\e[0m'

# sudo export DEBIAN_FRONTEND=noninteractive

# if puppet is already installed do nothing
if command -v puppet >/dev/null 2>&1; then
  echo -e "${orange}----> Puppet is already installed${end}"
  echo -e "----> ${green}Re-running Librarian-Puppet (install new puppet packages if there is any)${end}"
  cd /vagrant
  librarian-puppet install --verbose --path=../puppet_modules
  exit 0
fi

sudo apt-get update

if command -v ruby >/dev/null 2>&1; then
  echo -e "${orange}----> Ruby is already installed${end}"
  # just install puppet
else
  echo -e "----> ${green}Installing ruby${end}"
  #### Compile from the source code
  #  sudo apt-get install -y build-essential libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison
  #  cd /tmp
  #  wget ftp://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.9.tar.gz
  #  sudo tar xfz ruby-2.1.9.tar.gz
  #  cd ruby-2.1.9
  #  sudo ./configure
  #  sudo make >/dev/null
  #  sudo make install >/dev/null
  #  for i in erb gem irb rake rdoc ri ruby testrb
  #  do
  #    sudo ln -sf /usr/bin/${i}2.1 /usr/bin/${i}
  #  done

  #### Install with RVM
  sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  cd /tmp
  curl -sSL https://get.rvm.io | sudo bash -s stable
  ### Required by RVM
  sudo usermod -aG rvm vagrant
  source /etc/profile.d/rvm.sh
  sleep 2s
  rvm install 2.1.9
  rvm use 2.1.9 --default
  gem update --system
fi

# Install puppet/facter/librarian-puppet
echo -e "----> ${green}Installing puppet${end}"
gem install librarian-puppet
gem install puppet -v 3.7.5 --no-ri --no-rdoc
gem install facter --no-ri --no-rdoc
mkdir /puppet_modules
mkdir /virtualenvs
sudo chown vagrant:vagrant /virtualenvs
cd /vagrant
librarian-puppet install --verbose --path=../puppet_modules