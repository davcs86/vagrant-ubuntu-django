#!/bin/bash

sudo apt-get update

sudo apt-get upgrade -y

#### Install Ruby 2.1.9 with RVM
#sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
#cd /tmp
#curl -sSL https://get.rvm.io | sudo bash -s stable
#### Required by RVM
#sudo usermod -aG rvm vagrant
#source /etc/profile.d/rvm.sh
#sleep 2s
#rvm install 2.1.9
#rvm use 2.1.9 --default
#gem update --system

sudo ufw allow 22 # allow ssh
sudo ufw allow 8000 # allow gunicorn
sudo ufw allow 80 # allow nginx
sudo ufw allow 6379 # allow redis
sudo ufw allow 5432 # allow postgres

sudo ufw enable
