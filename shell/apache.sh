echo "---------------------------------------"
echo "         Apache Setup"
echo "---------------------------------------"

# Installing Packages
#apt-get install -y apache2 libapache2-mod-fastcgi apache2-mpm-worker

# linking Vagrant directory to Apache 2.4 public directory
rm -rf /var/www
ln -fs /vagrant/jekyll /var/www

# Add ServerName to httpd.conf
echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/servername.conf
# enable it by creating a symlink to it from the "enabled" section
a2enconf servername
# Setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot "/var/www/_site"
  ServerName localhost
  <Directory "/var/www/_site">
    AllowOverride All
  </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-enabled/000-default.conf

# Loading needed modules to make apache work
a2enmod actions fastcgi rewrite
service apache2 reload