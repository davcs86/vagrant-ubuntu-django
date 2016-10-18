#!/bin/bash

sudo apt-get install libpq-dev python3-dev python3-pip -y

sudo pip3 install virtualenv

cd /vagrant/var/www

virtualenv onesim

source onesim/bin/activate

pip3 install --no-cache-dir -r /vagrant/var/sources/requirements.txt

gunicorn --bind 0.0.0.0:8000 server:app

# deactivate