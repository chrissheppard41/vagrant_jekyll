#!/usr/bin/env bash

echo "---------------------------------------"
echo "         MYSQL Setup 5.6"
echo "---------------------------------------"
PASSWORD='password'

# install mysql and give password to installer
sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password_again password password'
sudo apt-get -y install mysql-server libapache2-mod-auth-mysql php7.0-mysql

mysql --version