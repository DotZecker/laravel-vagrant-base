#!/usr/bin/env bash

# Vamos a la Española
sed -i 's|//us\.\(archive\.ubuntu\)|//es.\1|g' /etc/apt/sources.list
sudo apt-get update

# MySQL: root/root
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

# Paquetes que podríamos usar
sudo apt-get install -y vim curl python-software-properties
sudo apt-get update

# Instalación de Apache, PHP, ...
sudo add-apt-repository -y ppa:ondrej/php5
sudo apt-get update
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt php5-readline mysql-server-5.5 php5-mysql git-core
sudo sed -i 's/APACHE_RUN_USER=.*/APACHE_RUN_USER=vagrant/g' /etc/apache2/envvars
sudo sed -i 's/APACHE_RUN_GROUP=.*/APACHE_RUN_GROUP=www-data/g' /etc/apache2/envvars

# Xdebug
sudo apt-get install -y php5-xdebug

cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

# Configuración del apache
sudo a2enmod rewrite
sudo rm -rf /var/www
sudo ln -fs /vagrant/public /var/www
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
sed -i "s/disable_functions = .*/disable_functions = /" /etc/php5/cli/php.ini
sudo service apache2 restart

# Metemos el composer por si lo queremos ejecutar desde la máquina
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
