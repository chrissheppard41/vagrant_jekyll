#!/bin/bash -xl

echo "---------------------------------------"
echo "         Ruby Setup"
echo "---------------------------------------"
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --quiet-curl
source ~/.rvm/scripts/rvm
rvm install 2.3.1 --quiet-curl
rvm use 2.3.1 --default
ruby --version


echo "---------------------------------------"
echo "        Jekyll Setup"
echo "---------------------------------------"
gem install jekyll

echo "---------------------------------------"
echo "        Bundle Setup"
echo "---------------------------------------"
gem install bundle