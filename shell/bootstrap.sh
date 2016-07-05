#!/usr/bin/env bash

#: ${1?"No repo. Set the REPO environment variable and try again!"}
#clonerepo=${1}
#clonedir="/srv/www/$(basename $clonerepo)"

start_seconds="$(date +%s)"

echo "---------------------------------------"
echo " Welcome to the initialization script."
echo "---------------------------------------"

ping_result="$(ping -c 2 8.8.4.4 2>&1)"
if [[ $ping_result != *bytes?from* ]]; then
    echo "Network connection unavailable. Try again later."
    exit 1
fi

# Needed for nodejs.
# https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
curl -sSL https://deb.nodesource.com/setup_4.x | sudo -E bash -
add-apt-repository -y ppa:git-core/ppa

# Php7 repo
add-apt-repository ppa:ondrej/php

# Mysql 5.6
add-apt-repository -y ppa:ondrej/mysql-5.6

# Google Pagespeed
dpkg -i /vagrant/packages/mod-pagespeed-stable_current_amd64.deb
apt-get -f install

apt-get update
apt-get upgrade

echo "---------------------------------------"
echo "     Installing apt-get packages..."
echo "---------------------------------------"

apt_packages=(
    vim
    curl
    git-core
    nodejs
    libgmp3-dev
    apache2
    libapache2-mod-fastcgi
    apache2-mpm-worker
    default-jre
    default-jdk
)


apt-get install -y ${apt_packages[@]}
apt-get clean
sudo su apt-get clean


end_seconds="$(date +%s)"
echo "-----------------------------"
echo "Provisioning complete in "$(expr $end_seconds - $start_seconds)" seconds"
echo "You can now use 'less -S +F $log' to monitor Jekyll."