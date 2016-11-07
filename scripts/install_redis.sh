#!/bin/bash

if command -v redis-server >/dev/null 2>&1; then
    echo -e "${orange}----> Redis is already installed${end}"
else
    echo -e "${green}----> Installing Redis${end}"

    sudo apt-get install build-essential tcl -y

    cd /tmp

    curl -O http://download.redis.io/releases/redis-3.2.5.tar.gz

    tar xzvf redis-3.2.5.tar.gz

    cd redis-3.2.5

    make

    make test

    sudo make install

    sudo adduser --system --group --no-create-home redis

    sudo mkdir /var/lib/redis

    sudo mkdir /etc/redis

    sudo mkdir /run

    sudo mkdir /run/redis
fi

#sudo chown redis:redis /var/lib/redis

sudo chmod 777 /var/lib/redis

#sudo chown redis:redis /etc/redis

sudo chmod 777 /etc/redis


sudo chmod 777 /run/redis

# copy the conf file
sudo unlink /etc/systemd/system/redis.service || true
sudo /bin/cp -f /vagrant/var/config/redis/redis.service /etc/systemd/system/redis.service

# copy the service
#sudo unlink /etc/redis/redis.conf || true
#sudo /bin/cp -f /vagrant/var/config/redis/redis.conf /etc/redis/redis.conf

sudo systemctl enable redis

sudo systemctl start redis