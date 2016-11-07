#!/bin/bash

if command -v psql >/dev/null 2>&1; then
    echo -e "${orange}----> PostgreSQL is already installed${end}"
else
    echo -e "${green}----> Installing PostgreSQL${end}"

    sudo apt-get install postgresql postgresql-contrib -y
fi

sudo -u postgres psql -c "CREATE DATABASE onesim;"

sudo -u postgres psql -c "CREATE USER onepro WITH PASSWORD '0nepr0_2016';"

sudo -u postgres psql -c "ALTER ROLE onepro SET client_encoding TO 'utf8';"

sudo -u postgres psql -c "ALTER ROLE onepro SET default_transaction_isolation TO 'read committed';"

sudo -u postgres psql -c "ALTER ROLE onepro SET timezone TO 'America/Monterrey';"

sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE onesim TO onepro;"

sudo systemctl enable postgresql