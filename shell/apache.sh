echo "---------------------------------------"
echo "         Apache Setup"
echo "---------------------------------------"

# Installing Packages
#apt-get install -y apache2 libapache2-mod-fastcgi apache2-mpm-worker

# linking Vagrant directory to Apache 2.4 public directory
rm -rf /var/www
mkdir /vagrant/www
ln -fs /vagrant/www /var/www

# Add ServerName to httpd.conf
echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/servername.conf
# enable it by creating a symlink to it from the "enabled" section
a2enconf servername
# Setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot "/var/www/qz/_site"
  ServerName localhost
  <Directory "/var/www/qz/_site">
    AllowOverride All
  </Directory>
  #Include mods-available/deflate.conf
  #Include mods-available/pagespeed.conf
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-enabled/000-default.conf

sudo cp /vagrant/scripts/deflate.conf /etc/apache2/mods-available
sudo cp /vagrant/scripts/pagespeed.load /etc/apache2/mods-available
sudo cp /vagrant/scripts/pagespeed.conf /etc/apache2/mods-available

# Loading needed modules to make apache work
a2enmod actions fastcgi rewrite pagespeed deflate
service apache2 reload