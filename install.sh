#!/bin/bash
echo "== Are you Root??? =="
sudo su
sleep 3

echo "== Update the Mashine !!!!! ==" 
sleep 5
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && apt-get autoremove -y 


echo "== Setting up repo and in a few seconds you have to hit ENTER ==" 
sleep 5 
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update 


echo "== Install Dependency's !!! ==" 
sleep 5sudo 
sudo apt-get install -y apache2 mysql-server mysql-client libapache2-mod-php7.0 php7.0 php7.0-mcrypt php7.0-mbstring php7.0-gnupg php7.0-mysql php7.0-gmp php7.0-curl php7.0-bcmath php7.0-gd php7.0-fpm git curl git mcrypt curl unzip atool subversion 


echo "== Change Directory.. ==" 
sleep 3 
cd /var/www/
# sudo git clone https://github.com/annularis/shop
sudo chown www-data:www-data -Rv shop
cd shop/install

echo "== Enable a2enmod and restart apache / nginx..  =="
sleep 3
sudo a2enmod rewrite
sudo service apache2 restart

echo "== Install Bitcoin maybe you have to change version.. =="
sleep 3
cd /tmp
sudo wget https://bitcoin.org/bin/bitcoin-core-0.17.1/bitcoin-0.17.1-x86_64-linux-gnu.tar.gz
sudo aunpack bitcoin-0.17.1-x86_64-linux-gnu.tar.gz
cd bitcoin-0.17.1
sudo cp bin/* /usr/local/bin/


echo "== Start bitcoin... =="
sleep 3
sudo bitcoind -daemon -testnet -rpcport="7530" -rpcuser="bitcoinuser" -rpcpassword="bitcoinpass"


echo "== Setup Apache2...  =="
echo "=== Check after install if settings are correct.. ==="
echo "# change AllowOverride All for /var/www "
echo "## sudo nano /etc/apache2/apache2.conf "
echo "# change DocumentRoot to /var/www/shop "
echo "## sudo nano /etc/apache2/sites-enabled/000-default.conf "
sleep 8

echo "Setting up 'AllowOverride All' for /var/www"
sleep 2
sudo sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/apache2/apache2.conf
sudo service apache2 restart

echo "== Setting up Apache2 DocumentRoot.. =="
echo " check if still root.. "
sudo su
sleep 2
sudo grep -q "shop" /etc/apache2/sites-enabled/000-default.conf; then
sudo sed -i 's#/var/www/html#/var/www/shop#' /etc/apache2/sites-enabled/000-default.conf


echo "== Setup mysql database =="
sleep 3
# mysql database
sudo mysql
sudo mysql -e "CREATE DATABASE annularis;"
sudo mysql -e "CREATE USER annularis IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON annularis.* TO annularis@localhost IDENTIFIED BY 'password';"


echo "== Setup Database and Bitcoin.conf after Install this script..  =="
sleep 3
echo "# setup's for Annularis config's.. "
echo " sudo nano /var/www/shop/install/config/database.php  "
echo " sudo nano /var/www/shop/install/config/bitcoin.php  "
echo "Database Name = "annularis" "
echo "Database User = "annularis" "
echo "Database Host = "localhost" "

echo "Database Password = "password" "
echo "Bitcoinuser = "bitcoinuser" "
echo "Bitcoin Password = "bitcoinpass" "
echo "Bitcoin IP = "127.0.0.1" "
sleep 8

echo " copy htaccess.sample to .htaccess setup show setup instruction's "
echo "# comment out 'RewriteBase /shop' "
echo "## sudo nano .htaccess "
sleep 3
sudo cp htaccess.sample .htaccess

echo " Change Permissions of "config Files" "
sudo touch /var/www/shop/application/config/database.php && sudo chmod 777 /var/www/shop/application/config/database.php
sudo touch /var/www/shop/application/config/bitcoin.php && sudo chmod 777 /var/www/shop/application/config/bitcoin.php
sudo touch /var/www/shop/application/config/config.php && sudo chmod 777 /var/www/shop/application/config/config.php

echo " setting up nginx.. "
sudo service apache2 stop
sudo apt-get install nginx

echo " Prepare Annularis executor.. "
# prepare annularis executor user
groupadd annularis
useradd -g annularis annularis

echo " php7.0-fpm settings.. "
sudo cp /etc/php/7.0/fpm/pool.d/www.conf /etc/php/7.0/fpm/pool.d/annularis.conf
sudo nano /etc/php/7.0/fpm/pool.d/annularis.conf
echo " ## edit as following "
echo " # [annularis] "
echo " # user = annularis "
echo " # group = annularis "
echo " # listen = /var/run/php/php7.0-fpm-annularis.sock "
echo " # listen.owner = www-data "
echo " # listen.group = www-data "
echo " # php_admin_value[disable_functions] = exec,passthru,shell_exec,system "
echo " # php_admin_flag[allow_url_fopen] = off "

echo " set opache.ini "
sudo nano /etc/php/7.0/fpm/conf.d/10-opcache.ini
## edit as following
# opcache.enable=0

echo " Restart php7.0-fpm "
# restart php-fpm
sudo service php7.0-fpm restart

echo " Nginx setting's "
# nginx settting
cd /var/www/shop
sudo cp annularis-nginx.conf /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/annularis-nginx.conf /etc/nginx/sites-enabled/
service nginx restart

























