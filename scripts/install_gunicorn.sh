#!/bin/bash

if command -v /virtualenvs/onesim/bin/gunicorn >/dev/null 2>&1; then
    echo -e "${orange}----> GUnicorn is already installed${end}"
else
    echo -e "${green}----> Installing GUnicorn${end}"

    sudo apt-get install libpq-dev postgresql-common postgresql-client python3-dev python3-pip -y

    sudo pip3 install virtualenv

    sudo mkdir /var/log/gunicorn

    sudo chown vagrant:vagrant /var/log/gunicorn

    sudo mkdir /run

    sudo mkdir /run/gunicorn

    sudo chown vagrant:vagrant /run/gunicorn

    mkdir /virtualenvs

    sudo chown vagrant:vagrant /virtualenvs

    cd /virtualenvs

    virtualenv onesim

    source onesim/bin/activate

    pip3 install gunicorn

    pip3 install --no-cache-dir -r /vagrant/var/sources/requirements.txt

    #cd /vagrant/var/www
    #
    #/virtualenvs/onesim/bin/gunicorn --bind 0.0.0.0:8000 server:app

    deactivate

fi

# copy the service
sudo unlink /etc/systemd/system/gunicorn.service || true
sudo /bin/cp -f /vagrant/var/config/gunicorn/gunicorn.service /etc/systemd/system/gunicorn.service

sudo systemctl enable gunicorn

sudo systemctl start gunicorn