# Install rockthestreet81 shop as hidden_service

# Update the Mashine
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && apt-get autoremove -y 

# Install Apache2
sudo apt-get install apache2

# Download the shop Files...
git clone https://github.com/rockthestreet81/shop.git
cd /var/www/shop

# chmod shop.sh
sudo chmod +x install.sh

# Install Annularis
sudo ./install.sh

