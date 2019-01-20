# Install 'rockthestreet81/shop' as Hidden-service

## Update the Machine
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && apt-get autoremove -y 

## Install Apache2 as Development Server
sudo apt-get install apache2

## Download the shop Files...
git clone https://github.com/rockthestreet81/shop.git
cd /var/www/shop

## chmod install.sh
sudo chmod +x install.sh

## Install Annularis with Apache for Development
sudo ./install.sh

## And follow the instruction's in Terminal

## after you do your configurations it's time to changing Server
sudo chmod +x install-nginx.sh

sudo ./install-nginx.sh

## and follow instructions
