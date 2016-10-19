#!/bin/bash

sudo apt-get install libpq-dev python3-dev python3-pip -y

sudo pip3 install virtualenv

cd /virtualenvs

virtualenv onesim

source onesim/bin/activate

pip3 install gunicorn

pip3 install --no-cache-dir -r /vagrant/var/sources/requirements.txt

#cd /vagrant/var/www
#
#/virtualenvs/onesim/bin/gunicorn --bind 0.0.0.0:8000 server:app

deactivate