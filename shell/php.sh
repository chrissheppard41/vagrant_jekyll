#!/usr/bin/env bash

echo "---------------------------------------"
echo "         PHP Setup 7.0"
echo "---------------------------------------"

php_packages=(
    php7.0
    php7.0-cli
    php7.0-fpm
    php7.0-curl
    php7.0-mcrypt
    php7.0-xdebug
)

# Installing packages
apt-get install -y ${php_packages[@]}

# Creating the configurations inside Apache
cat > /etc/apache2/conf-available/php7.0-fpm.conf << EOF
<IfModule mod_fastcgi.c>
    AddHandler php7.0-fcgi .php
    Action php7.0-fcgi /php7.0-fcgi
    Alias /php7.0-fcgi /usr/lib/cgi-bin/php7.0-fcgi
    FastCgiExternalServer /usr/lib/cgi-bin/php7.0-fcgi -socket /var/run/php7.0-fpm.sock -pass-header Authorization

    # NOTE: using '/usr/lib/cgi-bin/php5-cgi' here does not work,
    #   it doesn't exist in the filesystem!
    <Directory /usr/lib/cgi-bin>
        Require all granted
    </Directory>

</IfModule>
EOF

# Enabling php modules
php7.0enmod mcrypt

# Triggering changes in apache
a2enconf php7.0-fpm
service apache2 reload

php --version